# Homebrew formula for Arsenal CLI

# Homebrew Documentation:
#  https://docs.brew.sh/Formula-Cookbook
#  https://rubydoc.brew.sh/Formula
class Cli < Formula
  desc "Arsenal Command-line Interface"
  homepage "https://arsenal.merthin.com/"
  url "https://npm.merthin.net/@merthin/cli/-/cli-1.0.18.tgz"
  sha256 "76417f7c78499e6658b37dffcd9402d74f0ae457af7a9c5fee83524bf0f72f57"
  license "ISC"

  depends_on "node@22"

  def install
    # Arsenal CLI depends on merthin's npm packages, which outside of the
    # official npm registry. So we need to tell npm where to go look for them.
    # Due to Homebrew's sandboxing, this configuration change won't affect
    # other npm based Homebrew Formula.

    npm_config_flags = ["-ddd", "--global", "--prefix=#{libexec}"]
    registry_flags = ["@ced:registry", "https://npm.merthin.net/"]

    system "npm", "config", "set", *registry_flags, *npm_config_flags

    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "merthin", "-V"
  end
end
