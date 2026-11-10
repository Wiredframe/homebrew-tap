cask "haftnotiz" do
  version "0.2.0"
  sha256 "71761eac27c90e96998d52a41c223d1d4decade4792695ef467e2b324c9f81bf"

  url "https://github.com/Wiredframe/haftnotiz/releases/download/v#{version}/Haftnotiz-#{version}.zip"
  name "Haftnotiz"
  desc "Minimal Markdown sticky notes, one plain .md file per note, fully offline"
  homepage "https://github.com/Wiredframe/haftnotiz"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Haftnotiz.app"

  postflight_steps do
    # Haftnotiz is signed with a Developer ID but not notarized, so clear the quarantine flag the download
    # picks up; otherwise Gatekeeper blocks the first launch. The attribute is sometimes absent,
    # which xattr reports as an error, hence `must_succeed: false`.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Haftnotiz.app"],
        must_succeed: false
  end

  uninstall quit: "de.wiredframe.haftnotiz"

  zap trash: [
    "~/Library/Application Support/Haftnotiz",
    "~/Library/Preferences/de.wiredframe.haftnotiz.plist",
  ]

  caveats <<~EOS
    Haftnotiz is not notarized, so this cask removes the quarantine flag after installing.
    If macOS still blocks it:
      xattr -dr com.apple.quarantine "/Applications/Haftnotiz.app"
    Notes are plain Markdown files in ~/Documents/Haftnotiz (changeable from the menu bar);
    zap does not touch them.
  EOS
end
