cask "netnewsfeed" do
  version "7.3.0-feed.1"
  sha256 "b60734aa3fa384331e4511b6c527e3fb2ad54f8ee552f2d6af25dbcb42dc1f97"

  url "https://github.com/Wiredframe/netnewsfeed/releases/download/v#{version}/NetNewsFeed-#{version}.zip"
  name "NetNewsFeed"
  desc "NetNewsWire fork with article images and a magazine layout"
  homepage "https://github.com/Wiredframe/netnewsfeed"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "NetNewsFeed.app"

  postflight_steps do
    # NetNewsFeed is signed with a Developer ID but not notarized, so clear the quarantine flag the download
    # picks up; otherwise Gatekeeper blocks the first launch. The attribute is sometimes absent,
    # which xattr reports as an error, hence `must_succeed: false`.
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/NetNewsFeed.app"],
        must_succeed: false
  end

  uninstall quit: "de.wiredframe.NetNewsFeed"

  zap trash: [
    "~/Library/Application Support/NetNewsFeed",
    "~/Library/Caches/de.wiredframe.NetNewsFeed",
    "~/Library/Caches/TimelineImages",
    "~/Library/Group Containers/7RN999S858.de.wiredframe.NetNewsFeed",
    "~/Library/Preferences/de.wiredframe.NetNewsFeed.plist",
  ]

  caveats <<~EOS
    NetNewsFeed is not notarized, so this cask removes the quarantine flag after installing.
    If macOS still blocks it:
      xattr -dr com.apple.quarantine "/Applications/NetNewsFeed.app"
  EOS
end
