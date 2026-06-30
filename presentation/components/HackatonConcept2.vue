<script setup lang="ts">
// Concept B — blueprint / format schematic. img = scrimmed full-bleed backdrop.
const props = defineProps({ img: { type: String, default: 'playbook-manual.png' } })
const bg = `url(${import.meta.env.BASE_URL}${props.img})`
const modes = [
  { n: 'SOLO', d: 'your own form, your own pace' },
  { n: 'PAIR', d: 'driver + navigator, swap often' },
  { n: 'MOB',  d: 'one screen, the whole room steers' },
]
</script>

<template>
  <div class="bp" :style="{ '--img': bg }">
    <div class="wrap">
      <div class="bar"><span>itenium · AI CoE</span><span>HANDS-ON-TRACK</span></div>

      <h1>THE HANDS-ON PLAYBOOK</h1>

      <div class="flow">
        <span class="node theory">THEORY</span>
        <span class="pipe">════════▶</span>
        <span class="node practice">PRACTICE</span>
        <span class="tag">the talks teach it · now we do it</span>
      </div>

      <div class="modes">
        <div v-for="m in modes" :key="m.n" class="card">
          <div class="n">{{ m.n }}</div>
          <div class="d">{{ m.d }}</div>
        </div>
      </div>

      <div class="board">
        <span class="bl">// topic board</span>
        <b>you bring the topics</b> — the room votes what we tackle next. Everyone welcome.
        <br>&nbsp;&nbsp;&nbsp;<span v-click><b>share what you discovered</b> — post wins, prompts, tools, agents, ...</span>
        <br>&nbsp;&nbsp;&nbsp;<span v-click><b>show and tell</b> — what did Claude do for you this month?</span>
        <br>&nbsp;&nbsp;&nbsp;<span v-click><b>share a skill</b> — one you wrote, or one you found... (see README!)</span>
      </div>

      <div class="foot">
        <span>◳ INCEPTION: OFFICE DAYS</span>
        <span>SUBS PROVIDED · LAPTOP ONLY · NO PREP</span>
        <span class="amber">▣ IT WORKS? → SERIES</span>
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
.node{font-family:var(--display);font-size:1.1rem;letter-spacing:.1em;padding:.5em 1.1em;border:1px solid var(--line);border-radius:5px;}
.node.theory{color:var(--dim);}
.node.practice{color:#061224;background:var(--cyan);border-color:var(--cyan);box-shadow:0 0 22px rgba(92,200,255,.5);}
.pipe{color:var(--blue);letter-spacing:-.1em;}
.tag{flex-basis:100%;margin-top:.2rem;font-size:.84rem;color:var(--dim);letter-spacing:.04em;}

.modes{display:grid;grid-template-columns:repeat(3,1fr);gap:1.2rem;margin-bottom:1.3rem;}
.card{border:1px solid var(--line);border-radius:6px;padding:1rem 1.1rem;background:rgba(10,28,56,.5);
  position:relative;}
.card::before{content:"";position:absolute;left:0;top:0;width:100%;height:2px;background:linear-gradient(90deg,var(--cyan),transparent);}
.card .n{font-family:var(--display);font-size:1.25rem;color:var(--cyan);letter-spacing:.12em;}
.card .d{margin-top:.4rem;font-size:.9rem;color:var(--ink);}

.board{border-left:2px solid var(--amber);padding:.4rem 0 .4rem 1rem;font-size:1.02rem;line-height:1.5;}
.board .bl{display:block;font-size:.68rem;letter-spacing:.22em;color:var(--dim);text-transform:uppercase;margin-bottom:.25rem;}
.board b{color:var(--amber);}

.foot{margin-top:auto;display:flex;justify-content:space-between;border-top:1px solid var(--line);padding-top:.7rem;
  font-size:.74rem;letter-spacing:.12em;color:var(--dim);text-transform:uppercase;}
.amber{color:var(--amber);}
</style>
