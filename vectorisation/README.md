# Vectorisation of Julia code on A64FX for Ookami

This directory contains some simple benchmarks to test vectorisation of Julia code on A64FX,
based on [these vectorisation
examples](https://www.stonybrook.edu/commcms/ookami/support/faq/Vectorization_Example.php)
by Eva Siegmann.

You can have a look at the [`benchmarks_pluto.jl`](./benchmarks_pluto.jl) script, or you can
also open it as a Pluto notebook by running the [`./start_notebook.sh`](./start_notebook.sh)
script.  If you want to open the notebook from a local browser you need to forward the
remote port locally with:

```
ssh -f -N <REMOTE HOST> -L <REMOTE PORT>:localhost:<LOCAL PORT>
```

where `<REMOTE HOST>` is the name of the remote host you want to forward the port from,
`<REMOTE PORT>` is the remote port (by default Pluto should use 1234, but look at the `Go to
http://localhost:<REMOTE PORT>/?secret=... in your browser to start writing ~ have fun!`
line in Pluto output), and `<LOCAL PORT>` is the local port you want to forward it to (can
be the same as `<REMOTE PORT>` if available).

Note that everything in this directory assumes you are on Ookami, because Ookami-specific
modules are used, but you should be able to adapt the code to another system.

If you don't have access to Ookami, a static HTML export of the notebook is available in the
file [`benchmarks_pluto.html`](./benchmarks_pluto.html)
([preview](https://refined-github-html-preview.kidonng.workers.dev/giordano/julia-on-ookami/raw/main/vectorisation/benchmarks_pluto.html)).
