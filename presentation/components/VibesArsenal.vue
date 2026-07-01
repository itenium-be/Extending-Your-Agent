<!-- Concept C "arsenal": red FAIL cards left, stamp slams center; the fix is four locked
     weapon cards you unlock next session. Shine sweep + lock rattle. CSS-only. -->
<template>
  <div class="vs">
    <div class="vs-eyebrow">testing your extensions <span>; the missing session</span></div>

    <div class="vs-left">
      <aside class="vs-qa"><div class="vs-qa-face">😒</div><p>QA is not amused.</p></aside>

      <div class="vs-cards">
        <div class="vs-card" style="--d: .9s"><span class="vs-x">✗</span><code><span class="vs-key">description</span> triggers</code><span class="vs-badge">FAIL</span></div>
        <div class="vs-card" style="--d: 1.05s"><span class="vs-x">✗</span><code><span class="vs-key">subagent</span> dispatched</code><span class="vs-badge">FAIL</span></div>
        <div class="vs-card" style="--d: 1.2s"><span class="vs-x">✗</span><code><span class="vs-key">dependency</span> rug-pulled</code><span class="vs-badge">FAIL</span></div>
      </div>
    </div>

    <div class="vs-main">
      <div class="vs-stampwrap">
        <div class="vs-flash" />
        <div class="vs-stamp"><span class="vs-small">VIBES</span><span class="vs-big">DON'T SCALE</span></div>
      </div>

      <div class="vs-unlock">Needs Unlocking</div>
      <div class="vs-arsenal">
        <div class="vs-weapon" style="--d: 1.6s"><span class="vs-lock">🔒</span><b>Rubrics</b></div>
        <div class="vs-weapon" style="--d: 1.75s"><span class="vs-lock">🔒</span><b>Judges</b></div>
        <div class="vs-weapon" style="--d: 1.9s"><span class="vs-lock">🔒</span><b>Golden datasets</b></div>
        <div class="vs-weapon" style="--d: 2.05s"><span class="vs-lock">🔒</span><b>CI gates</b></div>
      </div>
    </div>
  </div>
</template>

<script setup></script>

<style scoped>
.vs {
  position: absolute; inset: 0; background: #0d0d0d; color: #fff; overflow: hidden;
  display: grid; grid-template-columns: 17rem 1fr; grid-template-rows: auto 1fr;
  gap: 1rem 2.5rem; padding: 2.2rem 3rem; font-family: var(--font-body);
  animation: vs-shake .4s ease-out .38s both;
}
.vs::before {
  content: ''; position: absolute; inset: -10px; pointer-events: none;
  background:
    linear-gradient(rgba(255,255,255,.04) 1px, transparent 1px) 0 0 / 100% 2.4rem,
    linear-gradient(90deg, rgba(255,255,255,.04) 1px, transparent 1px) 0 0 / 2.4rem 100%;
}
.vs-eyebrow { position: relative; grid-column: 1 / -1; font-family: var(--font-code); font-size: 1.4rem; letter-spacing: .04em; }
.vs-eyebrow span { color: var(--color-text-muted); }

