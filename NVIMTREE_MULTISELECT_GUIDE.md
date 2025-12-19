# 📁 NvimTree Multi-Select - Complete Guide

## ⚠️ **Vấn đề: `bd` chỉ xóa 1 file**

**Nguyên nhân:** `bd` có thể là keymap cũ, hoặc không work đúng với marks.

## ✅ **Giải pháp:**

Config mới đã update sang dùng **`M` (Shift+m)** để delete all marked!

---

## 🎯 **Keymaps MỚI (sau restart):**

| Phím | Chức năng | Note |
|------|-----------|------|
| `m` | Mark file | Toggle on/off |
| **`M`** | Delete ALL marked | **Shift+m** ⭐ |
| `sm` | Show marked list | Verify |
| `cm` | Clear marks | Unmark all |
| `d` | Delete 1 file | No mark needed |

---

## 🔧 **Test từng bước:**

### **Step 1: Restart Neovim**
```bash
# PHẢI restart để apply keymaps mới!
:qa
nvim
```

### **Step 2: Test mark**
```vim
<Space>ee        # Mở NvimTree

m                # Mark file hiện tại
                 # Xem có icon ✓ xuất hiện không?
```

**Expected:** File có icon ✓ hoặc thay đổi màu

### **Step 3: Mark nhiều files**
```vim
m                # Mark file 1
j j              # Move down
m                # Mark file 2
j j
m                # Mark file 3
```

### **Step 4: Verify**
```vim
sm               # Show marked
                 # Popup: "Marked 3 files: ..."
```

**Nếu "No marked files" → `m` không work!**

### **Step 5: Delete**
```vim
M                # Shift+m (NOT bd!)
                 # Confirm: Yes
                 # ✅ All marked files deleted
```

---

## 🐛 **Nếu `m` không mark được:**

### **Debug 1: Check keymap**
```vim
# Trong NvimTree:
:verbose nmap m
```

**Should show:** "Toggle Mark"

### **Debug 2: Check API**
```vim
:lua print(vim.inspect(require("nvim-tree.api").marks))
```

**Should show:** marks functions

### **Debug 3: Test manually**
```vim
:lua require("nvim-tree.api").marks.toggle()
```

**Should:** Mark file tại cursor

---

## 💡 **Alternative: Dùng Visual mode trong Neovim buffer**

Nếu marks không work, **alternative workaround:**

### **Delete nhiều files bằng cách khác:**

**Method 1: Delete từng file nhanh**
```vim
d           # Delete file 1
j j         # Next
d           # Delete file 2
j j
d           # Delete file 3

→ Nhanh nếu ít files
```

**Method 2: Dùng command line**
```bash
# Exit Neovim
# Dùng rm trong terminal
rm file1.js file2.js file3.js

# Hoặc
rm -i file*.js    # Interactive confirm
```

**Method 3: Dùng LazyGit**
```vim
<Space>lg    # Mở LazyGit
# Delete files trong LazyGit UI
```

---

## 🎯 **Test checklist:**

```
☑️  Restart Neovim (PHẢI làm!)
☑️  <Space>ee
☑️  Navigate to file
☑️  Press m
☑️  See ✓ icon? (Yes → works, No → issue)
☑️  Press j j, press m again
☑️  Press sm (should show 2 files)
☑️  Press M (Shift+m) to delete
```

---

## 🔑 **Important:**

### **Differences:**
```
m (lowercase)     → Mark file
M (UPPERCASE)     → Delete marked
bd                → Old/không work
```

### **Must restart:**
```
❌ Config change → m vẫn old keymap
✅ Restart Neovim → m = new keymap
```

---

## 🚀 **Verify setup:**

### **After restart, trong NvimTree:**

```vim
# Test help
g?

# Should see in help:
# m    Toggle Mark
# M    Delete ALL Marked
# sm   Show Marked
# cm   Clear Marks
```

**Nếu không thấy → Config chưa apply!**

---

## 📝 **Quick commands:**

```vim
" Restart để apply config
:qa

" Reopen
nvim

" Test
<Space>ee
m m m     " Mark 3 files
sm        " Verify: "3 files"
M         " Delete all
```

---

## 🎉 **Summary:**

**Keymap mới:**
- `m` = mark
- `M` = delete marked ⭐
- `sm` = show
- `cm` = clear

**Old/không dùng:**
- ❌ `bd` (không reliable)
- ❌ `v` (đó là vertical split)

**Must do:**
- ⚠️ **RESTART NEOVIM** để apply!

---

**Restart ngay: `:qa` → `nvim` → test `m` 🚀**

