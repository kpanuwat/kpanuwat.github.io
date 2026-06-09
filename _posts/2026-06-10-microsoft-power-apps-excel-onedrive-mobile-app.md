---
title: "สร้างแอปมือถือ Low-Code ใน 15 นาทีด้วย Microsoft Power Apps + Excel บน OneDrive"
date: 2026-06-09 00:04:00 +0700
categories: [Tools]
tags: [power-apps, low-code, no-code, excel, onedrive, microsoft, mobile, canvas-app]
slides: true
---

{% include slide-link.html %}

## TL;DR

Microsoft Power Apps ให้สร้างแอปมือถือจาก Excel บน OneDrive ได้ใน 15 นาที โดยไม่ต้องเขียนโค้ดแม้แต่บรรทัดเดียว ระบบ auto-gen หน้า browse/detail/edit ให้อัตโนมัติ รองรับค้นหา แก้ไข ลบ เพิ่มข้อมูล และถ่ายภาพบันทึกสู่คลาวด์ได้ทันที — ข้อจำกัดสำคัญ: ต้องปิด Excel ก่อนใช้งานแอปทุกครั้ง

## Background / Why this matters

องค์กรส่วนใหญ่มี Excel spreadsheet กระจายอยู่ตามทีมงานนับไม่ถ้วน ข้อมูล inventory, ทะเบียนลูกค้า, บันทึกการตรวจ — ทุกอย่างอยู่ใน `.xlsx` ที่ใครๆ รู้จัก แต่การแชร์ไฟล์ผ่าน email หรือ SharePoint ยังมีปัญหา: แก้ไขซ้อนกัน, version ไม่ตรงกัน, mobile access ยุ่งยาก

Power Apps (Canvas App) แก้ปัญหานี้โดยเปลี่ยน Excel table ให้กลายเป็นแอปมือถือที่ใช้งานได้บน iOS/Android ภายใน 15 นาที โดยไม่ต้องมีทักษะ programming เลย ทำให้ทีม non-IT สามารถ "deploy" แอปของตัวเองได้จริง

Power Platform ecosystem ประกอบด้วย Power Apps (build), Power Automate (automate), Power BI (analyze), Dataverse (store) — Canvas App + Excel connector เป็นจุดเข้าที่ง่ายที่สุดในระบบนี้

## Deep Dive

### สามวิธีใช้ Excel กับ Power Apps

| วิธี | ข้อดี | เมื่อใช้ |
|------|--------|----------|
| **Upload to Dataverse** | Cloud-native, secure, reusable | ต้องการ scalability + multi-app |
| **Excel Online (Business) connector** | ไฟล์ยังอยู่ OneDrive, สร้างเร็ว | prototype, team tool, 1 app |
| **Blank canvas + manual wiring** | Flexible สูงสุด | ต้องการ custom UI |

วิธีที่ 2 คือสิ่งที่วิดีโอนี้สอน — เร็วที่สุด เหมาะกับการเริ่มต้น

### Excel Connector: สิ่งที่ต้องรู้

**ข้อกำหนดเบื้องต้น:**
- ข้อมูลใน Excel ต้องจัดเป็น **Table** (ไม่ใช่แค่ range) — `Insert → Table` ใน Excel
- ไฟล์ต้องอยู่บน **OneDrive for Business** หรือ **OneDrive (Personal)** หรือ cloud storage อื่น
- ไม่รองรับไฟล์บน local drive

**Power Apps auto-generates 3 screens:**
1. **Browse screen** — แสดง list ทุก record พร้อม search box + sort
2. **Detail screen** — ดูข้อมูลรายละเอียดของ record ที่เลือก
3. **Edit screen** — แก้ไข/เพิ่ม/ลบ record

**ฟีเจอร์ที่ใช้ได้ทันที:**
- **Search** — `Search(TableName, SearchBox.Text, "ColumnName")`
- **Sort** — ascending/descending by any column
- **Add** — เพิ่ม record ใหม่ผ่าน form auto-gen
- **Edit** — แก้ไข record ที่มีอยู่
- **Delete** — ลบ record (Trash icon บน edit screen)
- **Camera** — `Camera` control เพื่อถ่ายภาพ แล้ว patch ลง Excel column ที่ชื่อ `Image [image]`

