cask "kontor" do
  version "3.2.3"
  sha256 "11cf5da405b666bcbb708320ac60703f7ff97f703ec19a3882f88d8f2e3d071c"

  url "https://github.com/Wiredframe/kontor-buchhaltung/releases/download/v#{version}/Kontor-#{version}.zip"
  name "Kontor"
  desc "Lokale, offline Buchhaltungs-App für Freiberufler (EÜR, UStVA, KSK)"
  homepage "https://github.com/Wiredframe/kontor-buchhaltung"

  depends_on macos: :sequoia

  app "Kontor.app"

  postflight do
    # Homebrew 6 removed --no-quarantine, and a cask cannot opt out of quarantine declaratively,
    # so clearing the attribute here is the only thing left that spares users a Gatekeeper block.
    # `must_succeed: false` because the attribute is legitimately absent sometimes, and xattr
    # treats that as an error.
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Kontor.app"],
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
