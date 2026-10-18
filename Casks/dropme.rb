cask "dropme" do
  version "1.0.0"
  sha256 "2e9e8fe6d4b315444f8e238f9f88c8ffe9b7032c06635e44f4a929c5b4696031"

  url "https://github.com/Wiredframe/dropme/releases/download/v#{version}/DropMe-#{version}.zip"
  name "DropMe"
  desc "Private drop shelf: hold Shift while dragging files, no network, no telemetry"
  homepage "https://github.com/Wiredframe/dropme"

  depends_on macos: :sonoma

  app "DropMe.app"

  postflight_steps do
    # DropMe is only ad-hoc signed and not notarized, so clear the quarantine flag the download
    # picks up; otherwise Gatekeeper blocks the first launch. The attribute is sometimes absent,
    # which xattr reports as an error, hence `must_succeed: false`.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/DropMe.app"],
        must_succeed: false
  end

  uninstall quit: "de.wiredframe.dropme"

  zap trash: "~/Library/Preferences/de.wiredframe.dropme.plist"

  caveats <<~EOS
    DropMe is not notarized, so this cask removes the quarantine flag after installing.
    If macOS still blocks it:
      xattr -dr com.apple.quarantine "/Applications/DropMe.app"
  EOS
end
