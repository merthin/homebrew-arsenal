# Homebrew formula for Arsenal CLI

# Homebrew Documentation:
#  https://docs.brew.sh/Formula-Cookbook
#  https://rubydoc.brew.sh/Formula
class Cli < Formula
  desc "Arsenal Command Line Interface"
  homepage "https://arsenal.merthin.com/"
  url "https://npm.merthin.net/@ced/cli/-/cli-1.1.79.tgz"
  sha256 "331cd64b2f2ead1840ad19c680961202af14da2a218d585933839dcf0626b404"
  license "ISC"

  depends_on "node@22"

  def install
    
    # Arsenal CLI depends on merthin's npm packages, which outside of the
    # offical npm registry. So we need to tell npm where to go look for them.
    # Due to Homebrew's sandboxing, this configuration change won't affect 
    # other npm based Homebrew Formula.

    npm_config_flags = ['-ddd', '--global', "--prefix=#{libexec}"]
    registry_flags = ["@ced:registry", "https://npm.merthin.net/"]

    system "npm", "config", "set", *registry_flags, *npm_config_flags

    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "ced", "-V"
  end
end
