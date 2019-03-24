# HUYNH MINH TAN

## Mini Cheat Sheet

Performs a one off build your site to *./_site* (by default).

```bash
jekyll build
```

Builds your site any time a source file changes and serves it locally.

```bash
jekyll serve
```

To specify a *production* environment in the build command, like this.

```bash
JEKYLL_ENV=production jekyll build
```

Show folder theme.

```bash
bundle show minima
```

Open the theme’s directory in Finder or Explorer.

```bash
xdg-open $(bundle show minima)
```

To update all gems in your project.

```bash
bundle update
```