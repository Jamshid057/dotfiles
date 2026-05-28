#!/usr/bin/env bash
set -euo pipefail

info() { printf '\033[0;36m→ %s\033[0m\n' "$*"; }

if ! command -v gh >/dev/null 2>&1; then
  echo "gh topilmadi. Avval o'rnating: brew install gh"
  exit 1
fi

info "GitHub CLI autentifikatsiyasi"
echo "Quyidagi buyruqni bajaring va ko'rsatmalarga amal qiling:"
echo ""
echo "  gh auth login -h github.com -p https -w"
echo ""
echo "Tekshirish:"
echo "  gh auth status"
echo "  gh repo view Jamshid057/dotfiles"

if gh auth status -h github.com 2>/dev/null; then
  info "Allaqachon autentifikatsiya qilingan"
  gh auth setup-git
  info "git uchun gh credential helper yoqildi"
fi