### การจัดการ Image column

ถ้าต้องการให้ Power Apps bind camera control กับ Excel column อัตโนมัติ ต้องตั้งชื่อ header ใน Excel เป็นรูปแบบ `FieldName [image]` เช่น `Photo [image]` — Power Apps จะรู้จักและสร้าง image control ให้อัตโนมัติ

### Excel Key Formulas ที่ Power Apps ใช้

```powerfx
// Browse screen gallery formula (auto-generated)
SortByColumns(
    Search(
        Schedule,
        TextSearchBox1.Text,
        "Volunteer"
    ),
    "Volunteer",
    If(SortDescending1, SortOrder.Descending, SortOrder.Ascending)
)

// Add new record
NewForm(EditForm1); Navigate(ChangeScreen, ScreenTransition.None)

// Save record
SubmitForm(EditForm1); Navigate(ViewScreen, ScreenTransition.None)

// Delete record
Remove(Schedule, BrowseGallery1.Selected); Navigate(ViewScreen, ScreenTransition.None)

// Refresh data
Refresh(Schedule)
```

### Connector Comparison: OneDrive vs Excel Online (Business)

| Feature | OneDrive for Business connector | Excel Online (Business) connector |
|---------|--------------------------------|----------------------------------|
| Max file size | ~2 MB | 50 MB |
| Max rows | ~2,000 | 64,000 |
| File lock error | พบบ่อย | น้อยกว่า |
| Extra column | เพิ่ม `__PowerAppsId__` | ไม่เพิ่ม |
| Recommended | ❌ | ✅ |

ถ้าเริ่มใหม่ ให้ใช้ **Excel Online (Business)** connector แทน OneDrive for Business

## User Guide (Step-by-Step)

### ขั้นตอนที่ 1: เตรียม Excel

1. เปิด Excel, ใส่ข้อมูลในแถวแรกเป็น header (เช่น `Name`, `Phone`, `Status`, `Photo [image]`)
2. เลือกข้อมูลทั้งหมด → `Insert → Table → My table has headers ✓ → OK`
3. (ตั้งชื่อ Table ที่ Name Box: เช่น `CustomerList`)
4. บันทึกไฟล์ → **ปิดไฟล์** (สำคัญมาก — ดูส่วน Caveats)
5. อัปโหลดหรือบันทึกไว้บน OneDrive for Business

### ขั้นตอนที่ 2: สร้าง App

