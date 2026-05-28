# dotfiles — Jamshid057

Shaxsiy macOS dev muhiti: **Ghostty**, **tmux**, **zsh**, **git**, **GitHub CLI (gh)**.

Repozitoriya: [github.com/Jamshid057/dotfiles](https://github.com/Jamshid057/dotfiles)

---

## Tez o'rnatish (Quick Start)

### 1. Asboblar

```bash
# Homebrew bo'lmasa: https://brew.sh
brew bundle install --file=Brewfile
```

Yoki qo'lda:

```bash
brew install git gh tmux neovim bat zsh-autosuggestions zsh-syntax-highlighting
brew install --cask ghostty
```

### 2. Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Syntax highlighting (Homebrew)
echo 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc.local
```

`zsh-autosuggestions` Oh My Zsh plugin sifatida `~/.oh-my-zsh/custom/plugins/` ga symlink qiling yoki Brew versiyasidan foydalaning.

### 3. Dotfiles clone va install

```bash
git clone https://github.com/Jamshid057/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh scripts/setup-gh.sh
./install.sh
source ~/.zshrc
```

### 4. GitHub CLI (gh) + git

```bash
./scripts/setup-gh.sh
gh auth login -h github.com -p https -w
gh auth setup-git
gh auth status
```

### 5. tmux pluginlar

```bash
tmux
# Prefix: Ctrl+s, keyin I (TPM pluginlarni o'rnatadi)
```

---

## Struktura

```
dotfiles/
├── install.sh          # Symlink o'rnatish
├── Brewfile            # Homebrew paketlar
├── git/gitconfig       # → ~/.gitconfig
├── gh/config.yml       # → ~/.config/gh/config.yml
├── ghostty/config      # → ~/.config/ghostty/config
├── tmux/tmux.conf      # → ~/.tmux.conf
├── zsh/zshrc           # → ~/.zshrc
└── scripts/setup-gh.sh
```

**Eslatma:** `gh` tokenlari `~/.config/gh/hosts.yml` da saqlanadi va repoga **kiritilmaydi**.

Mahalliy override uchun `~/.zshrc.local` yarating (git ignore qilinmaydi — sizning mashinangizda qoladi).

---

## Ghostty

- Tema: Tokyo Night Night
- Shrift: JetBrains Mono 14
- Tmux bilan: `shell-integration = zsh`

Ghostty ochgandan keyin tmux:

```bash
tmux new -s dev
```

---

## tmux

| Tugma | Vazifa |
|--------|--------|
| `Ctrl+s` | Prefix |
| `Ctrl+s` + `I` | TPM pluginlarni o'rnatish |
| `Ctrl+s` + `r` | Konfigni qayta yuklash |
| `h/j/k/l` | Panellar orasida harakat |

---

## Yangilash

```bash
cd ~/dotfiles
git pull
./install.sh
source ~/.zshrc
```

---

## MacBookni tozalab noldan o'rnatish

To'liq qo'llanma: **[FRESH_INSTALL.md](./FRESH_INSTALL.md)** — zaxira, Erase macOS, SSH, dotfiles, tekshirish ro'yxati.

---

## Yangi mashinada (to'liq)

```bash
xcode-select --install 2>/dev/null || true
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone https://github.com/Jamshid057/dotfiles.git ~/dotfiles
cd ~/dotfiles
brew bundle install --file=Brewfile
./install.sh
gh auth login
```

---

## Muammolar

| Muammo | Yechim |
|--------|--------|
| `gh: authentication required` | `gh auth login` |
| tmux ranglari yo'q | `TERM=screen-256color` |
| Ghostty topilmaydi | `brew install --cask ghostty` |
| zsh plugin sekin | `zsh-syntax-highlighting` ni `zshrc` oxirida source qiling |

---

## Litsenziya

Shaxsiy foydalanish — erkin nusxalang va moslashtiring.
