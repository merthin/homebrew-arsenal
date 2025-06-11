# Homebrew formula for Arsenal CLI

# Homebrew Documentation:
#  https://docs.brew.sh/Formula-Cookbook
#  https://rubydoc.brew.sh/Formula
class Cli < Formula
  desc "Arsenal Command-line Interface"
  homepage "https://arsenal.merthin.com/"
  url "https://npm.merthin.net/@merthin/cli/-/cli-1.0.16.tgz"
  sha256 "d3416637cadae203e63bfd31a74efdcb06f24c9fbe664ba8457944e9a57917a4"
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
