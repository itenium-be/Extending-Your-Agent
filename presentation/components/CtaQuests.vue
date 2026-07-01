<!-- Call-to-action, part 1: the hands-on actions framed as a quest log — a callback to
     the Arsenal slide's "unlock" framing. CSS-only stagger, plays on slide entry. -->
<template>
  <div class="cta">
    <div class="cta-eyebrow">call to action <span>; go build tonight</span></div>
    <h2 class="cta-h">Your side quests</h2>

    <div class="quests">
      <div class="quest" v-click>
        <span class="q-check" :class="{ done: clicks > 1 }" />
        <div class="q-body"><div class="q-title"><code>git init</code> your <code>~/.claude</code></div><div class="q-sub">version your whole setup</div></div>
        <span class="q-no">01</span>
      </div>
      <div class="quest" v-click>
        <span class="q-check" :class="{ done: clicks > 2 }" />
        <div class="q-body"><div class="q-title">Turn knobs in <code>settings.json</code></div><div class="q-tags"><span class="kbd">/statusline</span><span class="kbd">/update-config</span></div></div>
        <span class="q-no">02</span>
      </div>
      <div class="quest" v-click>
        <span class="q-check" :class="{ done: clicks > 3 }" />
        <div class="q-body"><div class="q-title">Install a marketplace</div><div class="q-tags"><span class="kbd">obra/superpowers</span><span class="kbd">affaan-m/ECC</span></div></div>
        <span class="q-no">03</span>
      </div>
      <div class="quest" v-click>
        <span class="q-check" :class="{ done: clicks > 4 }" />
        <div class="q-body"><div class="q-title">Learn by doing</div><div class="q-tags"><span class="kbd">/powerup</span><span class="kbd">/help</span><span class="kbd">outputStyle: Learning</span></div></div>
        <span class="q-no">04</span>
      </div>
      <div class="quest" v-click>
        <span class="q-check" :class="{ done: clicks > 5 }" />
        <div class="q-body"><div class="q-title">Repeating yourself? Make it a <b>Skill</b></div><div class="q-tags"><span class="kbd">writing-skills</span></div></div>
        <span class="q-no">05</span>
      </div>
    </div>

    <div class="cta-foot" v-click>Pick one. Do it tonight. <em>Vibes don't scale — habits do.</em></div>
  </div>
</template>

<script setup>
import { useSlideContext } from '@slidev/client'
// $-prefixed bindings aren't exposed to the template, so alias it.
const { $clicks: clicks } = useSlideContext()
</script>

<style scoped>
.cta {
  position: absolute; inset: 0; background: #0d0d0d; color: #fff; overflow: hidden;
  display: flex; flex-direction: column; gap: 1rem; padding: 2.2rem 3.2rem; font-family: var(--font-body);
}
.cta::before {
  content: ''; position: absolute; inset: -10px; pointer-events: none;
  background:
    linear-gradient(rgba(255,255,255,.04) 1px, transparent 1px) 0 0 / 100% 2.4rem,
    linear-gradient(90deg, rgba(255,255,255,.04) 1px, transparent 1px) 0 0 / 2.4rem 100%;
}
.cta-eyebrow { position: relative; font-family: var(--font-code); font-size: 1.3rem; letter-spacing: .04em; }
.cta-eyebrow span { color: var(--color-text-muted); }
.cta-h { position: relative; margin: 0; font-family: var(--font-heading); font-size: 2.4rem; }

.quests { position: relative; display: flex; flex-direction: column; gap: .7rem; }
.quest {
  display: flex; align-items: center; gap: 1rem;
  background: #161616; border: 1px solid #2a2a2a; border-left: 4px solid var(--color-primary); border-radius: .6rem;
  padding: .7rem 1.1rem; box-shadow: 0 10px 26px rgba(0,0,0,.4);
  transition: opacity .4s ease, transform .4s ease;
}
/* Slide in from the left as each quest is revealed. */
.quest.slidev-vclick-hidden { opacity: 0; transform: translateX(-1.2rem); }
.q-check { flex: none; display: inline-flex; align-items: center; justify-content: center; width: 1.3rem; height: 1.3rem; border: 2px solid var(--color-primary-muted); border-radius: .3rem; box-shadow: 0 0 12px rgba(231,130,0,.35); transition: background .25s ease, border-color .25s ease; }
.q-check.done { background: var(--color-primary); border-color: var(--color-primary); }
.q-check.done::after { content: '✓'; color: #0d0d0d; font-size: .95rem; font-weight: 700; line-height: 1; }
.q-body { flex: 1; }
.q-title { font-size: 1.25rem; line-height: 1.2; }
.q-title code, .q-title b { color: var(--color-primary-muted); font-weight: 700; }
.q-title code { font-family: var(--font-code); }
.q-sub { margin-top: .15rem; font-size: .95rem; color: var(--color-text-muted); }
.q-tags { margin-top: .35rem; display: flex; flex-wrap: wrap; gap: .4rem; }
.kbd { font-family: var(--font-code); font-size: .8rem; color: #e0e0e0; background: #1c1c1c; border: 1px solid #3a3a3a; border-bottom-width: 2px; border-radius: .35rem; padding: .1rem .5rem; }
.q-no { font-family: var(--font-code); font-size: 1.4rem; font-weight: 700; color: #333; }

.cta-foot { position: relative; margin-top: auto; font-size: 1.15rem; color: var(--color-text-muted); transition: opacity .4s ease; }
.cta-foot em { color: var(--color-primary-muted); font-style: italic; }
</style>
