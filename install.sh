#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

info()  { printf '\033[0;36m→ %s\033[0m\n' "$*"; }
warn()  { printf '\033[0;33m! %s\033[0m\n' "$*"; }
error() { printf '\033[0;31m✗ %s\033[0m\n' "$*" >&2; exit 1; }

link_file() {
  local src="$1"
  local dest="$2"

  [[ -f "$src" ]] || error "Manba topilmadi: $src"

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
      info "Allaqachon ulangan: $dest"
      return 0
    fi
    mkdir -p "$BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/" 2>/dev/null || cp -a "$dest" "$BACKUP_DIR/"
    warn "Zaxiralandi: $dest → $BACKUP_DIR/"
  fi

  ln -sf "$src" "$dest"
  info "Ulandi: $dest → $src"
}

install_tpm() {
  local tpm_dir="${HOME}/.tmux/plugins/tpm"
  if [[ -d "$tpm_dir/.git" ]]; then
    info "TPM allaqachon o'rnatilgan"
    return 0
  fi
  info "tmux-plugin-manager (TPM) o'rnatilmoqda..."
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

main() {
  info "Dotfiles o'rnatilmoqda: $DOTFILES_DIR"

  link_file "$DOTFILES_DIR/git/gitconfig"       "$HOME/.gitconfig"
  link_file "$DOTFILES_DIR/zsh/zshrc"           "$HOME/.zshrc"
  link_file "$DOTFILES_DIR/tmux/tmux.conf"      "$HOME/.tmux.conf"
  link_file "$DOTFILES_DIR/ghostty/config"      "$HOME/.config/ghostty/config"
  link_file "$DOTFILES_DIR/gh/config.yml"       "$HOME/.config/gh/config.yml"

  install_tpm

  info "Tayyor! Keyingi qadamlar:"
  echo "  1. source ~/.zshrc"
  echo "  2. tmux ichida: prefix + I  (pluginlarni yuklash)"
  echo "  3. gh auth login  (GitHub CLI)"
  echo ""
  [[ -d "$BACKUP_DIR" ]] && warn "Eski fayllar: $BACKUP_DIR"
}

main "$@"
