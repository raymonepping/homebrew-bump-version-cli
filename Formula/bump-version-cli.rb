class BumpVersionCli < Formula

  desc "CLI tool for bumping semantic versions in Bash scripts and updating changelogs"
  homepage "https://github.com/raymonepping/bump_version_cli"
  url "https://github.com/raymonepping/homebrew-bump-version-cli/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "c159cf33db89e8428f588fdd31b15d3793874aac0164e8009dfc9be696ad75c3"
  license "MIT"
  version "0.3.5"

  depends_on "bash"

  def install
    bin.install "bin/bump_version" => "bump_version"
  end

  def caveats
    <<~EOS
      To get started, run:
        bump_version --help

      This CLI helps manage Git commits, tags, and semantic versioning.
      It uses a .version file for tracking current state.

      Example usage:
        bump_version script.sh --minor
    EOS
  end

  test do
    assert_match "bump_version", shell_output("#{bin}/bump_version --help")
  end
end