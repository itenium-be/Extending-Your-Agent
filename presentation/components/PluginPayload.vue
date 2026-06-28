<!--
  "What one /plugin install actually wires up" — the tutorial plugin unpacks into
  every extension primitive at once. Tiles cascade in on mount. Presentational only.
-->
<template>
  <div class="pp">
    <div class="pp__head">
      <span class="pp__pkg">📦 extending-your-agent-tutorial</span>
      <span class="pp__arrow">→</span>
      <span class="pp__cap">one install, wired into everything</span>
    </div>

    <div class="pp__grid">
      <template v-for="(t, i) in tiles" :key="t.name">
        <div
          class="pp__tile" :class="{ 'pp__tile--star': t.featured }"
          :style="{ '--accent': t.c, animationDelay: `${i * 110}ms` }"
        >
          <span class="pp__icon">{{ t.icon }}</span>
          <span class="pp__name">{{ t.name }}</span>
          <span class="pp__file">{{ t.file }}</span>
          <span v-if="t.badge" class="pp__badge">{{ t.badge }}</span>
          <span class="pp__check">✓</span>
        </div>
        <div v-if="i === 3" class="pp__break" aria-hidden="true" />
      </template>
    </div>
  </div>
</template>

<script setup>
const tiles = [
  { icon: '🎯', name: 'Skills',     file: 'skills/*/SKILL.md',      c: '#f5b51e', badge: 'prime primitive', featured: true },
  { icon: '🤖', name: 'Agents',     file: 'agents/*.md',            c: '#4ade80', badge: 'isolation' },
  { icon: '🪝', name: 'Hooks',      file: 'hooks/hooks.json',       c: '#ff7a1c', badge: 'deterministic' },
  { icon: '👁️', name: 'Monitors',   file: 'monitors/monitors.json', c: '#ffd23f', badge: 'experimental' },
  { icon: '🔌', name: 'MCP',        file: '.mcp.json',              c: '#2ec4b6' },
  { icon: '🧠', name: 'LSP',        file: '.lsp.json',              c: '#4d96ff' },
  { icon: '⚙️', name: 'Settings',   file: 'settings.json',          c: '#9b5de5' },
  { icon: '📦', name: 'Dependency', file: 'figlet-text-converter',  c: '#ff4d80' },
]
</script>

<style scoped>
.pp { width: 100%; max-width: 900px; margin: 0 auto; font-family: 'IBM Plex Mono', monospace; }

.pp__head {
  display: flex; align-items: center; gap: .7rem; flex-wrap: wrap;
  margin-bottom: 1.1rem; font-size: .92rem;
}
.pp__pkg { color: var(--color-text-dark, #1c2330); font-weight: 700; }
.pp__arrow { color: #6f7689; }
.pp__cap { color: #8b93a7; font-style: italic; }

.pp__grid {
  display: flex; flex-wrap: wrap; justify-content: center; gap: .7rem;
}
.pp__break { flex-basis: 100%; height: 0; }

.pp__tile {
  position: relative; flex: 0 0 205px; box-sizing: border-box;
  display: flex; flex-direction: column; gap: .2rem;
  padding: 1rem 1rem 1.05rem 1.1rem; border-radius: 12px;
  background: rgba(20, 24, 33, .9);
  border: 1px solid #262b36; border-left: 3px solid var(--accent);
  box-shadow: 0 10px 26px rgba(0, 0, 0, .35);
  animation: pp-pop .5s cubic-bezier(.18, .89, .32, 1.28) both;
}
.pp__tile::after {
  content: ''; position: absolute; inset: 0; border-radius: 12px; pointer-events: none;
  box-shadow: inset 0 0 22px -6px var(--accent); opacity: .5;
}
@keyframes pp-pop { from { opacity: 0; transform: translateY(14px) scale(.94); } }

.pp__icon { font-size: 1.6rem; line-height: 1; }
.pp__name { color: #f4f5f7; font-weight: 700; font-size: 1.05rem; }
.pp__file { color: #7b8094; font-size: .72rem; }
.pp__badge {
  align-self: flex-start; margin-top: .45rem;
  padding: .15rem .55rem; border-radius: 999px;
  font-size: .62rem; font-weight: 700; letter-spacing: .1em; text-transform: uppercase;
  color: var(--accent); background: color-mix(in srgb, var(--accent) 16%, transparent);
  border: 1px solid color-mix(in srgb, var(--accent) 55%, transparent);
}
.pp__check {
  position: absolute; top: .8rem; right: .9rem;
  color: var(--accent); font-weight: 700; font-size: .95rem;
  filter: drop-shadow(0 0 6px var(--accent));
}

/* Skills — the prime primitive: a static rainbow border, calm readable interior 🌈 */
/* single tile, rainbow gradient painted into the border itself — no layer behind */
.pp__tile--star {
  border: 2px solid transparent; box-shadow: none;
  background:
    linear-gradient(#12151d, #12151d) padding-box,
    linear-gradient(120deg, #ff6b6b, #ffb04d, #ffe066, #4fd1c0, #6aa8ff, #b388ff, #ff7eb0) border-box;
  animation: pp-pop .5s cubic-bezier(.18, .89, .32, 1.28) both;
}
.pp__tile--star::after { display: none; }
.pp__tile--star .pp__name { color: #fff; }
.pp__tile--star .pp__badge {
  color: #1a1320; border-color: transparent;
  background: linear-gradient(100deg, #ffb648, #ffd23f, #4dd6c4, #6aa8ff, #b388ff);
}
.pp__tile--star .pp__check { color: #fff; filter: drop-shadow(0 0 5px rgba(255,255,255,.6)); }

@media (prefers-reduced-motion: reduce) {
  .pp__tile, .pp__tile--star { animation: none; }
}
</style>
