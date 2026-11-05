cask "flow" do
  version "1.0.3"
  sha256 "e61d905183b78e549142a8190921725983d8d4e404f37efdd71ef75fe22a8346"

  url "https://github.com/Wiredframe/flow/releases/download/v#{version}/Flow-#{version}.zip"
  name "Flow"
  desc "Tiny, fast photo and video viewer: one folder, square grid, newest first"
  homepage "https://github.com/Wiredframe/flow"

  depends_on macos: :sonoma

  app "Flow.app"

  postflight_steps do
    # Flow is signed with a Developer ID but not notarized, so clear the quarantine flag the
    # download picks up; otherwise Gatekeeper blocks the first launch. The attribute is sometimes
    # absent, which xattr reports as an error, hence `must_succeed: false`.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Flow.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Caches/de.wiredframe.Flow",
    "~/Library/Preferences/de.wiredframe.Flow.plist",
  ]

  caveats <<~EOS
    Flow is not notarized, so this cask removes the quarantine flag after installing.
    If macOS still blocks it:
      xattr -dr com.apple.quarantine "/Applications/Flow.app"
  EOS
end
