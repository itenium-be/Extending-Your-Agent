<!--
  Two-up for the Skills slide: LEFT = the Evals session we skipped (ghosted),
  RIGHT = demo the git-recipes skill (routing + AskUserQuestion). Each half = one v-click.
  Kept deliberately short so it fits under the bullet list above.
-->
<template>
  <div class="evg">
    <!-- LEFT: Evals — the missing session -->
    <div v-click class="ev">
      <div class="ev__ghost" aria-hidden="true">?</div>
      <span class="ev__tag">missing session</span>
      <h3 class="ev__h">🧪 Evals</h3>
      <p class="ev__q">Does it <em>still</em> work after a change?</p>
    </div>

    <!-- RIGHT: demo the git-recipes skill -->
    <div v-click class="gr">
      <span class="gr__demo">▶ demo</span>
      <div class="gr__body">
        <div class="gr__wm" aria-hidden="true">🛟</div>
        <div class="gr__cmd"><span class="gr__p">/git-recipes</span> <span class="gr__arg">“I lost my work 😱”</span></div>
        <ul class="gr__list">
          <li><span class="gr__ico">🔀</span> <b>routing</b></li>
          <li><span class="gr__ico">❓</span> <b>AskUserQuestion</b></li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
// presentational only — both halves revealed via the slide's click sequence
</script>

<style scoped>
.evg {
  display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;
  max-width: 840px; margin: .6rem auto 0; align-items: stretch;
}
.evg > div { border-radius: 12px; box-sizing: border-box; }

/* ---------- LEFT: ghosted Evals ---------- */
.ev {
  position: relative; overflow: hidden; padding: .8rem 1rem;
  background: repeating-linear-gradient(135deg, #161922, #161922 10px, #14171f 10px, #14171f 20px);
  border: 1.5px dashed #3a4150; color: #9aa1b0;
}
.ev__ghost {
  position: absolute; right: -.3rem; top: -1.6rem; z-index: 0;
  font-size: 8rem; font-weight: 800; line-height: 1; color: #f5b51e;
  opacity: .08; animation: ev-pulse 4s ease-in-out infinite;
}
.ev > :not(.ev__ghost) { position: relative; z-index: 1; }
.ev__tag {
  display: inline-block; padding: .28rem .8rem; border-radius: 999px;
  font: 800 .92rem/1 'IBM Plex Mono', monospace; letter-spacing: .12em; text-transform: uppercase;
  color: #f5b51e; background: rgba(245,181,30,.14); border: 1.5px solid rgba(245,181,30,.5);
}
.ev__h { margin: .45rem 0 .15rem; font-size: 1.5rem; font-weight: 800; color: #e8eaef; }
.ev__q { margin: 0; font-size: .95rem; color: #c4c9d4; }
.ev__q em { color: #f5b51e; font-style: italic; }
@keyframes ev-pulse { 50% { opacity: .15; } }

/* ---------- RIGHT: git-recipes terminal ---------- */
.gr {
  position: relative; overflow: hidden; background: #0d1017; border: 1px solid #20242e;
  box-shadow: 0 14px 34px rgba(0,0,0,.45); font-family: 'IBM Plex Mono', monospace;
}
.gr__demo {
  position: absolute; top: .6rem; right: .7rem; z-index: 2;
  padding: .2rem .6rem; border-radius: 999px;
  font: 800 .68rem/1 'IBM Plex Mono', monospace; letter-spacing: .1em; text-transform: uppercase;
  color: #27c93f; background: rgba(39,201,63,.14); border: 1px solid rgba(39,201,63,.5);
}
.gr__body { position: relative; overflow: hidden; padding: 1.7rem .9rem .9rem; }
.gr__wm {
  position: absolute; right: -.4rem; bottom: -1.6rem; z-index: 0;
  font-size: 6.5rem; line-height: 1; opacity: .12;
  transform: rotate(-12deg); animation: gr-bob 4s ease-in-out infinite;
}
.gr__body > :not(.gr__wm) { position: relative; z-index: 1; }
@keyframes gr-bob { 50% { transform: rotate(-12deg) translateY(-6px); opacity: .18; } }
.gr__cmd { font-size: .8rem; color: #d6d9e0; margin-bottom: .6rem; }
.gr__p { color: #f0683b; font-weight: 700; }
.gr__arg { color: #8b93a7; }
.gr__list { list-style: none; margin: 0; padding: 0; display: flex; flex-direction: column; gap: .4rem; }
.gr__list li { display: flex; align-items: center; gap: .5rem; font-size: .8rem; color: #cdd2db; }
.gr__list b { color: #ffb48f; font-weight: 700; }
.gr__ico { width: 1.2rem; text-align: center; }

@media (prefers-reduced-motion: reduce) { .ev__ghost, .gr__wm { animation: none; } }
</style>
