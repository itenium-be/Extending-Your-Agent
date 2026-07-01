<!-- Call-to-action, part 2: the community asks as "event tickets". Big glowing date badge
     for the hackathon. CSS-only stagger, plays on slide entry. -->
<template>
  <div class="cta">
    <div class="cta-eyebrow">call to action <span>; join the guild</span></div>
    <h2 class="cta-h">Come build with us</h2>

    <div class="tickets">
      <article class="ticket" v-click>
        <div class="t-ico">📖</div>
        <div class="t-body">
          <div class="t-kicker">#boekenclub</div>
          <div class="t-title">The Alignment Problem</div>
          <div class="t-sub">read it with us</div>
        </div>
        <div class="t-cta">join →</div>
      </article>

      <article class="ticket ticket--event" v-click>
        <div class="t-ico">🏆</div>
        <div class="t-body">
          <div class="t-kicker">Claude hack-a-tons · office days</div>
          <div class="t-title">Build something real</div>
          <div class="t-sub">first one — save the date</div>
        </div>
        <div class="t-date"><span>12</span>AUG</div>
      </article>
    </div>
  </div>
</template>

<script setup></script>

<style scoped>
.cta {
  position: absolute; inset: 0; background: #0d0d0d; color: #fff; overflow: hidden;
  display: flex; flex-direction: column; gap: 1.2rem; padding: 2.4rem 3.2rem; font-family: var(--font-body);
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

.tickets { position: relative; display: flex; flex-direction: column; gap: 1.3rem; justify-content: center; flex: 1; }
.ticket {
  position: relative; display: flex; align-items: center; gap: 1.6rem;
  background: #161616; border: 1px solid #2a2a2a; border-radius: .8rem; padding: 1.4rem 1.8rem;
  box-shadow: 0 16px 40px rgba(0,0,0,.5); --r: -1deg;
  transform: rotate(var(--r));
  transition: opacity .45s ease, transform .45s ease;
}
/* Rise + settle into its tilt as the ticket is revealed. */
.ticket.slidev-vclick-hidden { opacity: 0; transform: translateY(1rem) rotate(var(--r)); }
/* Perforated stub edge — reads as a real ticket. */
.ticket::before {
  content: ''; position: absolute; left: 6.5rem; top: .8rem; bottom: .8rem; width: 0;
  border-left: 2px dashed #333;
}
.ticket--event { border-color: var(--color-primary); box-shadow: 0 16px 44px rgba(232,71,0,.22); --r: 1deg; }

.t-ico { flex: none; width: 4.4rem; height: 4.4rem; display: grid; place-items: center; font-size: 2.6rem; background: #0d0d0d; border-radius: .7rem; border: 1px solid #2a2a2a; }
.t-body { flex: 1; }
.t-kicker { font-family: var(--font-code); font-size: 1rem; color: var(--color-primary-muted); letter-spacing: .04em; }
.t-title { font-family: var(--font-heading); font-size: 1.9rem; line-height: 1.1; margin: .1rem 0; }
.t-sub { font-size: 1rem; color: var(--color-text-muted); }
.t-cta { font-family: var(--font-code); font-size: 1.2rem; color: var(--color-primary-muted); font-weight: 700; }

.t-date {
  flex: none; display: flex; flex-direction: column; align-items: center; line-height: 1;
  font-family: var(--font-code); font-weight: 700; font-size: 1.3rem; letter-spacing: .1em;
  color: var(--color-primary); padding: .6rem 1.1rem; border: 2px solid var(--color-primary); border-radius: .6rem;
  text-shadow: 0 0 16px rgba(232,71,0,.6); box-shadow: 0 0 22px rgba(232,71,0,.3) inset;
  animation: cta-pulse 2s ease-in-out .9s infinite;
}
.t-date span { font-size: 2.8rem; }

@keyframes cta-pulse { 0%, 100% { box-shadow: 0 0 22px rgba(232,71,0,.25) inset; } 50% { box-shadow: 0 0 30px rgba(232,71,0,.55) inset; } }
</style>
