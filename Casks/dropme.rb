cask "dropme" do
  version "1.1.0"
  sha256 "67fa0634b94e5564907d89c77ade693fe2e14b617dd850fa44d37ce2d5267935"

  url "https://github.com/Wiredframe/dropme/releases/download/v#{version}/DropMe-#{version}.zip"
  name "DropMe"
  desc "Private drop shelf: hold Shift while dragging files, no network, no telemetry"
  homepage "https://github.com/Wiredframe/dropme"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "DropMe.app"

  postflight_steps do
    # DropMe is signed with a Developer ID but not notarized, so clear the quarantine flag the download
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
