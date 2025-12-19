# 📋 OSC 52 Clipboard - Works over SSH!

> Solution cho clipboard khi SSH/remote

---

## ⚠️ **Vấn đề:**

```
Error: Can't open display: (null)
```

**Nguyên nhân:** 
- Đang SSH vào server
- Không có X11 display local
- xclip không thể access clipboard

---

## ✅ **Giải pháp: OSC 52**

**OSC 52** = Escape sequence protocol
- ✅ Works over SSH!
- ✅ Không cần X server
- ✅ Terminal emulator handle clipboard
- ✅ Works với: WezTerm, iTerm2, Alacritty, etc.

---

## 🔧 **Config đã update:**

### **Tmux:**
```conf
✅ set -g set-clipboard on
✅ set -as terminal-features ',*:clipboard'  
✅ set -s set-clipboard external
✅ OSC 52 enabled!
```

### **Neovim:**
```lua
✅ clipboard=unnamedplus (đã có)
→ Auto dùng OSC 52 trong tmux!
```

---

## 🚀 **Test ngay:**

```bash
# 1. Restart tmux
tmux kill-server
tmux

# 2. Start Neovim
nvim test.txt

# 3. Type text
hello world from SSH!

# 4. Copy
yy           → Yank line

# 5. Paste ra local machine (laptop/desktop)
Ctrl+V (trong app local)
→ Should paste! ✅
```

---

## ⌨️ **Copy Methods (OSC 52):**

### **Trong Neovim:**
```vim
yy           → Copy line
V + y        → Copy selected
"+y          → Explicit clipboard yank
```

### **Trong Tmux copy mode:**
```
Ctrl+a [     → Copy mode
v            → Select
y            → Copy (OSC 52 auto!)
```

### **Mouse:**
```
Select với chuột
→ Auto copy qua OSC 52!
```

---

## 💡 **How it works:**

```
SSH Connection:
┌──────────┐         ┌──────────┐
│  Local   │  SSH    │  Remote  │
│ Machine  ├────────►│  Server  │
│          │         │          │
│ Clipboard│◄────────│ OSC 52   │
└──────────┘         └──────────┘

OSC 52 = Terminal escape sequence
→ Tmux/Neovim send clipboard data
→ Terminal forwards to local clipboard
→ Works transparently!
```

---

## 🎯 **For WezTerm (your terminal):**

WezTerm **fully supports OSC 52**! ✅

Config in `~/.wezterm.lua` (đã có):
```lua
-- Clipboard already enabled in WezTerm
-- No additional config needed!
```

---

## 🐛 **Troubleshooting:**

### **Still not working?**

**Check 1: WezTerm có enable OSC 52 không?**

Default WezTerm **đã enable**, nhưng verify:
```lua
-- Trong ~/.wezterm.lua, có thể thêm:
config.enable_osc_clipboard = true
```

**Check 2: Tmux version:**
```bash
tmux -V
# Cần >= 3.2 cho OSC 52
```

**Check 3: Test OSC 52 directly:**
```bash
# In tmux
printf "\033]52;c;$(printf "hello" | base64)\a"
# Paste → Should work!
```

---

## 📝 **Alternative: Use tmux buffer manually:**

Nếu OSC 52 vẫn không work:

```vim
# Trong Neovim:
yy           → Copy vào tmux buffer

# Trong tmux:
Ctrl+a ]     → Paste từ tmux buffer

# Không copy ra system, nhưng work trong tmux!
```

---

## ✅ **Summary:**

```
Solution: OSC 52
  ✅ Works over SSH
  ✅ No X server needed
  ✅ WezTerm supports it
  ✅ Tmux config updated
  ✅ Neovim ready
  
Test:
  1. tmux kill-server
  2. tmux
  3. nvim
  4. yy
  5. Paste local → Should work!
```

---

## 🎯 **Expected Behavior:**

```
Copy trong tmux/nvim (remote):
  yy

→ OSC 52 sends to terminal
→ WezTerm catches it
→ Updates local clipboard
→ Paste anywhere local! ✅
```

---

**Restart tmux: `tmux kill-server` → `tmux` 🔄**

**Test: `yy` → Paste ra local machine! 📋**

**WezTerm + OSC 52 = Works over SSH! ✨**
