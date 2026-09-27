class Ccwho < Formula
  desc "Which Claude Code session needs you, and what it is about"
  homepage "https://github.com/lukaso/ccwho"
  url "https://github.com/lukaso/ccwho/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "df8f60c998cdcdefee1448f7038705d7a4be3d681686f2405b477274503453d4"
  license "MIT"

  depends_on :macos
  # the live list is a uv script: uv fetches Textual from its own header
  depends_on "uv"

  def install
    # ccwho finds its own files beside its real path, so they stay together in
    # libexec and only the command is linked into bin. The tests stay out.
    libexec.install Dir["*.py"].reject { |f| f.start_with?("test_") }
    libexec.install "jump.applescript", "install-handler.sh",
                    "com.lukaso.ccwho.save.plist.template"
    bin.install_symlink libexec/"ccwho.py" => "ccwho"
  end

  test do
    assert_match "which Claude Code session needs you", shell_output("#{bin}/ccwho --help")
    # ccwho finds its own files beside its real path: the setup template and
    # the link-handler installer must have come along.
    here = File.dirname(File.realpath(bin/"ccwho"))
    assert_path_exists File.join(here, "install-handler.sh")
    assert_path_exists File.join(here, "com.lukaso.ccwho.save.plist.template")
    assert_path_exists File.join(here, "ccwho_ui.py")
    refute_path_exists File.join(here, "test_ccwho.py")
    # ccgate was removed in 0.2.0
    refute_path_exists bin/"ccgate"
  end
end