.vs-left { grid-column: 1; grid-row: 2; display: flex; flex-direction: column; justify-content: center; gap: 1.1rem; }
.vs-cards { display: flex; flex-direction: column; gap: 1rem; }
.vs-card {
  position: relative; display: flex; align-items: center; gap: .6rem;
  background: #161616; border: 1px solid #2a2a2a; border-radius: .6rem; padding: .8rem .9rem .8rem 1.1rem;
  box-shadow: 0 12px 30px rgba(0,0,0,.45); overflow: hidden;
  opacity: 0; transform: translateX(-1rem); animation: vs-inx .45s ease-out var(--d) forwards;
}
.vs-card::before { content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background: linear-gradient(#ff5f56, #d23a2c); box-shadow: 0 0 12px rgba(210,58,44,.6); }
.vs-x { color: #ff5f56; font-size: 1.3rem; font-weight: 700; }
.vs-card code { flex: 1; font-family: var(--font-code); font-size: 1rem; color: #e8e8e8; }
.vs-key { color: var(--color-primary-muted); font-weight: 700; }
.vs-badge { font-family: var(--font-code); font-size: .65rem; font-weight: 700; letter-spacing: .16em; color: #ff5f56; border: 1px solid #ff5f56; border-radius: 1rem; padding: .1rem .55rem; }

.vs-main { grid-column: 2; grid-row: 2; display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 1.3rem; }

.vs-stampwrap { position: relative; display: grid; place-items: center; }
.vs-flash { position: absolute; width: 12rem; height: 12rem; border: 4px solid #d23a2c; border-radius: .6rem; opacity: 0; animation: vs-ring .55s ease-out .38s both; }
.vs-stamp {
  --ink: #d23a2c; position: relative; display: inline-flex; flex-direction: column; align-items: center; gap: .1rem;
  padding: 1rem 2.4rem; color: var(--ink); border: .4rem solid var(--ink); border-radius: .4rem;
  font-family: var(--font-code); font-weight: 700; text-transform: uppercase; letter-spacing: .12em;
  opacity: .9; transform: rotate(-12deg); filter: drop-shadow(0 0 22px rgba(210,58,44,.4));
  -webkit-mask-image: radial-gradient(circle at 28% 22%, #000 0 60%, transparent 80%), radial-gradient(circle at 82% 72%, #000 0 55%, transparent 78%), linear-gradient(#000 0 100%);
  mask-image: radial-gradient(circle at 28% 22%, #000 0 60%, transparent 80%), radial-gradient(circle at 82% 72%, #000 0 55%, transparent 78%), linear-gradient(#000 0 100%);
  animation: vs-slam .7s cubic-bezier(.2,1.4,.3,1) both;
}
.vs-small { font-size: 1.7rem; }
.vs-big { font-size: 3.8rem; line-height: 1; }

.vs-arsenal { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem; }
.vs-weapon {
  position: relative; overflow: hidden; display: flex; flex-direction: column; align-items: center; gap: .35rem;
  padding: 1rem 1.1rem; background: #161616; border: 1px solid #3a2f1a; border-radius: .6rem;
  box-shadow: 0 10px 26px rgba(0,0,0,.4);
  opacity: 0; transform: translateY(.6rem); animation: vs-up .45s ease-out var(--d) forwards;
}
.vs-weapon b { font-family: var(--font-code); color: #e0b050; font-size: 1rem; white-space: nowrap; }
.vs-lock { font-size: 1.4rem; animation: vs-rattle 3s ease-in-out 2.4s infinite; }
/* Light sweep across each locked card — reads as "shiny loot, just out of reach". */
.vs-weapon::after {
  content: ''; position: absolute; top: 0; bottom: 0; left: -60%; width: 40%;
  background: linear-gradient(100deg, transparent, rgba(224,176,80,.28), transparent);
  transform: skewX(-18deg); animation: vs-shine 3.2s ease-in-out 2.6s infinite;
}
.vs-unlock { font-family: var(--font-code); font-weight: 700; font-size: 1.3rem; color: #e0b050; text-shadow: 0 0 14px rgba(224,176,80,.4); animation: vs-glow 1.8s ease-in-out 2.4s infinite; }

.vs-qa { display: flex; align-items: center; gap: .7rem; background: #1b1411; border: 1px solid #3a2520; border-left: 4px solid #d23a2c; border-radius: .6rem; padding: .6rem .9rem; transform: rotate(-2deg); box-shadow: 0 12px 30px rgba(0,0,0,.5); opacity: 0; animation: vs-inx .5s ease-out 2.4s forwards; }
.vs-qa-face { font-size: 1.7rem; animation: vs-bob 2.4s ease-in-out 2.9s infinite; }
.vs-qa p { margin: 0; font-size: .95rem; color: #d8d8d8; }

@keyframes vs-inx { to { opacity: 1; transform: translateX(0) rotate(var(--r, 0deg)); } }
@keyframes vs-up { to { opacity: 1; transform: translateY(0); } }
@keyframes vs-shine { 0% { left: -60%; } 55%, 100% { left: 130%; } }
@keyframes vs-rattle { 0%, 92%, 100% { transform: rotate(0); } 94% { transform: rotate(-12deg); } 96% { transform: rotate(12deg); } 98% { transform: rotate(-8deg); } }
@keyframes vs-glow { 0%, 100% { opacity: .7; } 50% { opacity: 1; } }
@keyframes vs-bob { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-3px); } }
@keyframes vs-ring { 0% { opacity: .85; transform: scale(.5); } 100% { opacity: 0; transform: scale(1.7); } }
@keyframes vs-slam { 0% { transform: rotate(-12deg) scale(3); opacity: 0; } 55% { transform: rotate(-12deg) scale(.92); opacity: .9; } 72% { transform: rotate(-12deg) scale(1.06); } 85% { transform: rotate(-13.5deg) scale(.99); } 100% { transform: rotate(-12deg) scale(1); opacity: .9; } }
@keyframes vs-shake { 0%, 100% { transform: translate(0, 0); } 20% { transform: translate(3px, -2px); } 40% { transform: translate(-3px, 2px); } 60% { transform: translate(2px, 1px); } 80% { transform: translate(-2px, -1px); } }
</style>
