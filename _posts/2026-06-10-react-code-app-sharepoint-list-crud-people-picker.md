---
title: "สร้าง React Code App เชื่อม SharePoint List 10,000 แถว: Server-side Pagination, CRUD & People Picker ด้วย Claude Code"
date: 2026-06-09 00:03:00 +0700
categories: [Engineering]
tags: [react, sharepoint, spfx, crud, pagination, people-picker, office365, power-apps, claude-code]
---

## TL;DR

ถ้าองค์กรคุณเก็บข้อมูลใน SharePoint List หลักหมื่นแถว และอยากสร้างหน้าจอ React ที่ดึง-กรอง-เรียง-แก้ไขข้อมูลได้ครบ บทความนี้สรุปแนวทางทั้งหมด: ตั้งแต่ตั้ง SPFx ใน VS Code, ใช้ Claude Code ช่วยเขียน UI, จัดการ Pagination แบบ Server-side ด้วย `$skipToken`, ทำ People Picker ดึงผู้ใช้จาก Office 365 พร้อมรูปโปรไฟล์ ไปจนถึง Push ขึ้น Power Apps ให้ทั้งองค์กรใช้

## Background / Why this matters

### ปัญหาของ Power Automate / Default List View

SharePoint List คือฐานข้อมูลที่ทีม IT มักใช้เก็บข้อมูลงาน, สินค้าคงคลัง, ทะเบียนพนักงาน ฯลฯ แต่หน้าจอ Default List View ของ SharePoint จำกัดความยืดหยุ่น เช่น ไม่รองรับ Custom Validation แบบซับซ้อน, UI ไม่ตรงกับ Branding องค์กร, และ Performance แย่เมื่อข้อมูลเกิน 5,000 แถว (SharePoint List View Threshold)

**Code Apps** (SPFx Web Part ที่เขียนด้วย React) แก้ปัญหาทั้งหมดนี้ได้ใน package เดียว แล้ว Deploy ผ่าน Power Apps ให้ทั้งองค์กรเข้าถึงบน Desktop/Mobile ได้ทันที

### ทำไมต้อง Claude Code?

ก่อนยุค AI, เขียน SPFx Web Part ที่มี Pagination + Filter + People Picker ใช้เวลาหลายวัน ต้องรู้ OData syntax, `@microsoft/sp-http`, `@pnp/spfx-controls-react` API ทั้งหมด ตอนนี้ Claude Code อ่าน code context ของโปรเจกต์แล้วช่วย generate UI component, fix TypeScript errors, และ refactor ได้ในไม่กี่นาที

## Deep Dive

### 1. ตั้งค่า SPFx Development Environment (2026)

**System requirements (2026):**
- Node.js v22.12.0+ LTS
- SPFx v1.23+ (`@microsoft/spfx-cli`)
- VS Code 1.95+
- React 18, Fluent UI v9 (`@fluentui/react-components`)

> ⚠️ SPFx Online Workbench จะถูก retire วันที่ 1 ธันวาคม 2026 — ให้ใช้ **SharePoint Debug Toolbar** แทนตั้งแต่ตอนนี้

```bash
# ติดตั้ง SPFx CLI (แทน Yeoman เดิม)
npm install @microsoft/spfx-cli --global

# สร้างโปรเจกต์ใหม่
spfx new --name my-list-app --type webpart --framework react

# เปิด VS Code
code my-list-app
```

**VS Code Extensions ที่แนะนำ:**
- **SPFx Toolkit** (pnp.vscode-viva) — scaffold, deploy, manage package ใน sidebar เดียว
- **ESLint** — เพราะ SPFx มี rule เฉพาะสำหรับ SharePoint
- **Claude Code** (ถ้า install CLI แล้ว) — รัน `claude` ใน terminal ในโฟลเดอร์โปรเจกต์

### 2. เชื่อมต่อ SharePoint List ด้วย SPHttpClient

SPFx ให้ `SPHttpClient` ผ่าน `this.context.spHttpClient` เพื่อเรียก SharePoint REST API โดยไม่ต้องจัดการ Auth เอง

