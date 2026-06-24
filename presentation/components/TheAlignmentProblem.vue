<script setup lang="ts">
// public/ assets are resolved through Vite's configured base so the deploy
// sub-path (--base /Extending-Your-Agent/) is honoured at build time.
const base = import.meta.env.BASE_URL
const hdr = `url(${base}hdr-alignment.jpg)`
const cover = `${base}the-alignment-problem.jpg`
</script>

<template>
  <div class="dossier dx">
    <div class="wrap">
      <div class="bar"><span>// bookclub // next read</span><span class="g">CASE #03</span></div>
      <div class="dos">
        <div class="top" :style="{ '--hdr': hdr }">
          <div>
            <div class="case">AI / ETHICS · ACQUIRED 2020</div>
            <h1>The Alignment Problem</h1>
            <div class="auth">subject: Brian Christian</div>
          </div>
          <div class="id">PAGES <b>476</b></div>
        </div>
        <div class="grid">
          <div>
            <div class="quote">"How do we make machines want what we want?"</div>
            <div class="desc">The definitive narrative bridge from the basics of machine learning to the ethics of AI — the single best read spanning tech, philosophy and society at once.</div>
            <div class="for">
              <b>DATE POLL:</b> Second half of september
              <br><b>WHAT:</b> first chapter "PROPHECY" (100p)
            </div>
          </div>
          <div class="rcol">
            <div class="threat">
              <div class="t">// threat assessment</div>
              <div class="gauge"><span>Brainpower</span><b>█████</b></div>
              <div class="gauge"><span>Debate fuel</span><b>█████</b></div>
              <div class="gauge"><span>Accessibility</span><b>███<span class="o">██</span></b></div>
            </div>
            <figure class="vid"><img :src="cover" alt="cover"/></figure>
          </div>
        </div>
      </div>
      <div class="foot"><span>// itenium</span></div>
    </div>
  </div>
</template>

<style scoped>
.dossier{
  --bg:#04110a; --panel:#07180f; --grn:#27f08a; --dim:#1e7a4f;
  --ink:#bdf7d8; --amber:#ffb347; --line:#0f3b25;
  position:absolute;inset:0;
  background:
    radial-gradient(120% 90% at 50% 0%, #08361f 0%, var(--bg) 55%),
    var(--bg);
  color:var(--ink);
  font-family:'JetBrains Mono',monospace;
}
.dossier::after{
  content:"";position:absolute;inset:0;pointer-events:none;
  background:repeating-linear-gradient(0deg,rgba(0,0,0,.0) 0 2px,rgba(0,0,0,.28) 2px 3px);
  mix-blend-mode:multiply;opacity:.5;
}
.dx *{text-shadow:0 0 6px rgba(39,240,138,.18);}
.wrap{position:relative;height:100%;box-sizing:border-box;padding:2.2rem 2.8rem;display:flex;flex-direction:column;}
.bar{display:flex;justify-content:space-between;font-size:.72rem;letter-spacing:.16em;color:var(--dim);
  border-bottom:1px solid var(--line);padding-bottom:.5rem;text-transform:uppercase;}
.bar .g{color:var(--grn);}
.foot{position:absolute;left:2.8rem;right:2.8rem;bottom:1.4rem;display:flex;justify-content:space-between;
  font-size:.68rem;letter-spacing:.16em;color:var(--dim);text-transform:uppercase;}
.foot span:last-child{position:relative;top:8px;}

/* dossier */
.dos{flex:1;display:grid;grid-template-columns:1fr;gap:0;margin-top:.8rem;}
.dos .top{position:relative;display:grid;grid-template-columns:1fr auto;align-items:start;
  padding:.9rem 1.1rem .8rem;border:1px solid var(--line);border-radius:6px;overflow:hidden;
  background-image:linear-gradient(90deg, rgba(4,17,10,.95) 0 30%, rgba(4,17,10,.45) 60%, rgba(4,17,10,.18) 100%), var(--hdr, none);
  background-size:cover;background-position:center top;}
.dos .case{font-size:.74rem;letter-spacing:.2em;color:var(--dim);text-transform:uppercase;}
.dos h1{font-size:2.9rem;font-weight:800;color:var(--grn);margin:.4rem 0 .1rem;line-height:1;
  text-shadow:0 0 18px rgba(39,240,138,.4);}
.dos .auth{color:var(--ink);font-size:1.05rem;}
.dos .id{text-align:right;font-size:.74rem;letter-spacing:.14em;color:var(--dim);text-transform:uppercase;line-height:1.9;text-shadow:0 0 6px rgba(0,0,0,.9);}
.dos .id b{color:var(--amber);}
.dos .grid{display:grid;grid-template-columns:1.35fr 1fr;gap:2rem;margin-top:1.1rem;}
.dos .quote{color:var(--amber);font-size:1.45rem;margin:.4rem 0 1.1rem;}
.dos .desc{font-size:1.02rem;line-height:1.5;color:var(--ink);}
.dos .threat{border:1px solid var(--line);border-radius:6px;padding:.85rem 1.2rem;background:var(--panel);}
.dos .rcol{display:flex;flex-direction:column;gap:1rem;align-self:start;}
.dos .vid{margin:0;align-self:flex-end;position:relative;width:132px;padding:.45rem;
  background:var(--panel);border:1px solid var(--line);border-radius:6px;box-shadow:0 0 18px rgba(39,240,138,.12);}
.dos .vid img{display:block;width:100%;border-radius:3px;
  filter:grayscale(.35) sepia(1) hue-rotate(70deg) saturate(2.2) brightness(.82) contrast(1.18);}
.dos .vid::after{content:"";position:absolute;inset:.45rem;border-radius:3px;
  pointer-events:none;background:repeating-linear-gradient(0deg,rgba(0,0,0,0) 0 2px,rgba(0,0,0,.32) 2px 3px);mix-blend-mode:multiply;}
.dos .threat .t{font-size:.72rem;letter-spacing:.18em;color:var(--dim);text-transform:uppercase;margin-bottom:.5rem;}
.dos .gauge{display:flex;justify-content:space-between;align-items:center;margin:.45rem 0;font-size:.82rem;
  letter-spacing:.08em;text-transform:uppercase;color:var(--dim);}
.dos .gauge b{color:var(--grn);letter-spacing:.16em;font-size:1rem;}
.dos .gauge b .o{color:var(--line);}
.dos .for{margin-top:.9rem;border-top:1px solid var(--line);padding-top:.7rem;font-size:.85rem;color:var(--dim);
  text-transform:uppercase;letter-spacing:.08em;}
.dos .for b{color:var(--ink);}
</style>
