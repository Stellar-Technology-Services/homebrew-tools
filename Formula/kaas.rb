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
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.1/kaas_0.1.1_darwin_arm64.tar.gz"
      sha256 "887eadf7c400103a7b4b887550b444321cc5907db84b1bb383047d1ce53b8d90"
    end
    on_intel do
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.1/kaas_0.1.1_darwin_amd64.tar.gz"
      sha256 "38eb9fc16d5ea524e8c9faf3c1cf1272c8d45c59abea96e66acffccd03098e9c"
    end
  end

  def install
    if build.head?
      ldflags = "-X github.com/Stellar-Technology-Services/agent-sandbox/internal/cli.Version=#{version}"
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
