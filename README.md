# danielhaden.github.io

Personal website, written in [Pollen](https://docs.racket-lang.org/pollen/)
and deployed to GitHub Pages at <https://danielhaden.github.io>.

Only the Pollen sources are committed. On every push to `main`, the workflow in
`.github/workflows/deploy.yml` installs Racket and Pollen, renders the site,
and publishes it. In the repository settings, **Pages → Source** must be set to
**GitHub Actions**.

## Layout

- `*.html.pm` — one file per page, in Pollen markup
- `index.ptree` — the pages shown in the navigation bar, in order
- `template.html` — the page layout shared by every page
- `pollen.rkt` — tag functions (`◊section`, `◊link`, `◊figure`, the navigation bar)
- `style.css` — the stylesheet

## Working locally

Preview with live re-rendering at <http://localhost:8080>:

```sh
raco pollen start
```

Render everything once (what CI does):

```sh
raco pollen render -r .
```

## Adding a page

1. Create `name.html.pm` starting with `#lang pollen` and
   `◊(define-meta title "Name")`.
2. Add `name.html` to `index.ptree`: at the top level to put it in the
   navigation bar, or nested under a section page (as the notebooks are under
   `notebooks.html`) to keep it out of the bar. CI renders only pages listed
   there.

## Figures

Put images in `figures/` (SVG, PNG, JPG or WebP all work), then:

```
◊figure["figures/pinhole-camera.webp" #:alt "Pinhole camera"]{Pinhole camera}
```

The braces hold the caption, which is numbered automatically per page
("Fig 1.", "Fig 2.", …). Leave the braces off for an unnumbered image.
Images shrink to fit the text column on narrow screens.

