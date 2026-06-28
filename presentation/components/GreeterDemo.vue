<!--
  "Greeter Demo" announcement card — the cue to switch to a live /greeter run in Claude.
  Pure eye-candy: animated rainbow wordmark, LIVE badge, floating unicorn + sparkles.
-->
<template>
  <div class="gd">
    <div class="gd__aurora" />

    <div class="gd__badge">
      <span class="gd__pulse" /> LIVE DEMO
    </div>

    <div class="gd__spark gd__spark--1">✨</div>
    <div class="gd__spark gd__spark--2">🌈</div>
    <div class="gd__spark gd__spark--3">⭐</div>
    <div class="gd__uni">🦄</div>

    <h2 class="gd__title">Greeter&nbsp;Demo</h2>

    <div class="gd__cmd">
      <span class="gd__sep">$</span>
      <span class="gd__prompt">/greeter</span>
      <span class="gd__arg">what we’ve been postponing</span>
      <span class="gd__caret">▋</span>
    </div>
  </div>
</template>

<script setup>
// presentational only
</script>

<style scoped>
.gd {
  position: relative; width: 100%; max-width: 720px; margin: 0 auto;
  padding: 2.4rem 2rem 2rem; border-radius: 18px; overflow: hidden;
  text-align: center; isolation: isolate;
  background: radial-gradient(120% 140% at 50% 0%, #1a1030 0%, #0c0a14 70%);
  border: 1px solid #2a2342;
  box-shadow: 0 22px 60px rgba(0, 0, 0, .5), inset 0 0 60px rgba(123, 75, 255, .08);
}

/* drifting aurora glow */
.gd__aurora {
  position: absolute; inset: -40%; z-index: -1;
  background:
    radial-gradient(40% 40% at 25% 30%, rgba(255, 77, 128, .35), transparent 70%),
    radial-gradient(45% 45% at 75% 25%, rgba(77, 150, 255, .35), transparent 70%),
    radial-gradient(50% 50% at 55% 80%, rgba(46, 196, 182, .30), transparent 70%);
  filter: blur(14px);
  animation: gd-drift 14s ease-in-out infinite alternate;
}
@keyframes gd-drift {
  from { transform: translate3d(-3%, -2%, 0) rotate(-3deg) scale(1.05); }
  to   { transform: translate3d(3%, 2%, 0) rotate(3deg) scale(1.12); }
}

.gd__badge {
  display: inline-flex; align-items: center; gap: .5rem;
  padding: .28rem .8rem; border-radius: 999px;
  font: 700 .72rem/1 'IBM Plex Mono', monospace; letter-spacing: .16em;
  color: #ffd9e2; background: rgba(255, 77, 128, .12);
  border: 1px solid rgba(255, 77, 128, .45);
}
.gd__pulse {
  width: .55rem; height: .55rem; border-radius: 50%; background: #ff4d80;
  box-shadow: 0 0 0 0 rgba(255, 77, 128, .7); animation: gd-pulse 1.6s infinite;
}
@keyframes gd-pulse {
  70% { box-shadow: 0 0 0 .65rem rgba(255, 77, 128, 0); }
  100% { box-shadow: 0 0 0 0 rgba(255, 77, 128, 0); }
}

.gd__title {
  margin: 1.1rem 0 1.2rem; font-size: 3.5rem; font-weight: 800; line-height: 1.05;
  letter-spacing: -.01em;
  background: linear-gradient(100deg, #ff4d4d, #ff9f1c, #ffd23f, #2ec4b6, #4d96ff, #9b5de5, #ff4d4d);
  background-size: 280% auto;
  -webkit-background-clip: text; background-clip: text;
  -webkit-text-fill-color: transparent; color: transparent;
  filter: drop-shadow(0 4px 24px rgba(155, 93, 229, .45));
  animation: gd-rainbow 6s linear infinite;
}
@keyframes gd-rainbow { to { background-position: 280% center; } }

.gd__cmd {
  display: inline-flex; align-items: center; gap: .55rem;
  padding: .6rem 1rem; border-radius: 10px;
  font: 600 1.05rem/1 'IBM Plex Mono', monospace;
  background: rgba(8, 10, 16, .6); border: 1px solid #2a2342;
}
.gd__sep { color: #6f7689; }
.gd__prompt { color: #4d96ff; }
.gd__arg { color: #cbd0db; }
.gd__caret { color: #2ec4b6; animation: gd-blink 1s steps(1) infinite; }
@keyframes gd-blink { 50% { opacity: 0; } }

/* floating decorations */
.gd__uni { position: absolute; top: 1rem; right: 1.3rem; font-size: 2.6rem; animation: gd-float 4.5s ease-in-out infinite; }
.gd__spark { position: absolute; font-size: 1.4rem; opacity: .9; animation: gd-float 5s ease-in-out infinite; }
.gd__spark--1 { top: 1.4rem; left: 1.6rem; animation-delay: .3s; }
.gd__spark--2 { bottom: 1.4rem; left: 2.2rem; font-size: 1.7rem; animation-delay: 1.1s; }
.gd__spark--3 { bottom: 1.8rem; right: 2rem; animation-delay: .7s; }
@keyframes gd-float { 50% { transform: translateY(-9px) rotate(6deg); } }

@media (prefers-reduced-motion: reduce) {
  .gd__aurora, .gd__pulse, .gd__title, .gd__caret, .gd__uni, .gd__spark { animation: none; }
}
</style>
