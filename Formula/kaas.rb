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
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.6/kaas_0.1.6_darwin_arm64.tar.gz"
      sha256 "74cbb868fd2806a461e172afa8ddaebd4e531087ca3d3d045ece15e688df5ce3"
    end
    on_intel do
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.6/kaas_0.1.6_darwin_amd64.tar.gz"
      sha256 "86c95daffae6c8ed3c74e4517a0fb0559b4a9a3cae4384e04593180a3319c1e7"
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
