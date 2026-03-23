# Homebrew Tap for psyXe

Homebrew formulae for [psyXe](https://github.com/bjenkinsgit/psyxe-mcp) tools.

## Install

```bash
brew tap bjenkinsgit/tap
brew install psyxe-mcp
```

This installs the MCP server binary, Swift helpers, and pre-downloads the BERT model for semantic search. FFmpeg is installed automatically as a dependency.

After installing, configure your AI assistant to use it — see **[MCP Client Setup](https://github.com/bjenkinsgit/psyxe-mcp#configure-your-mcp-client)** in the main repo for Claude Code, Claude Desktop, Cursor, Codex CLI, and Windsurf instructions.

## Available Formulae

| Formula | Description |
|---------|-------------|
| `psyxe-mcp` | Apple ecosystem MCP server — Notes, Reminders, Contacts with BERT semantic search |

## Updating

```bash
brew update
brew upgrade psyxe-mcp
```
