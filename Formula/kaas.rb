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
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.2.1/kaas_0.2.1_darwin_arm64.tar.gz"
      sha256 "45be661fdd4d8d61488e1cd6963df30f016e85d0ceec5e39a8e338957acbef54"
    end
    on_intel do
      url "https://github.com/Stellar-Technology-Services/kaas/releases/download/v0.2.1/kaas_0.2.1_darwin_amd64.tar.gz"
      sha256 "7a9ec4f3960bea66da5304eebd01f7643e2405b6466c2c2fe33649bf1759b081"
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

  # Keep in sync with packaging/homebrew/kaas.rb
  service do
    run [opt_bin/"kaas", "ui", "serve", "--listen", "127.0.0.1:18181"]
    keep_alive true
    working_dir var/"kaas"
    log_path var/"log/kaas-ui.log"
    error_log_path var/"log/kaas-ui.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kaas version")
  end
end
