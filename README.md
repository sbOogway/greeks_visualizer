# Option Greeks Lab

An interactive, single-page visual guide to option Greeks as partial derivatives of the Black–Scholes price: tangent lines and curvature, a rotatable 3D price landscape, Greeks of Greeks (with a numerical check that mixed partials commute), Taylor-expansion P&L, and the Black–Scholes PDE. A car analogy runs through every section.

**Live:** https://sboogway.github.io/greeks_visualizer/

## Run locally

Open `index.html` in a browser. No build step is needed for development.

## Deploy

The site is published from the `gh-pages` branch. A [husky](https://typicode.github.io/husky/) `pre-push` hook deploys automatically whenever `main` is pushed:

```sh
npm install      # installs husky and activates the hook
git push         # pushing main also publishes the pushed commit to gh-pages
```

The hook runs `scripts/deploy.sh <sha>`, which builds `dist/` from that commit's `index.html` (adding the doctype and `<head>` wrapper) and commits it to `gh-pages` without touching your working tree. To deploy by hand: `npm run deploy`.
