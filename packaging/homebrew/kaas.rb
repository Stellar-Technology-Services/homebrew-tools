# Canonical Homebrew service fragment for kaas.
# Maintainers: keep Formula/kaas.rb in sync with this snippet.
#
# User flow:
#   brew services start kaas   # or: kaas ui start
#   brew services stop kaas

service do
  run [opt_bin/"kaas", "ui", "serve", "--listen", "127.0.0.1:18181"]
  keep_alive true
  working_dir var/"kaas"
  log_path var/"log/kaas-ui.log"
  error_log_path var/"log/kaas-ui.err.log"
end
