cask "meluli" do
  version "0.1.0-preview.3"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/rashi123123/meluli/releases/download/v#{version}/Meluli-#{version}-arm64.dmg"
  name "Meluli"
  desc "Hebrew dictation and transcription that runs locally"
  homepage "https://github.com/rashi123123/meluli"

  # Covers prereleases too, which the default strategy skips.
  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        match[1] if match
      end
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Meluli.app"

  zap trash: [
    "~/Library/Application Support/IvritMenuBar",
    "~/Library/Caches/io.github.rashi123123.meluli",
    "~/Library/Caches/io.github.rashi123123.meluli.ShipIt",
    "~/Library/HTTPStorages/io.github.rashi123123.meluli",
    "~/Library/Logs/Meluli",
    "~/Library/Preferences/io.github.rashi123123.meluli.plist",
    "~/Library/Saved Application State/io.github.rashi123123.meluli.savedState",
    "~/Library/WebKit/io.github.rashi123123.meluli",
  ]
end
