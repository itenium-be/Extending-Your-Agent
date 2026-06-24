<script setup lang="ts">
// First session (12 Aug) — same blueprint style/flow + background as HackatonConcept2.
const bg = `url(${import.meta.env.BASE_URL}playbook-manual.png)`
const tracks = [
  { n: '90 MIN · MOB',  d: 'rotating driver, the room steers' },
  { n: 'CLAUDE + MCP',  d: 'Context7 · Playwright · Serena' },
  { n: 'GREEN = DONE',  d: 'the Playwright net is the spec' },
]
</script>

<template>
  <div class="bp" :style="{ '--img': bg }">
    <div class="wrap">
      <div class="bar"><span>itenium · AI CoE</span><span>SESSION 01 · 12 AUG 2026</span></div>

      <h1>FIRST HACKATHON</h1>

      <div class="flow">
        <span class="node theory">REACTIVE FORMS</span>
        <span class="pipe">════▶</span>
        <span class="node practice">SIGNAL FORMS</span>
        <span class="tag">Angular 22 · mob-migrate our reactive forms session, with AI</span>
      </div>

      <div class="modes">
        <div v-for="t in tracks" :key="t.n" class="card">
          <div class="n">{{ t.n }}</div>
          <div class="d">{{ t.d }}</div>
        </div>
      </div>

      <div class="board">
        <span class="bl">// arrive ready</span>
        <b>subs provided · laptop only · no prep</b> — run the setup gist, then we build. Everyone welcome.
      </div>

      <div class="foot">
        <span>◳ 12 AUG · OFFICE DAY · 90 MIN</span>
        <span>SCOREBOARD: TOKENS × TESTS PASSING</span>
        <span class="amber">▣ THEN YOUR TOPICS</span>
      </div>
    </div>
  </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@700&display=swap');
</style>

<style scoped>
.bp{
  --bg:#061224; --cyan:#5cc8ff; --blue:#2a6df0; --amber:#ffd166; --ink:#cfe2ff; --dim:#5a7299; --line:rgba(92,200,255,.28);
  --display:'Orbitron','IBM Plex Mono',monospace;
  position:absolute;inset:0;color:var(--ink);font-family:'IBM Plex Mono',monospace;
  background:
    linear-gradient(rgba(6,18,36,.78), rgba(6,18,36,.86)),
    var(--img) center/cover no-repeat,
    var(--bg);
}
.wrap{position:relative;height:100%;box-sizing:border-box;padding:2rem 2.8rem;display:flex;flex-direction:column;}
.bar{display:flex;justify-content:space-between;font-size:.72rem;letter-spacing:.18em;color:var(--dim);
  border-bottom:1px solid var(--line);padding-bottom:.5rem;text-transform:uppercase;}
h1{font-family:var(--display);font-weight:700;font-size:2.6rem;color:var(--cyan);margin:1.1rem 0 1.2rem;
  letter-spacing:.04em;text-shadow:0 0 22px rgba(92,200,255,.4);}

.flow{display:flex;align-items:center;gap:1.1rem;flex-wrap:wrap;margin-bottom:1.4rem;}
.node{font-family:var(--display);font-size:1.05rem;letter-spacing:.08em;padding:.5em 1.1em;border:1px solid var(--line);border-radius:5px;}
.node.theory{color:var(--dim);}
.node.practice{color:#061224;background:var(--cyan);border-color:var(--cyan);box-shadow:0 0 22px rgba(92,200,255,.5);}
.pipe{color:var(--blue);letter-spacing:-.1em;}
.tag{flex-basis:100%;margin-top:.2rem;font-size:.84rem;color:var(--dim);letter-spacing:.04em;}

.modes{display:grid;grid-template-columns:repeat(3,1fr);gap:1.2rem;margin-bottom:1.3rem;}
.card{border:1px solid var(--line);border-radius:6px;padding:1rem 1.1rem;background:rgba(10,28,56,.5);position:relative;}
.card::before{content:"";position:absolute;left:0;top:0;width:100%;height:2px;background:linear-gradient(90deg,var(--cyan),transparent);}
.card .n{font-family:var(--display);font-size:1.15rem;color:var(--cyan);letter-spacing:.1em;}
.card .d{margin-top:.4rem;font-size:.88rem;color:var(--ink);}

.board{border-left:2px solid var(--amber);padding:.4rem 0 .4rem 1rem;font-size:1.02rem;line-height:1.5;}
.board .bl{display:block;font-size:.68rem;letter-spacing:.22em;color:var(--dim);text-transform:uppercase;margin-bottom:.25rem;}
.board b{color:var(--amber);}

.foot{margin-top:auto;display:flex;justify-content:space-between;border-top:1px solid var(--line);padding-top:.7rem;
  font-size:.74rem;letter-spacing:.12em;color:var(--dim);text-transform:uppercase;}
.amber{color:var(--amber);}
</style>