1. เปิด [make.powerapps.com](https://make.powerapps.com)
2. Home → **Start with data** → **Excel Online (Business)**
3. เลือก connection → เลือกไฟล์ Excel → เลือก Table
4. คลิก **Create app** — รอประมาณ 30-60 วินาที
5. Power Apps Studio เปิดขึ้นพร้อม 3 screens auto-generated

### ขั้นตอนที่ 3: ทดสอบและปรับแต่ง

1. กด **F5** หรือ ▶ (Preview) เพื่อทดสอบ
2. ลอง search, add, edit, delete ดู
3. ปรับ layout: Properties pane → **Layout** → เลือกแบบที่ต้องการ
4. เพิ่ม Camera: `Insert → Media → Camera` ใน edit screen

### ขั้นตอนที่ 4: Publish และแชร์

1. **File → Save** → ตั้งชื่อ app
2. **File → Publish** → Publish this version
3. แชร์: **File → Share** → ใส่ email ของผู้ใช้
4. ผู้ใช้ติดตั้ง **Microsoft Power Apps** app บน iOS/Android แล้วล็อกอิน

### Troubleshooting

| อาการ | สาเหตุ | แก้ไข |
|-------|--------|--------|
| "Tables didn't load correctly" | ไฟล์ Excel เปิดอยู่ | ปิด Excel ก่อน |
| "Requested resource is locked" | User อื่นเปิดไฟล์อยู่ | รอหรือเปลี่ยนเป็น Dataverse |
| ข้อมูลไม่ update | Cache เก่า | เพิ่ม `Refresh(TableName)` ที่ OnSelect |
| Column ไม่ขึ้น | ไม่ได้ format เป็น Table | กลับไปแก้ Excel ให้เป็น Table |

## Caveats / Limits

**ข้อจำกัดสำคัญที่สุด: ต้องปิด Excel ขณะใช้งาน App**
Excel Online lock ไฟล์เมื่อมีคนเปิดอยู่ ถ้า Power Apps พยายามอ่าน/เขียนขณะไฟล์ถูก lock จะ error ทันที — นี่คือ limitation ที่ Microsoft ยังไม่ได้แก้ใน Excel connector

**ข้อจำกัดอื่นๆ:**
- **Row limit:** Excel Online (Business) รองรับสูงสุด 64,000 rows — เกินนี้ใช้ Dataverse
- **No calculated columns:** column ที่มี formula ใน Excel จะใช้ใน Power Apps ไม่ได้
- **No multi-column filter:** Excel connector ไม่ support `Filter(Table, Col1=X, Col2=Y)` แบบ native
- **No date filter:** Date column filter ไม่ทำงานใน Excel connector
- **Multi-user write conflicts:** ถ้าหลายคนเขียนพร้อมกัน อาจเกิด race condition — ไม่เหมาะกับ high-concurrency
- **Auto-added column:** OneDrive connector จะเพิ่ม `__PowerAppsId__` ใน Excel โดยอัตโนมัติ
- **Not for production at scale:** Excel connector เหมาะ prototype/small team — production ที่จริงจังควรย้ายไป Dataverse หรือ SharePoint List

## References

1. [Create a canvas app based on Excel data — Microsoft Learn](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/connections/connection-excel)
2. [Connect to cloud-storage from Power Apps — Microsoft Learn](https://learn.microsoft.com/en-us/power-apps/maker/canvas-apps/connections/cloud-storage-blob-connections)
3. [Excel Online (Business) connector — Microsoft Learn](https://learn.microsoft.com/en-us/connectors/excelonlinebusiness/)
4. [Power Apps Excel connector limitations — TechTarget](https://www.techtarget.com/searchcontentmanagement/tip/What-are-the-top-Microsoft-Power-Apps-limitations)
5. [Connect to Excel in OneDrive: OneDrive vs Excel Online connector — Debajit's Blog](https://debajmecrm.com/connect-to-excel-in-one-drive-from-power-apps-canvas-apps-connect-using-excel-online-business-connector-instead-of-onedrive-for-business-connector/)
6. [Excel Online Business connector deep-dive — Power Apps Guide](https://powerappsguide.com/blog/post/how-to-use-excel-online-business-connector)
7. [สร้าง App จาก Excel ใน 5 ขั้นตอน — HakoIT](https://www.hakoit.com/en/create-an-app-with-excel-in-5-steps-powerapps-tutorial/)
8. [วิดีโอต้นฉบับ: สร้างแอปมือถือด้วย Power Apps + Excel — YouTube](https://youtu.be/xa0hHrtHR84)

## Key Takeaways

- **Auto-gen 3 screens** — Power Apps สร้างหน้า browse/detail/edit ให้ทันทีจาก Excel table โดยไม่ต้องเขียนโค้ด
- **Excel ต้องเป็น Table** — format เป็น Table ก่อนเชื่อมต่อ ไม่งั้น Power Apps อ่านไม่ได้
- **ปิด Excel ก่อนใช้งาน** — Excel lock ไฟล์ขณะเปิด → Power Apps error; ต้องปิด Excel ทุกครั้งก่อนรันแอป
- **Excel Online (Business) > OneDrive connector** — รองรับได้ถึง 64K rows / 50MB, error น้อยกว่า
- **ถ่ายภาพตรงสู่คลาวด์** — ตั้งชื่อ column เป็น `Photo [image]` แล้ว Power Apps จะ bind Camera control ให้อัตโนมัติ
- **Prototype → Dataverse** — Excel connector เหมาะ small team (<2,000 rows ปลอดภัยดี); ถ้าจะ scale หรือ multi-user จริงจัง → ย้ายไป Dataverse
- **ใช้งานได้ใน Microsoft 365 license** — ไม่ต้องซื้อ Power Apps premium สำหรับ Excel + OneDrive use case ในองค์กรที่มี M365 แล้ว
