cask "hush" do
  version "0.1.10"
  sha256 "d950c586c87cbe0669ee19f93d6bf0460e53b8d99838ac1e9f7d8c6c1f87131b"

  url "https://github.com/MatthysDev/hush/releases/download/v#{version}/Hush-arm64.dmg"
  name "Hush"
  desc "Mute Discord over RPC while you dictate with Wispr Flow"
  homepage "https://github.com/MatthysDev/hush"

  depends_on macos: :monterey
  depends_on arch: :arm64

  app "Hush.app"

  # Hush is not notarized (free & open-source), so Gatekeeper would block the
  # first launch. Clear the quarantine flag on install so it opens normally.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Hush.app"],
                   sudo: false
  end

  uninstall quit: "com.hush.app"

  zap trash: [
    "~/Library/Application Support/hush",
    "~/Library/Logs/Hush",
    "~/Library/Preferences/com.hush.app.plist",
    "~/Library/Saved Application State/com.hush.app.savedState",
  ]
end
