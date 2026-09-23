# Homebrew formula for TheIntroDB plex-sync.
#
# Install:
#   brew tap Pasithea0/tap
#   brew install plex-sync
#
# The `plex-sync` command is added to your PATH. It is the official Plex
# integration for TheIntroDB, and it fills in Plex's intro and credits markers
# from TheIntroDB rather than making Plex fingerprint every file.
#
# This formula installs the released binary for the platform, so there is no Go
# toolchain to install and nothing to build.

class PlexSync < Formula
  desc "Plex intro and credits markers from TheIntroDB"
  homepage "https://github.com/TheIntroDB/plex-sync"
  license "GPL-3.0-only"

  # The archives hold the binary at the top level, alongside the README, the
  # licence, the docs and the Unraid template.
  #
  # Windows is released by the project and is not offered here: Homebrew does not
  # install Windows binaries. 32-bit ARM is released too, for Raspberry Pis
  # running Linux, but Homebrew on Linux is 64-bit, so it is left out.
  on_macos do
    on_arm do
      url "https://github.com/TheIntroDB/plex-sync/releases/download/v0.5.1/plex-sync_0.5.1_darwin_arm64.tar.gz"
      sha256 "eeb90c1c7fe3a855a19b67f4988590fd2f4a93319d92d0c038181b768133f2f1"
    end

    on_intel do
      url "https://github.com/TheIntroDB/plex-sync/releases/download/v0.5.1/plex-sync_0.5.1_darwin_amd64.tar.gz"
      sha256 "c4e70fa989f95becc1f29aec82bf316d712d998e4444a3beed9f1bdcb24e6aba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/TheIntroDB/plex-sync/releases/download/v0.5.1/plex-sync_0.5.1_linux_arm64.tar.gz"
      sha256 "84ab61599181b36df718aee0ea2090344d4645dc2e2f1ff3c78e4f9450465b24"
    end

    on_intel do
      url "https://github.com/TheIntroDB/plex-sync/releases/download/v0.5.1/plex-sync_0.5.1_linux_amd64.tar.gz"
      sha256 "c1f0021bad8deeb602a00fc7715704599a0f1f50849e7dfb2276efaa831719d8"
    end
  end

  def install
    bin.install "plex-sync"

    # The archive carries the documentation and the Unraid template; keep them
    # with the binary so the version on disk has its own docs.
    prefix.install "README.md", "LICENSE" if File.exist?("README.md")
    doc.install Dir["docs/*.md"] if Dir.exist?("docs")
    pkgshare.install Dir["unraid/*.xml"] if Dir.exist?("unraid")
  end

  def caveats
    <<~EOS
      plex-sync needs to read and write Plex's own database to add markers, and
      it finds it automatically on this machine.

      Start with:
        plex-sync config check      # confirm it found Plex and the database
        plex-sync plan              # see what a run would change, writing nothing
        plex-sync tui               # or use the terminal interface

      Run `plex-sync` with no arguments for the interface, and see
      https://github.com/TheIntroDB/plex-sync for the rest.
    EOS
  end

  test do
    assert_match "plex-sync", shell_output("#{bin}/plex-sync version")
    assert_match version.to_s, shell_output("#{bin}/plex-sync version")
  end
end