```typescript
// src/services/ListService.ts
import { SPHttpClient } from '@microsoft/sp-http';

export interface IListItem {
  Id: number;
  Title: string;
  Status: string;
  AssignedTo: string;  // เก็บ LoginName ของผู้ใช้
  Modified: string;
}

export interface IPageResult {
  items: IListItem[];
  nextLink: string | null;
}

export async function getListPage(
  spHttpClient: SPHttpClient,
  siteUrl: string,
  listName: string,
  pageSize = 100,
  nextLink: string | null = null,
  filter = '',
  orderBy = 'Modified',
  ascending = false
): Promise<IPageResult> {
  let url = nextLink;

  if (!url) {
    const params = [
      `$top=${pageSize}`,
      `$select=Id,Title,Status,AssignedTo,Modified`,
      `$orderby=${orderBy} ${ascending ? 'asc' : 'desc'}`,
    ];
    if (filter) params.push(`$filter=${encodeURIComponent(filter)}`);

    url = `${siteUrl}/_api/web/lists/getbytitle('${listName}')/items?${params.join('&')}`;
  }

  const res = await spHttpClient.get(url, SPHttpClient.configurations.v1);
  const json = await res.json();

  return {
    items: json.value,
    // odata.nextLink มาพร้อม $skipToken — ไม่ใช้ $skip เพราะ SharePoint ไม่รองรับ $skip สำหรับ List Items
    nextLink: json['odata.nextLink'] ?? null,
  };
}
```

**สำคัญมาก — `$skip` ใช้ไม่ได้กับ SharePoint List Items**

SharePoint REST API ไม่รองรับ `$skip` สำหรับ List Items (แตกต่างจาก OData มาตรฐาน) ต้องใช้ `$skipToken` จาก `odata.nextLink` ที่ API คืนมาแทน ถ้าเอา `$skip=100` ใส่เอง query จะ return ผลลัพธ์ผิดหรือ error

### 3. Server-side Filter & Sort

กรองและเรียงข้อมูลบน server ไม่ใช่ client เพราะมี 10,000 แถว — ดึงมาทั้งหมดแล้วกรองใน browser จะช้ามาก

```typescript
// ตัวอย่าง OData filter syntax
const filters = {
  // เท่ากับ
  exact: `Status eq 'Active'`,
  // contains (ต้องใช้ substringof หรือ startswith)
  search: `substringof('${keyword}', Title)`,
  // วันที่
  dateRange: `Modified ge datetime'${fromDate}' and Modified le datetime'${toDate}'`,
  // หลายเงื่อนไข
  combined: `Status eq 'Active' and substringof('${keyword}', Title)`,
};

// Sort: ใส่ใน $orderby ตอน build URL แรก
// ถ้า sort column เปลี่ยน ต้องล้าง nextLink ทิ้งแล้ว fetch หน้า 1 ใหม่
```

**React state สำหรับ pagination:**
```tsx
const [items, setItems] = useState<IListItem[]>([]);
const [nextLink, setNextLink] = useState<string | null>(null);
const [prevLinks, setPrevLinks] = useState<string[]>([]);  // stack สำหรับ "ก่อนหน้า"
const [loading, setLoading] = useState(false);

async function loadPage(link: string | null, isNext: boolean) {
  setLoading(true);
  const result = await getListPage(spHttpClient, siteUrl, listName, 100, link, filter, orderBy, asc);
  setItems(result.items);
  setNextLink(result.nextLink);
  setLoading(false);
}
```

### 4. People Picker — เลือกผู้ใช้จาก Office 365

ใช้ `PeoplePicker` จาก `@pnp/spfx-controls-react` ซึ่งค้นหาผู้ใช้จาก Azure AD / Exchange ผ่าน SharePoint Search

```bash
npm install @pnp/spfx-controls-react @pnp/sp @pnp/graph
```

```tsx
import { PeoplePicker, PrincipalType } from '@pnp/spfx-controls-react/lib/PeoplePicker';

<PeoplePicker
  context={this.props.context as any}
  titleText="Assigned To"
  personSelectionLimit={1}
  principalTypes={[PrincipalType.User]}
  onChange={(items) => {
    const loginName = items[0]?.loginName ?? '';
    setAssignedTo(loginName);
  }}
  resolveDelay={500}
/>
```

