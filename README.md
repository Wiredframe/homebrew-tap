# Wiredframe Homebrew tap

One tap for Wiredframe's macOS apps. A tap is just a repository with a `Casks` folder, so there
is no reason for each app to bring its own.

```
brew tap wiredframe/tap
```

## Casks

| Cask | App | |
|---|---|---|
| `kontor` | [Kontor](https://github.com/Wiredframe/kontor-buchhaltung) | Local, offline bookkeeping for freelancers |
| `simple-comic-paper` | [Simple Comic](https://github.com/Wiredframe/Simple-Comic) | Comic viewer with a paper effect and a library |

Homebrew will not load a cask from a tap outside its own repositories until you say you trust it.
That is asked once per cask:

```
brew trust --cask wiredframe/tap/kontor
brew install --cask --no-quarantine kontor

brew trust --cask wiredframe/tap/simple-comic-paper
brew install --cask simple-comic-paper
```

Neither app is notarised by Apple — notarising ties every release to a paid membership. macOS
therefore quarantines the download. `simple-comic-paper` clears that flag itself after installing;
`kontor` expects `--no-quarantine`, or a right-click → **Open** on first launch.

`simple-comic-paper` deliberately conflicts with Homebrew's own `simple-comic` cask: same app, same
place in `/Applications`, different build.
