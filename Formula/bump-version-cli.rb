class BumpVersionCli < Formula

  desc "CLI tool for bumping semantic versions in Bash scripts and updating changelogs"
  homepage "https://github.com/raymonepping/bump_version_cli"
  url "https://github.com/raymonepping/homebrew-bump-version-cli/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "56d6be269476685a0e72ad87e116d8a3a651f44a5ce2ce15a1d0d14082f88a7c"
  license "MIT"
  version "0.6.1"

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