**แสดงรูปโปรไฟล์ด้วย Graph API:**
```tsx
import { graphfi } from '@pnp/graph';
import '@pnp/graph/users';
import '@pnp/graph/photos';

// URL รูปโปรไฟล์ขนาด 48x48
const getPhotoUrl = async (loginName: string): Promise<string> => {
  try {
    const graph = graphfi().using(SPFx(this.context));
    const blob = await graph.users.getById(loginName).photo.getBlob();
    return URL.createObjectURL(blob);
  } catch {
    // ถ้าไม่มีรูป ใช้ initials avatar แทน
    return '';
  }
};
```

### 5. CRUD Operations

```typescript
// CREATE
async function createItem(spHttpClient: SPHttpClient, siteUrl: string, listName: string, data: Partial<IListItem>) {
  return spHttpClient.post(
    `${siteUrl}/_api/web/lists/getbytitle('${listName}')/items`,
    SPHttpClient.configurations.v1,
    {
      headers: { 'Content-Type': 'application/json;odata=nometadata' },
      body: JSON.stringify(data),
    }
  );
}

// UPDATE
async function updateItem(spHttpClient: SPHttpClient, siteUrl: string, listName: string, id: number, data: Partial<IListItem>) {
  return spHttpClient.post(
    `${siteUrl}/_api/web/lists/getbytitle('${listName}')/items(${id})`,
    SPHttpClient.configurations.v1,
    {
      headers: {
        'Content-Type': 'application/json;odata=nometadata',
        'IF-MATCH': '*',
        'X-HTTP-Method': 'MERGE',
      },
      body: JSON.stringify(data),
    }
  );
}

// DELETE
async function deleteItem(spHttpClient: SPHttpClient, siteUrl: string, listName: string, id: number) {
  return spHttpClient.post(
    `${siteUrl}/_api/web/lists/getbytitle('${listName}')/items(${id})`,
    SPHttpClient.configurations.v1,
    {
      headers: { 'IF-MATCH': '*', 'X-HTTP-Method': 'DELETE' },
      body: '',
    }
  );
}
```

### 6. ใช้ Claude Code เร่งการพัฒนา

Claude Code อ่าน codebase ทั้งหมดใน context — ทำให้ prompt สั้นและตรงประเด็นได้:

```bash
# เปิด Claude Code ในโฟลเดอร์โปรเจกต์
claude

# ตัวอย่าง prompt ที่ได้ผล
> สร้าง DataGrid component ที่ใช้ Fluent UI DetailsList แสดง items[], 
  รับ onSort callback ส่ง column+direction กลับ, 
  รับ onPageChange callback ส่ง direction:'next'|'prev' กลับ

> เพิ่ม inline Edit mode ใน DataGrid ให้ double-click แถวแล้วแสดง 
  TextField แทนที่ text ใน column ที่ editable=true

> fix TypeScript error ใน PeoplePicker: 
  "Property 'context' does not exist on type..."
```

**Claude Code เหมาะกับงานแบบไหน:**
- Generate boilerplate component ที่มี pattern ชัดเจน
- Fix TypeScript / ESLint errors (วาง error message ตรงๆ)
- Refactor: แยก logic ออกจาก component, สร้าง custom hook
- เขียน unit test สำหรับ service function

**ควรตรวจสอบเอง:**
- Permission / Graph API scope (ต้องขอ consent จาก Azure AD Admin)
- SharePoint-specific quirks เช่น `$skip` vs `$skipToken`
- การ handle List View Threshold (5,000 items) กรณี filter ไม่ indexed column

### 7. Deploy ขึ้น Power Apps

SPFx Web Part สามารถ embed เข้า Power Apps ผ่าน **Custom Page** หรือ **PowerApps Component Framework (PCF)** แต่วิธีที่ง่ายที่สุดคือ deploy ผ่าน SharePoint App Catalog แล้วเปิดใช้ใน site

