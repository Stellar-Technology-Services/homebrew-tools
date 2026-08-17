class Kaas < Formula
  desc "Persistent local Linux workspaces for coding agents"
  homepage "https://github.com/kaas-dev/kaas"

  # Build from source: brew install --HEAD kaas
  head do
    url "https://github.com/kaas-dev/kaas.git", branch: "main"
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
      url "https://github.com/kaas-dev/kaas/releases/download/v0.2.0/kaas_0.2.0_darwin_arm64.tar.gz"
      sha256 "248bf3b1e3201592d2c8f60a8406cee4fb8ad60ad2627080d0d5cd882346debd"
    end
    on_intel do
      url "https://github.com/kaas-dev/kaas/releases/download/v0.2.0/kaas_0.2.0_darwin_amd64.tar.gz"
      sha256 "82895e875995c800898e5423ee73d4789b9c54fbf7acbdb98ee416049461b8a6"
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
