# Wiredframe Homebrew tap

One tap for Wiredframe's apps and command line tools. A tap is just a repository with a `Casks`
and a `Formula` folder, so there is no reason for each app to bring its own.

```
brew tap wiredframe/tap
```

## Formulae

| Formula | Tool | |
|---|---|---|
| `los` | [los](https://github.com/Wiredframe/los) | Tiny launcher for everything you installed in the terminal |

```
brew install wiredframe/tap/los
```

## Casks

| Cask | App | |
|---|---|---|
| `dropme` | [DropMe](https://github.com/Wiredframe/dropme) | Private drop shelf, no network, no telemetry |
| `flow` | [Flow](https://github.com/Wiredframe/flow) | Tiny, fast photo and video viewer |
| `kontor` | [Kontor](https://github.com/Wiredframe/kontor-buchhaltung) | Local, offline bookkeeping for freelancers |
| `rectmangle` | [Rectmangle](https://github.com/Wiredframe/rectmangle) | Minimal window manager with keyboard shortcuts, no network |
| `simple-comic-paper` | [Simple Comic](https://github.com/Wiredframe/Simple-Comic) | Comic viewer with a paper effect and a library |

Homebrew will not load a cask from a tap outside its own repositories until you say you trust it.
That is asked once per cask:

```
brew trust --cask wiredframe/tap/dropme
brew install --cask wiredframe/tap/dropme

brew trust --cask wiredframe/tap/flow
brew install --cask wiredframe/tap/flow

brew trust --cask wiredframe/tap/kontor
brew install --cask kontor

brew trust --cask wiredframe/tap/rectmangle
brew install --cask wiredframe/tap/rectmangle

brew trust --cask wiredframe/tap/simple-comic-paper
brew install --cask simple-comic-paper
```

None of the apps is notarised by Apple, because notarising ties every release to a paid membership, so
macOS quarantines the downloads. Homebrew 6 removed the `--no-quarantine` flag and a cask cannot
opt out of quarantine on its own, so the casks clear the attribute after installing. That is what
lets the apps start normally.

`simple-comic-paper` deliberately conflicts with Homebrew's own `simple-comic` cask: same app, same
place in `/Applications`, different build.
