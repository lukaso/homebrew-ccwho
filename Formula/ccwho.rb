class Ccwho < Formula
  desc "Which Claude Code session needs you, and what it is about"
  homepage "https://github.com/lukaso/ccwho"
  url "https://github.com/lukaso/ccwho/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "770bf20f393ab05f62c42880e5a2088808791f49bd65d76ec4a508bc0df762b1"
  license "MIT"

  depends_on :macos
  # the live list is a uv script: uv fetches Textual from its own header
  depends_on "uv"

  def install
    # ccwho finds its own files beside its real path, so they stay together in
    # libexec and only the two commands are linked into bin. The tests stay out.
    libexec.install Dir["*.py"].reject { |f| f.start_with?("test_") }
    libexec.install "jump.applescript", "install-handler.sh",
                    "com.lukaso.ccwho.save.plist.template"
    bin.install_symlink libexec/"ccwho.py" => "ccwho"
    bin.install_symlink libexec/"ccgate.py" => "ccgate"
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
    shell_output("#{bin}/ccgate --status")
  end
end
