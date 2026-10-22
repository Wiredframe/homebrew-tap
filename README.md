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
| `paper-comic-reader` | [Paper Comic Reader](https://github.com/Wiredframe/paper-comic-reader-mac) | Comic reader with a paper effect and a library |

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

brew trust --cask wiredframe/tap/paper-comic-reader
brew install --cask paper-comic-reader
```

None of the apps is notarised by Apple, because notarising ties every release to a paid membership, so
macOS quarantines the downloads. Homebrew 6 removed the `--no-quarantine` flag and a cask cannot
opt out of quarantine on its own, so the casks clear the attribute after installing. That is what
lets the apps start normally.

`paper-comic-reader` replaces `simple-comic-paper` (Simple Comic with a paper effect, up to 2.0).
`cask_renames.json` maps the old token onto the new one, so `brew upgrade` moves an existing install
across, and the app keeps its library because it keeps Simple Comic's bundle id.
