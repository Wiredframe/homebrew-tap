cask "rectmangle" do
  version "1.0.2"
  sha256 "f02e544031a7af631c49bd6204a3d01ffbb432ee41a8f0ff0945c4550161b40f"

  url "https://github.com/Wiredframe/rectmangle/releases/download/v#{version}/Rectmangle-#{version}.zip"
  name "Rectmangle"
  desc "Minimal window manager with keyboard shortcuts, modelled on Rectangle"
  homepage "https://github.com/Wiredframe/rectmangle"

  depends_on arch: :arm64
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