```bash
# Build production bundle
npm run build

# Package
npm run package-solution

# Upload .sppkg ไปที่ App Catalog ใน SharePoint Admin Center
# แล้ว Deploy → Add to site
```

**เส้นทาง Power Apps:**
1. SharePoint Admin → App Catalog → Upload `.sppkg` → Deploy (make available to all sites)
2. ใน Power Apps Studio → Insert → SharePoint → เลือก site + Web Part
3. หรือสร้าง Canvas App → ใช้ SharePoint connector เชื่อม List โดยตรง (ไม่ต้อง embed SPFx)

## User Guide (Step-by-Step)

### Step 1: ตั้ง Environment

```bash
# ติดตั้ง Node 22 LTS (แนะนำใช้ nvm)
nvm install 22 && nvm use 22

# ติดตั้ง SPFx CLI
npm install @microsoft/spfx-cli --global

# สร้างโปรเจกต์
spfx new --name sharepoint-list-app --type webpart --framework react
cd sharepoint-list-app
npm install

# ติดตั้ง dependencies เพิ่มเติม
npm install @pnp/spfx-controls-react @pnp/sp @pnp/graph
```

### Step 2: เปิด Claude Code และ Scaffold Component

```bash
claude
```

Prompt แรก:
```
โปรเจกต์นี้คือ SPFx v1.23 React webpart เชื่อม SharePoint List ชื่อ "Projects"
ที่มี columns: Id, Title, Status (Active/Inactive), AssignedTo (loginName), Modified

สร้าง src/services/ListService.ts สำหรับ fetch items แบบ paginated 100 ต่อหน้า
ใช้ SPHttpClient, รองรับ server-side filter (OData) และ orderby
คืน {items, nextLink} — ใช้ $skipToken ไม่ใช้ $skip
```

### Step 3: สร้าง DataGrid พร้อม Pagination Bar

```
สร้าง src/components/ProjectGrid.tsx ใช้ Fluent UI v9 DataGrid
แสดง columns: Title, Status (Badge), AssignedTo (Persona), Modified (วันที่ไทย)
มีปุ่ม "ก่อนหน้า" / "ถัดไป" ด้านล่าง และ loading spinner ระหว่างโหลด
รับ props: items[], hasNext, hasPrev, onNext, onPrev, onSort
```

### Step 4: เพิ่ม Filter Bar

```
เพิ่ม FilterBar component ด้านบน ProjectGrid
มี: SearchBox (filter Title), Dropdown (Status), DatePicker range (Modified)
เมื่อค่าเปลี่ยน ให้ build OData $filter string แล้ว call onFilterChange(filterStr)
```

### Step 5: เพิ่ม PeoplePicker ใน Edit Form

```
สร้าง EditItemPanel.tsx เป็น Fluent UI Panel ด้านขวา
เมื่อ double-click แถวใน ProjectGrid เปิด Panel
มี TextField สำหรับ Title, Dropdown สำหรับ Status
มี PeoplePicker จาก @pnp/spfx-controls-react สำหรับ AssignedTo
มีปุ่ม Save (call updateItem) และ Delete (confirm ก่อน call deleteItem)
```

### Step 6: Test และ Debug

```bash
# รัน dev server (ต้องมี SharePoint tenant)
npm run serve

# เปิด browser ไปที่ SharePoint site + ?debug=true&noredir=true&debugManifestsFile=...
# หรือใช้ SharePoint Debug Toolbar (workbench ถูก deprecate แล้ว)
```

### Step 7: Build และ Deploy

```bash
npm run build
npm run package-solution
# Upload sharepoint/solution/*.sppkg ไปที่ App Catalog
```

## Caveats / Limits

