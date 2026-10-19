cask "flow" do
  version "1.0.2"
  sha256 "371a7e53a655eb4ef8b5e8157e09ff1e69de9903f6bf5ac2ecccf6d7b08513f6"

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
