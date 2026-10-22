cask "rss-feed-magazine" do
  version "1.0.0"
  sha256 "6da0fb8812a2830eee4a194b58f3db23849f4e8b0427d8bbe6efe5c1a7f1ea4d"

  url "https://github.com/Wiredframe/rss-feed-magazine/releases/download/v#{version}/RSS-Feed-Magazine-#{version}.zip"
  name "RSS Feed Magazine"
  desc "Feed reader with article images and a magazine layout"
  homepage "https://github.com/Wiredframe/rss-feed-magazine"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "RSS Feed Magazine.app"

  postflight_steps do
    # RSS Feed Magazine is signed with a Developer ID but not notarized, so clear the quarantine flag the download
    # picks up; otherwise Gatekeeper blocks the first launch. The attribute is sometimes absent,
    # which xattr reports as an error, hence `must_succeed: false`.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/RSS Feed Magazine.app"],
        must_succeed: false
  end

  uninstall quit: "de.wiredframe.RSSFeedMagazine"

  zap trash: [
    "~/Library/Application Support/RSS Feed Magazine",
    "~/Library/Caches/de.wiredframe.RSSFeedMagazine",
    "~/Library/Caches/TimelineImages",
    "~/Library/Group Containers/7RN999S858.de.wiredframe.RSSFeedMagazine",
    "~/Library/Preferences/de.wiredframe.RSSFeedMagazine.plist",
  ]

  caveats <<~EOS
    RSS Feed Magazine is not notarized, so this cask removes the quarantine flag after installing.
    If macOS still blocks it:
      xattr -dr com.apple.quarantine "/Applications/RSS Feed Magazine.app"
  EOS
end