- **List View Threshold (5,000 items):** ถ้า `$filter` ใช้ column ที่ไม่ได้ index ไว้ และ List มีแถวเกิน 5,000 แถว SharePoint จะ return 500 error — ต้อง index column ที่ filter บ่อยไว้ก่อน (List Settings → Indexed Columns)
- **`$skip` ไม่ทำงาน:** ห้ามสร้าง `$skip=N` เอง — ใช้ `odata.nextLink` ที่ API คืนมาเท่านั้น
- **Graph API Consent:** การดึงรูปโปรไฟล์ใช้ `User.ReadBasic.All` — ต้องให้ Azure AD Admin grant consent ใน app manifest (`package-solution.json` → `webApiPermissionRequests`)
- **SPFx Workbench Deprecation:** Online Workbench จะถูกปิด 1 ธ.ค. 2569 — migrate ไปใช้ Debug Toolbar ตั้งแต่ตอนนี้
- **Claude Code ไม่รู้ SharePoint quirks:** ต้อง prompt ระบุข้อจำกัดเฉพาะ (เช่น `$skip` ใช้ไม่ได้) ไม่งั้น Claude อาจ generate code ตาม OData มาตรฐานที่ใช้ไม่ได้จริง
- **Power Apps embed ข้อจำกัด:** Canvas App + SharePoint connector เหมาะถ้าไม่ต้องการ custom UI ซับซ้อน ถ้าต้องการ UI เต็มรูปแบบ ควร deploy SPFx ใน SharePoint Page แล้วแชร์ link ผ่าน Power Apps แทน

## References

1. [Build your first SPFx client-side web part — Microsoft Learn](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/web-parts/get-started/build-a-hello-world-web-part)
2. [Debug SharePoint Framework solutions in Visual Studio Code — Microsoft Learn](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/debug-in-vscode)
3. [Use OData query operations in SharePoint REST requests — Microsoft Learn](https://learn.microsoft.com/en-us/sharepoint/dev/sp-add-ins/use-odata-query-operations-in-sharepoint-rest-requests)
4. [Pagination in SharePoint REST using $top and $skipToken — Working Man's SharePoint](https://joemcshea.intellipointsolutions.com/pagination-in-sharepoint-rest-requests-using-top-and-skiptoken/)
5. [PeoplePicker — @pnp/spfx-controls-react](https://pnp.github.io/sp-dev-fx-controls-react/controls/PeoplePicker/)
6. [How to use Microsoft Graph Toolkit React PeoplePicker in SPFx — PnP Blog](https://pnp.github.io/blog/post/how-to-use-microsoft-graph-toolkit-react-people-picker-control/)
7. [SPFx Toolkit VS Code Extension v3.0 — PnP Blog](https://pnp.github.io/blog/post/spfx-toolkit-vscode-v-3-0-release/)
8. [วิดีโอต้นฉบับ: สร้าง React Code App + SharePoint List — YouTube](https://youtu.be/yFlCTonaLt8)

## Key Takeaways

- **SPFx คือ bridge:** เขียน React ตามปกติ แต่วิ่งใน SharePoint context — Auth, Permissions, และ API ทำให้ครบโดย `SPHttpClient` และ `MSGraphClient`
- **`$skipToken` ไม่ใช่ `$skip`:** SharePoint List Items Pagination ต้องใช้ `odata.nextLink` จาก response — สร้าง `$skip` เองทำให้ผลลัพธ์ผิด
- **Index ก่อน Filter:** column ที่จะ filter ต้องถูก index ใน List Settings ก่อน ไม่งั้น Threshold 5,000 แถวจะ block
- **Claude Code ช่วยได้มากถ้า prompt ระบุ context:** บอก framework version, column names, quirks (เช่น `$skip` ใช้ไม่ได้) ในครั้งแรก — Claude จะ generate ถูกตั้งแต่รอบแรก
- **People Picker สองแนวทาง:** PnP (`@pnp/spfx-controls-react`) ง่ายกว่า, MGT (`@microsoft/mgt-react`) flexible กว่า — เลือกตาม requirement ของทีม
- **Deploy ทาง App Catalog:** upload `.sppkg` แล้ว enable ใน site คือทางที่ scalable ที่สุดสำหรับองค์กร
- **Claude ไม่ใช่ silver bullet:** ต้องรู้ SharePoint-specific constraints ก่อน ถึงจะ prompt ถูก — เทคนิคนี้คือ "AI-augmented developer" ไม่ใช่ "AI replace developer"
