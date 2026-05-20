// Converts ```mermaid fences to <pre class="mermaid"> for client-side rendering.
// Mermaid.js must be loaded in the deck (see _slides/.deck-template.md).
const { Marp } = require('@marp-team/marp-core')

module.exports = (opts) => {
  const marp = new Marp({ ...opts, html: true })
  const md = marp.markdown
  const baseFence = md.renderer.rules.fence?.bind(md.renderer.rules)
  md.renderer.rules.fence = (tokens, idx, options, env, self) => {
    const token = tokens[idx]
    if (token.info.trim() === 'mermaid') {
      return `<pre class="mermaid">\n${token.content}</pre>\n`
    }
    return baseFence ? baseFence(tokens, idx, options, env, self)
      : self.renderToken(tokens, idx, options)
  }
  return marp
}
