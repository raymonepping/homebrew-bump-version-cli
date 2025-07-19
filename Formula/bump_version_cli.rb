class BumpVersionCli < Formula

  desc "CLI tool for bumping semantic versions in Bash scripts and updating changelogs"
  homepage "https://github.com/raymonepping/bump_version_cli"
  url "https://github.com/raymonepping/homebrew-bump_version_cli/archive/refs/tags/v0.5.4.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"
  version "0.5.4"

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