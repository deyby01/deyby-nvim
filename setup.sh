#!/usr/bin/env bash
#
# Bootstrap this environment on a fresh machine.
#
#   git clone git@github.com:deyby01/deyby-nvim.git ~/.config/nvim
#   ~/.config/nvim/setup.sh
#
# Safe to re-run: it never overwrites without backing up first, and skips
# links that already point where they should.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

bold=$'\e[1m'; green=$'\e[32m'; yellow=$'\e[33m'; red=$'\e[31m'; reset=$'\e[0m'
ok()   { printf '  %s✓%s %s\n' "$green" "$reset" "$1"; }
warn() { printf '  %s!%s %s\n' "$yellow" "$reset" "$1"; }
bad()  { printf '  %s✗%s %s\n' "$red" "$reset" "$1"; }
head_() { printf '\n%s%s%s\n' "$bold" "$1" "$reset"; }

# ------------------------------------------------------------------
# Symlinks: "<file in repo>:<destination>"
# Add a line here to bring another dotfile under version control.
# ------------------------------------------------------------------
LINKS=(
  "tmux.conf:$HOME/.tmux.conf"
)

head_ "Linking dotfiles"
for entry in "${LINKS[@]}"; do
    src="$REPO/${entry%%:*}"
    dest="${entry#*:}"

    if [[ ! -e "$src" ]]; then
        bad "missing in repo: ${entry%%:*}"
        continue
    fi

    if [[ -L "$dest" && "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
        ok "$dest (already linked)"
        continue
    fi

    # Never clobber: anything already there is moved aside, not deleted.
    if [[ -e "$dest" || -L "$dest" ]]; then
        mv "$dest" "$dest.backup-$STAMP"
        warn "$dest existed — saved as $(basename "$dest").backup-$STAMP"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    ok "$dest -> $src"
done

# ------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------
head_ "Required"
req_missing=0
check_req() {
    if command -v "$1" >/dev/null 2>&1; then
        ok "$1${2:+ ($($2 2>/dev/null | head -1))}"
    else
        bad "$1 — $3"
        req_missing=$((req_missing + 1))
    fi
}

check_req nvim        "nvim --version"   "0.12+ required (nvim-treesitter main, vim.lsp.config)"
check_req git         ""                 "needed by lazy.nvim and the treesitter grammars"
check_req curl        ""                 "downloads parsers and the Kulala backend"
check_req node        "node --version"   "22+ required by Copilot and the web language servers"
check_req tree-sitter "tree-sitter --version" "0.26.1+, from your package manager (NOT npm)"
check_req cc          ""                 "a C compiler, to build treesitter parsers"

head_ "Optional"
check_opt() {
    command -v "$1" >/dev/null 2>&1 && ok "$1" || warn "$1 — $2"
}
check_opt rg         "ripgrep: Telescope's text search"
check_opt fd         "fd: faster file finding"
check_opt tmux       "sessions that survive closing the terminal"
check_opt lazydocker "container management with Space+ld"
check_opt gh         "GitHub PRs and issues via Octo"
check_opt jq         "pretty-printing in some scripts"

# ------------------------------------------------------------------
head_ "Next"
cat <<'NEXT'
  1. nvim            plugins install and Mason pulls the language servers.
                     Give it 2-3 minutes, then :qa and reopen.
  2. :Copilot auth   if you use Copilot.
  3. :checkhealth    confirm everything resolved.

  Personal settings (projects folder, git base branch, dashboard name)
  live in lua/config/user.lua — that is the only file to edit.
NEXT

if (( req_missing > 0 )); then
    printf '\n%s%d required tool(s) missing — see docs/installation.md%s\n' "$red" "$req_missing" "$reset"
    exit 1
fi
printf '\n%sReady.%s\n' "$green" "$reset"
