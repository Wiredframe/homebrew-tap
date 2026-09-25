cask "kontor" do
  version "3.2.12"
  sha256 "d5497ca5c62ea33a1182df8da6f9abfa96d250a1551394d6d51b0ade6fdde964"

  url "https://github.com/Wiredframe/kontor-buchhaltung/releases/download/v#{version}/Kontor-#{version}.zip"
  name "Kontor"
  desc "Lokale, offline Buchhaltungs-App für Freiberufler (EÜR, UStVA, KSK)"
  homepage "https://github.com/Wiredframe/kontor-buchhaltung"

  depends_on macos: :sequoia

  app "Kontor.app"

  postflight_steps do
    # Homebrew 6 removed --no-quarantine, and a cask cannot opt out of quarantine declaratively,
    # so clearing the attribute here is the only thing left that spares users a Gatekeeper block.
    # `must_succeed: false` because the attribute is legitimately absent sometimes, and xattr
    # treats that as an error.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Kontor.app"],
        must_succeed: false
  end

  caveats <<~EOS
    Kontor ist bewusst NICHT notariell signiert (kostenlos, Open Source), deshalb setzt
    macOS die Datei beim Laden in Quarantäne. Dieses Cask entfernt die Markierung nach der
    Installation wieder, damit die App normal startet.
    Falls doch einmal blockiert wird:
      xattr -dr com.apple.quarantine "/Applications/Kontor.app"
  EOS
end
