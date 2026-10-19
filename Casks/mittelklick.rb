cask "mittelklick" do
  version "1.0.3"
  sha256 "377f6365f7c90907a64961dd5a1c3b575c861ea93efb501835324bd4ff5308f4"

  url "https://github.com/Wiredframe/mittelklick/releases/download/v#{version}/Mittelklick-#{version}.zip"
  name "Mittelklick"
  desc "Middle click by tapping the trackpad with three or four fingers, no network"
  homepage "https://github.com/Wiredframe/mittelklick"

  depends_on macos: :sonoma

  app "Mittelklick.app"

  postflight_steps do
    # Mittelklick is signed with a Developer ID but not notarized, so clear the quarantine flag the
    # download picks up; otherwise Gatekeeper blocks the first launch. The attribute is sometimes
    # absent, which xattr reports as an error, hence `must_succeed: false`.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Mittelklick.app"],
        must_succeed: false
  end

  uninstall quit: "de.wiredframe.mittelklick"

  zap trash: "~/Library/Preferences/de.wiredframe.mittelklick.plist"

  caveats <<~EOS
    Mittelklick needs Accessibility access to send clicks:
      System Settings › Privacy & Security › Accessibility
    Quit Middle or similar apps using the same gesture, or every middle click arrives twice.
  EOS
end
