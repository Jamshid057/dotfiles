# MacBook — tozalab, noldan o'rnatish

Bu qo'llanma: avval **zaxira** → macOS **tozalash** → **dotfiles** bilan dev muhitni qayta tiklash.

Repozitoriya: https://github.com/Jamshid057/dotfiles

---

## 0. O'chirishdan OLDIN — zaxira (majburiy)

### Bulut (tavsiya)

| Nima | Qayerga |
|------|---------|
| iCloud Photos, Desktop, Documents | System Settings → Apple ID → iCloud |
| GitHub repolar | Allaqachon GitHub'da — lokal o'zgarishlarni push qiling |
| 1Password / Bitwarden | Parollar bulutda |
| Notion / Notes | Bulut |

### Tashqi disk yoki boshqa Mac'ga nusxa

```bash
# Muhim papkalar (misol)
rsync -av ~/Documents /Volumes/Backup/Documents
rsync -av ~/Desktop   /Volumes/Backup/Desktop
rsync -av ~/projects  /Volumes/Backup/projects   # push qilinmagan kod
```

### Maxfiy fayllar — qo'lda saqlang

- `~/.ssh/` — **id_ed25519** va `id_ed25519.pub` (GitHub/server uchun)
- `~/.zshrc.local` — mashina-specific PATH
- `.env` fayllar loyihalarda
- API kalitlar, `.env`, database URL
- Browser bookmarklar (Chrome/Safari sync)

**SSH kalitlarni USB yoki shifrlangan arxivga nusxalang.** Tozalashdan keyin GitHub'ga qayta qo'shish kerak bo'ladi.

### GitHub'ga push qiling (hozir)

```bash
cd ~/projects/Shanghai-school   # va boshqa loyihalar
git status
git push   # har bir repo uchun
```

### Dotfiles allaqachon bulutda

```bash
# Tekshirish (boshqa mashinada):
# git clone https://github.com/Jamshid057/dotfiles.git
```

---

## 1. macOS ni tozalash

### Variant A — Eng toza (tavsiya): Erase All Content and Settings

macOS Monterey 12+ / Ventura / Sonoma / Sequoia:

1. **System Settings** → **General** → **Transfer or Reset**
2. **Erase All Content and Settings**
3. Apple ID parolini kiriting
4. Mac qayta ishga tushadi — yangi foydalanuvchi sozlash ekrani

Bu: ilovalar, foydalanuvchi fayllari, sozlamalar — hammasini o'chiradi. macOS qoladi.

### Variant B — To'liq qayta o'rnatish (macOS ham yangi)

1. [support.apple.com](https://support.apple.com/mac-recovery) — Recovery rejimi
2. **Disk Utility** → internal disk → **Erase** (APFS)
3. **Reinstall macOS**

### Variant C — Faqat foydalanuvchi (kamroq toza)

Yangi foydalanuvchi hisobi yaratish — eski hisobni keyin o'chirish.

---

## 2. Birinchi ishga tushirish (yangi macOS)

1. Wi‑Fi, Apple ID, FileVault (yoqing — disk shifrlash)
2. **System Settings** → **Keyboard** → Input source (O'zbek/Ingliz)
3. **App Store** → yangilanishlar
4. Terminal oching (Applications → Utilities)

---

## 3. Dev muhit — ketma-ketlik

Barcha buyruqlar **yangi** Terminalda.

### 3.1 Xcode Command Line Tools

```bash
xcode-select --install
```

Dialog chiqsa — Install.

### 3.2 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Apple Silicon (M1/M2/M3) uchun oxiridagi `echo` buyruqlarini bajaring, masalan:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 3.3 Git (dastlab tizim git yetadi, keyin brew)

```bash
brew install git
```

### 3.4 SSH kalit (zaxiradan qaytargan yoki yangi)

**Eski kalitni qaytargan bo'lsangiz:**

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
# USB dan nusxalang: id_ed25519, id_ed25519.pub
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
ssh -T git@github.com
```

**Yangi kalit:**

```bash
ssh-keygen -t ed25519 -C "irisbayevjamshid@gmail.com" -f ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
# → GitHub.com → Settings → SSH and GPG keys → New SSH key
ssh -T git@github.com
```

### 3.5 Dotfiles

```bash
git clone https://github.com/Jamshid057/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3.6 Homebrew paketlar (Brewfile)

```bash
brew bundle install --file=Brewfile
```

### 3.7 Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

Pluginlar (syntax highlighting):

```bash
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
```

Yoki Brew:

```bash
echo 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc.local
```

### 3.8 Dotfiles symlink

```bash
cd ~/dotfiles
chmod +x install.sh scripts/setup-gh.sh
./install.sh
source ~/.zshrc
```

### 3.9 GitHub CLI

```bash
gh auth login -h github.com -p https -w
gh auth setup-git
gh auth status
```

### 3.10 tmux pluginlar

```bash
tmux new -s test
# Ctrl+s, keyin I — TPM o'rnatadi
# Ctrl+s, keyin d — chiqish
```

### 3.11 Ghostty

```bash
brew install --cask ghostty
# yoki install.sh allaqachon config ulagan
open -a Ghostty
```

Shrift: **JetBrains Mono** — [jetbrains.com/mono](https://www.jetbrains.com/lp/mono/)

### 3.12 Neovim (ixtiyoriy keyinroq)

```bash
# LazyVim yoki o'zingizning init.lua — alohida repo bo'lishi mumkin
```

---

## 4. Loyihalarni qayta tiklash

```bash
mkdir -p ~/projects && cd ~/projects
gh repo clone Jamshid057/Shanghai-school   # misol
# yoki
git clone git@github.com:Jamshid057/REPO.git
```

Har loyiha uchun `.env` — zaxiradan qo'lda yoki 1Password'dan.

---

## 5. Tekshirish ro'yxati

- [ ] `git --version` va `git config user.name`
- [ ] `gh auth status`
- [ ] `ssh -T git@github.com`
- [ ] `tmux` + prefix `Ctrl+s`
- [ ] Ghostty ochiladi, Tokyo Night
- [ ] `nvim`, `bat` ishlaydi
- [ ] Loyiha `npm install` / `pnpm install` muvaffaqiyatli

---

## 6. O'rnatish tartibi (qisqa)

```
macOS Erase
  → Apple ID + FileVault
  → xcode-select --install
  → Homebrew
  → git clone dotfiles
  → brew bundle
  → Oh My Zsh + pluginlar
  → ./install.sh
  → gh auth login
  → SSH kalit
  → tmux TPM (Ctrl+s I)
  → JetBrains Mono
  → loyihalarni clone
```

---

## 7. Nimalarni qayta o'rnatish SHART emas

| Narsa | Sabab |
|-------|--------|
| Eski `~/dotfiles` (rahmonov) | Yangi repo: Jamshid057/dotfiles |
| `node_modules`, `venv` | `npm install` / `pip install` |
| Docker image'lar | `docker pull` |
| Homebrew cache | Avtomatik yuklanadi |

---

## 8. Muammo

| Muammo | Yechim |
|--------|--------|
| `brew: command not found` | `eval "$(/opt/homebrew/bin/brew shellenv)"` |
| GitHub clone 403 | `gh auth login` yoki SSH kalit |
| Oh My Zsh plugin yo'q | `git clone` custom/plugins ga |
| Ghostty config yo'q | `cd ~/dotfiles && ./install.sh` |
