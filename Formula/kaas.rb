class Kaas < Formula
  desc "Persistent local Linux workspaces for coding agents"
  homepage "https://github.com/Stellar-Technology-Services/kaas"
  url "https://github.com/Stellar-Technology-Services/kaas.git",
      tag:      "v0.1.0",
      revision: "c3a84ec202cd42ec775357b4881b9cf84860e9a3"
  head "https://github.com/Stellar-Technology-Services/kaas.git", branch: "main"

  depends_on "go" => :build
  depends_on "ansible"
  depends_on "colima"
  depends_on "herdr"
  depends_on :macos
  depends_on "secretspec"

  def install
    ldflags = "-X github.com/Stellar-Technology-Services/agent-sandbox/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/kaas"
    generate_completions_from_executable(bin/"kaas", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kaas version")
  end
end
