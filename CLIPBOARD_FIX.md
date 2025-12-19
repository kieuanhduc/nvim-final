# 📋 Clipboard Fix - Tmux + Neovim

> Copy từ Neovim/tmux → Paste ra ngoài!

---

## ✅ **Đã fix:**

### **1. Tmux config:**
```conf
# Copy mode yank vào system clipboard
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
```

### **2. Neovim config:**
```lua
opt.clipboard:append("unnamedplus")  ✅ Đã có!
```

### **3. Tools:**
- ✅ xclip - Đã cài
- ✅ xsel - Đã cài
- ✅ wl-copy - Đã cài (Wayland)

---

## 🔧 **Reload tmux config:**

```bash
# Option 1: Trong tmux
Ctrl+a r    → Reload config

# Option 2: Restart tmux
tmux kill-server
tmux

# Option 3: Source manual
tmux source ~/.tmux.conf
```

---

## 🚀 **Test Copy/Paste:**

### **Test 1: Trong Neovim (tmux):**
```vim
# Mở nvim trong tmux
nvim test.txt

# Type some text
hello world

# Copy với Neovim
yy          → Yank line
# Or Visual mode
V
y           → Yank

# Paste ra ngoài (browser, terminal khác)
Ctrl+Shift+V    → Should work! ✅
```

### **Test 2: Tmux copy mode:**
```
# Trong tmux
Ctrl+a [      → Enter copy mode
v             → Begin selection
y             → Yank to clipboard

# Paste ra ngoài
Ctrl+Shift+V  → Should work! ✅
```

### **Test 3: Mouse select:**
```
# Select text bằng chuột
# Auto copy vào clipboard
# Paste anywhere với Ctrl+Shift+V
```

---

## ⌨️ **Copy Methods:**

### **Neovim (trong tmux):**
| Method | Keys | Clipboard |
|--------|------|-----------|
| Yank line | `yy` | ✅ System |
| Visual yank | `V` + `y` | ✅ System |
| Visual line | `Shift+v` + `y` | ✅ System |
| Word | `yiw` | ✅ System |

### **Tmux copy mode:**
| Method | Keys | Clipboard |
|--------|------|-----------|
| Enter mode | `Ctrl+a [` | - |
| Select | `v` | - |
| Copy | `y` | ✅ System |
| Mouse select | Drag | ✅ System (auto) |

### **Paste:**
```bash
# Trong Neovim
p           → Paste

# Trong terminal/browser
Ctrl+Shift+V    → Paste từ clipboard
# Or
Middle-click    → Paste (Linux)
```

---

## 🐛 **If Still Not Working:**

### **Check 1: Neovim clipboard**
```vim
# Trong Neovim:
:echo has('clipboard')
# Should return: 1

:set clipboard?
# Should show: clipboard=unnamedplus
```

### **Check 2: Test xclip**
```bash
# Test xclip directly
echo "test" | xclip -selection clipboard
# Paste somewhere (Ctrl+Shift+V)
# Should paste "test"
```

### **Check 3: Tmux clipboard**
```bash
# Check tmux-yank working
tmux show-options -g | grep @yank
```

### **Check 4: Environment**
```bash
# Check DISPLAY variable (for X11)
echo $DISPLAY
# Should show: :0 or :1

# For Wayland:
echo $WAYLAND_DISPLAY
```

---

## 🔧 **Alternative: Use tmux-yank plugin:**

Tmux-yank plugin **đã được cài**! Test:

```
Trong tmux:
Ctrl+a [       → Copy mode
Select text với v
y              → Yank

→ Should copy to system clipboard automatically!
```

---

## 💡 **Pro Tips:**

### **Tip 1: Use Neovim yank (easiest):**
```vim
# Trong Neovim (tmux hoặc không):
yy         → Copy line
            → Auto vào clipboard! ✅
```

### **Tip 2: Visual mode:**
```vim
V          → Visual line
y          → Copy
→ Clipboard ready!
```

### **Tip 3: Mouse:**
```
# Enable mouse trong tmux ✅ (đã có)
Select bằng chuột
Auto copy!
Paste anywhere!
```

---

## 📝 **Quick Reference:**

```
Copy trong Neovim:
  yy / V+y     → System clipboard

Copy trong tmux:
  Ctrl+a [     → Copy mode
  v            → Select
  y            → Copy to clipboard

Paste:
  p            → Trong Neovim
  Ctrl+Shift+V → Ngoài Neovim
  Middle-click → Linux paste
```

---

## ✅ **Summary:**

```
Config fixed:
  ✅ Tmux → xclip integration
  ✅ Neovim → clipboard=unnamedplus
  ✅ xclip/xsel/wl-copy installed
  ✅ tmux-yank plugin active
  
Next:
  1. tmux kill-server
  2. tmux
  3. Test copy (yy trong nvim)
  4. Paste outside (Ctrl+Shift+V)
```

---

**Restart tmux: `tmux kill-server` → `tmux` 🔄**

**Test: `nvim` → `yy` → Paste ra browser! 📋**

**Giờ sẽ work! ✨**
