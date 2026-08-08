# Wiredframe Homebrew tap

```
brew tap wiredframe/tap
brew install --cask wiredframe/tap/simple-comic
```

## Casks

- **simple-comic** — [Simple Comic](https://github.com/Wiredframe/Simple-Comic), the fork with a
  paper effect and a library. Same app and same install location as Homebrew's own
  `simple-comic` cask, so the two conflict by design; this one is built from
  `Wiredframe/Simple-Comic`.

The build is signed but not notarised, so macOS quarantines the download. The cask clears that
flag after installing, which is what lets the app open normally.
