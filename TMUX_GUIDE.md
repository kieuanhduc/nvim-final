# 🖥️ Tmux Setup Guide

> Based on: https://github.com/josean-dev/dev-environment-files

---

## ✅ **Setup:**

### **1. Install tmux:**
```bash
# Ubuntu/Debian
sudo apt install tmux

# Or latest version
sudo add-apt-repository ppa:tmux/tmux
sudo apt update
sudo apt install tmux
```

### **2. Copy config:**
```bash
# Config đã tạo tại: ~/.tmux.conf
cat ~/.tmux.conf
```

### **3. Install TPM (Plugin Manager):**
```bash
# TPM sẽ auto install khi mở tmux lần đầu
# Hoặc manual:
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### **4. Start tmux:**
```bash
tmux
```

### **5. Install plugins:**
```
Trong tmux:
Prefix + I (Ctrl+a rồi Shift+i)
→ Plugins sẽ được install
```

---

## ⌨️ **Prefix Key: `Ctrl+a`**

(Thay vì default `Ctrl+b`)

---

## 🎯 **Essential Keybindings:**

### **Sessions:**
```bash
tmux                  → Start new session
tmux new -s name      → New named session
tmux attach -t name   → Attach to session
tmux ls               → List sessions

# Trong tmux:
Ctrl+a d              → Detach session
Ctrl+a $              → Rename session
```

### **Windows (tabs):**
```
Ctrl+a c              → New window
Ctrl+a ,              → Rename window
Ctrl+a &              → Close window
Shift+Left/Right      → Previous/Next window
Alt+H / Alt+L         → Previous/Next window
Ctrl+a 0-9            → Switch to window number
```

### **Panes (splits):**
```
Ctrl+a |              → Split vertical
Ctrl+a -              → Split horizontal
Ctrl+a x              → Close pane

# Navigation (Vim-style):
Ctrl+a h/j/k/l        → Move between panes
Alt+Arrow keys        → Move between panes (no prefix!)

# Or với vim-tmux-navigator:
Ctrl+h/j/k/l          → Navigate seamlessly b/w Neovim & tmux!
```

### **Resize Panes:**
```
Ctrl+a Ctrl+Arrow     → Resize pane
```

### **Copy Mode:**
```
Ctrl+a [              → Enter copy mode
v                     → Begin selection (vi mode)
y                     → Copy selection
q                     → Exit copy mode
```

### **Other:**
```
Ctrl+a r              → Reload config
Ctrl+a ?              → Show all keybindings
Ctrl+a z              → Zoom/maximize pane
```

---

## 🎨 **Theme:**

**Tokyo Night** (synced với Neovim!)
- Background: `#1a1b26`
- Active: Blue `#7aa2f7`
- Text: `#c0caf5`

---

## 🔌 **Plugins:**

| Plugin | Function |
|--------|----------|
| **tpm** | Plugin manager |
| **tmux-sensible** | Sensible defaults |
| **vim-tmux-navigator** | Navigate b/w Neovim & tmux với Ctrl+hjkl |
| **tmux-yank** | Copy to system clipboard |

---

## 🚀 **Workflow với Neovim:**

### **Seamless Navigation:**
```
Trong Neovim:
Ctrl+h    → Tmux pane trái
Ctrl+j    → Tmux pane dưới
Ctrl+k    → Tmux pane trên
Ctrl+l    → Tmux pane phải

→ Navigate giữa Neovim splits và tmux panes seamlessly!
```

### **Typical Layout:**
```
┌────────────────────────────────────┐
│ Tmux Window 1: nvim                │
├──────────────────┬─────────────────┤
│                  │                 │
│  Neovim          │  Terminal       │
│  (coding)        │  (commands)     │
│                  │                 │
│                  ├─────────────────┤
│                  │  Git/Tests      │
└──────────────────┴─────────────────┘

Ctrl+h/l → Switch seamlessly!
```

---

## 💡 **Common Workflows:**

### **Workflow 1: Code + Terminal**
```bash
tmux
Ctrl+a |       → Split vertical
# Left: nvim
# Right: terminal (npm run, tests, etc.)
Ctrl+h/l       → Switch between them
```

### **Workflow 2: Multiple projects**
```bash
tmux new -s project1
# Work on project1

Ctrl+a d       → Detach

tmux new -s project2
# Work on project2

tmux ls        → List sessions
tmux attach -t project1  → Back to project1
```

### **Workflow 3: Code + Git + Server**
```bash
tmux
Ctrl+a |       → Split (nvim | terminal)
Ctrl+a -       → Split bottom (lazygit)
# Top: nvim + terminal
# Bottom: git UI
```

---

## 🔧 **Customization:**

### **Change prefix:**
```conf
# Trong ~/.tmux.conf:
set -g prefix C-a    # Current
# set -g prefix C-s  # Alternative
```

### **Change theme colors:**
```conf
# Status bar
set -g status-style 'bg=#YOUR_BG fg=#YOUR_FG'

# Active window
setw -g window-status-current-style 'fg=#YOUR_FG bg=#YOUR_BG'
```

---

## 🐛 **Troubleshooting:**

### **Plugins không install:**
```bash
# Trong tmux:
Ctrl+a I       → Capital I to install

# Or manual:
cd ~/.tmux/plugins/tpm
./bin/install_plugins
```

### **vim-tmux-navigator không work:**
```
# Check plugin installed
ls ~/.tmux/plugins/

# Reinstall
Ctrl+a I
```

### **Colors không đúng:**
```bash
# Check terminal
echo $TERM
# Should be: screen-256color or tmux-256color

# Add to shell config:
alias tmux='tmux -2'
```

### **Config không reload:**
```
Ctrl+a r      → Reload
# Or restart tmux:
tmux kill-server
tmux
```

---

## 📝 **Quick Reference:**

```
Prefix: Ctrl+a

Sessions:
  d          Detach
  $          Rename

Windows:
  c          New window
  ,          Rename window
  &          Close window
  Shift+←/→  Previous/Next

Panes:
  |          Split vertical
  -          Split horizontal
  h/j/k/l    Navigate (Vim-style)
  x          Close pane
  z          Zoom pane

Copy:
  [          Copy mode
  v          Begin selection
  y          Copy
  
Other:
  r          Reload config
  ?          Show help
```

---

## 🎉 **Integration với Neovim:**

**Seamless workflow:**
1. Tmux cho terminal multiplexing
2. Neovim cho editing
3. `Ctrl+h/j/k/l` navigate tất cả
4. LazyGit trong tmux pane

**→ Professional development environment! 🏆**

---

## 🚀 **Start Using:**

```bash
# Start tmux
tmux

# Or with name
tmux new -s coding

# Split & start nvim
Ctrl+a |
nvim

# Navigate
Ctrl+h/l

# Enjoy! 🎉
```

---

**Config file: `~/.tmux.conf` ✅**

**Restart tmux: `tmux kill-server` → `tmux` 🚀**

**Integrated với Neovim perfectly! ✨**

