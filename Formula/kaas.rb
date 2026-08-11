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
      url "https://github.com/kaas-dev/kaas/releases/download/v0.1.12/kaas_0.1.12_darwin_arm64.tar.gz"
      sha256 "e223ab659df9cbb043b4bcf232a2b1cdbfe460b64715b319caa4aa64f2aeb2aa"
    end
    on_intel do
      url "https://github.com/kaas-dev/kaas/releases/download/v0.1.12/kaas_0.1.12_darwin_amd64.tar.gz"
      sha256 "6ce866cd5adf065ead3b2cc5a6042912344d8c1a96d39226f69aa7b2bf19f632"
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
