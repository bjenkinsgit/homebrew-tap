class PsyxeMcp < Formula
  desc "Apple ecosystem MCP server — Notes, Reminders, Contacts with BERT semantic search"
  homepage "https://github.com/bjenkinsgit/psyxe-mcp"
  version "0.1.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/bjenkinsgit/psyxe-mcp/releases/download/v0.1.5/psyxe-mcp-0.1.5-arm64-apple-darwin.tar.gz"
      sha256 "ca651853c55b6a8ce76089e85af25c6412d62e23800f2a6dcc7b06121be9fdfd"
    end
  end

  depends_on :macos
  depends_on "ffmpeg"

  def install
    bin.install "bin/psyxe-mcp"
    bin.install "bin/reminders-helper"
    bin.install "bin/contacts-helper"

    # Install supporting files
    pkgshare.install "share/psyxe-mcp/scripts"
    pkgshare.install "share/psyxe-mcp/tools.json"

    if (buildpath/"share/psyxe-mcp/shortcuts").exist?
      pkgshare.install "share/psyxe-mcp/shortcuts"
    end

    if (buildpath/"share/psyxe-mcp/install-shortcuts.sh").exist?
      pkgshare.install "share/psyxe-mcp/install-shortcuts.sh"
    end
  end

  def post_install
    # Pre-download the BERT model for semantic search (~90MB)
    ohai "Downloading BERT model for semantic search..."
    system bin/"psyxe-mcp", "warmup"
  end

  def caveats
    <<~EOS
      psyXe MCP server is installed. To use it with your AI assistant:

      Claude Code:
        claude mcp add psyxe -- #{bin}/psyxe-mcp

      Claude Desktop (~/Library/Application Support/Claude/claude_desktop_config.json):
        {
          "mcpServers": {
            "psyxe": { "command": "#{bin}/psyxe-mcp" }
          }
        }

      Cursor (Settings → MCP Servers):
        { "psyxe": { "command": "#{bin}/psyxe-mcp" } }

      OpenAI Codex CLI (~/.codex/config.toml):
        [mcp_servers.psyxe]
        command = "#{bin}/psyxe-mcp"

      Access control (restrict what the AI can see):
        psyxe-mcp access discover reminders   # see available lists
        psyxe-mcp access discover notes        # see available folders
        psyxe-mcp access grant reminders "Work"
        psyxe-mcp access grant notes "Projects"
        psyxe-mcp access list                  # verify restrictions

        The first grant command creates ~/.psyxe/access.toml with secure
        permissions. Once a category has any rule, only granted resources
        are accessible — everything else in that category is denied.

      Install Apple Shortcuts (optional):
        #{pkgshare}/install-shortcuts.sh

      Sample notes for demo:
        See https://github.com/bjenkinsgit/psyxe-mcp/tree/main/examples
    EOS
  end

  test do
    assert_match "psyxe-mcp", shell_output("#{bin}/psyxe-mcp --version")
  end
end
