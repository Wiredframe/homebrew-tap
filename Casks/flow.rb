cask "flow" do
  version "1.0.0"
  sha256 "5b2ce1eb3e45d065d346a6d826dfb51143e2a9c362d1bd9f61c2576e7c310df7"

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
