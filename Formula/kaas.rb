class Kaas < Formula
  desc "Persistent local Linux workspaces for coding agents"
  homepage "https://github.com/Stellar-Technology-Services/kaas"

  # Build from source: brew install --HEAD kaas
  head do
    url "https://github.com/Stellar-Technology-Services/kaas.git", branch: "main"
    depends_on "go" => :build
  end

  depends_on "ansible"
  depends_on "colima"
  depends_on "herdr"
  depends_on :macos
  depends_on "secretspec"

  # Default: install prebuilt release binaries.
  on_macos do
    on_arm do
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.8/kaas_0.1.8_darwin_arm64.tar.gz"
      sha256 "1a71cfe2e249d8c3761f9d7beae0c6f74ee72ea901f93d01241c878d9c509990"
    end
    on_intel do
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.8/kaas_0.1.8_darwin_amd64.tar.gz"
      sha256 "84261d6f047e3e2680209db7a8c1b75a3787cb949e5478137bb5a5c93b10582a"
    end
  end

  def install
    if build.head?
      ldflags = "-X github.com/Stellar-Technology-Services/kaas/internal/cli.Version=#{version}"
      system "go", "build", *std_go_args(ldflags:), "./cmd/kaas"
    else
      bin.install "kaas"
    end
    generate_completions_from_executable(bin/"kaas", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kaas version")
  end
end
