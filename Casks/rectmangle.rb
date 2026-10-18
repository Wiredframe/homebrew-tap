cask "rectmangle" do
  version "1.0.1"
  sha256 "0d47c4b680be94c24290772cb6775375ab1bc03fbdecdcd075d71b9246ec2c92"

  url "https://github.com/Wiredframe/rectmangle/releases/download/v#{version}/Rectmangle-#{version}.zip"
  name "Rectmangle"
  desc "Minimal window manager with keyboard shortcuts, modelled on Rectangle"
  homepage "https://github.com/Wiredframe/rectmangle"

  depends_on macos: :ventura

  app "Rectmangle.app"

  postflight_steps do
    # Rectmangle is signed with a Developer ID but not notarized, so clear the quarantine flag the
    # download picks up; otherwise Gatekeeper blocks the first launch. The attribute is sometimes
    # absent, which xattr reports as an error, hence `must_succeed: false`.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Rectmangle.app"],
        must_succeed: false
  end

  uninstall quit: "de.wiredframe.rectmangle"

  zap trash: "~/.config/rectmangle"

  caveats <<~EOS
    Rectmangle is not notarized, so this cask removes the quarantine flag after installing.
    If macOS still blocks it:
      xattr -dr com.apple.quarantine "/Applications/Rectmangle.app"
    Moving windows needs access under System Settings > Privacy & Security > Accessibility.
  EOS
end
