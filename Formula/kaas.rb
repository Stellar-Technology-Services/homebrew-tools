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
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.5/kaas_0.1.5_darwin_arm64.tar.gz"
      sha256 "1e523b092c2777f957d97dce5ebc5509bed29346ea819bc7625be8a71542aec4"
    end
    on_intel do
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.1.5/kaas_0.1.5_darwin_amd64.tar.gz"
      sha256 "82a05dac1e155f33f8bd3cd18cb765fa7568b10be731fe5c54db9f6342508b56"
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
