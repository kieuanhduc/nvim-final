# 🚀 Neovim Configuration - Optimized Setup

> Config Neovim được tối ưu hiệu năng với lazy loading, dựa trên [Josean Dev](https://github.com/josean-dev/dev-environment-files)

---

## 📋 Mục lục

- [Yêu cầu hệ thống](#-yêu-cầu-hệ-thống)
- [Cài đặt](#-cài-đặt)
- [Plugins chính](#-plugins-chính)
- [Hướng dẫn sử dụng](#-hướng-dẫn-sử-dụng)
- [Cấu hình](#️-cấu-hình)
- [Troubleshooting](#-troubleshooting)

---

## 💻 Yêu cầu hệ thống

- **Neovim** >= 0.9.0
- **Git** >= 2.19.0
- **Node.js** >= 18.0 (cho LSP servers)
- **Nerd Font** (khuyến nghị: [Meslo Nerd Font](https://github.com/ryanoasis/nerd-fonts))
- **ripgrep** (cho Telescope)
- **lazygit** (optional - cho Git UI)

### Cài đặt dependencies (Ubuntu/Debian):

```bash
# Neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

# Ripgrep
sudo apt install ripgrep

# Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

---

## 🎯 Cài đặt

1. **Backup config cũ (nếu có):**
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. **Clone config này:**
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. **Mở Neovim:**
```bash
nvim
```

4. **Chờ plugins tự động cài đặt** (lazy.nvim sẽ tự động cài tất cả plugins)

5. **Cài đặt LSP servers:**
```vim
:Mason
```
Trong Mason UI, tìm và cài các language servers bạn cần (ví dụ: `lua_ls`, `tsserver`, `pyright`)

---

## 🔌 Plugins chính

### Core
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager với lazy loading
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Lua functions library

### UI & Navigation
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder cho files, text, commands
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer tabs
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Statusline
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)** - Dashboard
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keymap hints
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Navigation nhanh

### LSP & Completion
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP/formatter/linter installer
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine

### Code Enhancement
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto close brackets
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Surround text objects
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Toggle comments
- **[substitute.nvim](https://github.com/gbprod/substitute.nvim)** - Replace with register

### Formatting & Linting
- **[none-ls.nvim](https://github.com/nvimtools/none-ls.nvim)** (null-ls fork) - Formatter & linter
- **[nvim-lint](https://github.com/mfussenegger/nvim-lint)** - Linting

### Git Integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations & hunks
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)** - LazyGit integration

### AI Assistant
- **[copilot.lua](https://github.com/zbirenbaum/copilot.lua)** - GitHub Copilot
- **[CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)** - Chat với Copilot

### Utilities
- **[nvim-spectre](https://github.com/nvim-pack/nvim-spectre)** - Search & Replace
- **[auto-session](https://github.com/rmagatti/auto-session)** - Session management
- **[todo-comments.nvim](https://github.com/folke/todo-comments.nvim)** - Highlight TODO comments
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** - Diagnostics list
- **[dressing.nvim](https://github.com/stevearc/dressing.nvim)** - Better UI
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides

---

## 📚 Hướng dẫn sử dụng

### ⌨️ Leader Key: `Space` (phím cách)

---

### 1️⃣ **Cơ bản**

| Phím | Chức năng | Mode |
|------|-----------|------|
| `jk` | Thoát Insert mode | Insert |
| `<Space>nh` | Xóa highlight tìm kiếm | Normal |
| `<Space>+` | Tăng số | Normal |
| `<Space>-` | Giảm số | Normal |

---

### 2️⃣ **Quản lý cửa sổ & Tab**

#### Splits
| Phím | Chức năng |
|------|-----------|
| `<Space>sv` | Split dọc |
| `<Space>sh` | Split ngang |
| `<Space>se` | Làm splits bằng nhau |
| `<Space>sx` | Đóng split hiện tại |
| `<Space>sm` | Maximize/minimize split |

#### Tabs
| Phím | Chức năng |
|------|-----------|
| `<Space>to` | Mở tab mới |
| `<Space>tx` | Đóng tab hiện tại |
| `<Space>tn` | Tab tiếp theo |
| `<Space>tp` | Tab trước đó |
| `<Space>tf` | Mở buffer hiện tại trong tab mới |

---

### 3️⃣ **File Explorer (NvimTree)** 📁

#### Keymaps
| Phím | Chức năng |
|------|-----------|
| `<Space>ee` | Toggle file explorer |
| `<Space>ef` | Tìm file hiện tại trong explorer |
| `<Space>ec` | Thu gọn explorer |
| `<Space>er` | Refresh explorer |
| `<Space>E` | Focus vào explorer |

#### Trong NvimTree
| Phím | Chức năng |
|------|-----------|
| `a` | Tạo file/folder mới |
| `d` | Xóa file/folder |
| `r` | Rename |
| `x` | Cut |
| `c` | Copy |
| `p` | Paste |
| `y` | Copy tên file |
| `Y` | Copy đường dẫn tương đối |
| `gy` | Copy đường dẫn tuyệt đối |
| `Enter` | Mở file/folder |
| `o` | Mở file |
| `v` | Mở trong split dọc |
| `s` | Mở trong split ngang |
| `t` | Mở trong tab mới |
| `W` | Thu gọn toàn bộ |
| `E` | Mở rộng toàn bộ |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `I` | Toggle gitignore files |

---

### 4️⃣ **Tìm kiếm (Telescope)** 🔍

| Phím | Chức năng |
|------|-----------|
| `<Space>ff` | Tìm file trong project |
| `<Space>fr` | Tìm file đã mở gần đây |
| `<Space>fs` | Tìm text trong project (live grep) |
| `<Space>fc` | Tìm text dưới con trỏ |
| `<Space>ft` | Tìm TODO comments |
| `<Space>fk` | Xem tất cả keymaps |

#### Trong Telescope
| Phím | Chức năng |
|------|-----------|
| `Ctrl+j/k` | Di chuyển xuống/lên |
| `Ctrl+q` | Gửi kết quả vào quickfix list |
| `Ctrl+t` | Mở trong Trouble |
| `Enter` | Mở file |
| `Ctrl+x` | Mở trong split ngang |
| `Ctrl+v` | Mở trong split dọc |
| `Ctrl+t` | Mở trong tab mới |

---

### 5️⃣ **Buffer Management** 📑

| Phím | Chức năng |
|------|-----------|
| `Shift+h` hoặc `[b` | Buffer trước |
| `Shift+l` hoặc `]b` | Buffer sau |
| `<Space>bp` | Pin/unpin buffer |
| `<Space>bo` | Đóng các buffers khác |
| `<Space>br` | Đóng buffers bên phải |
| `<Space>bl` | Đóng buffers bên trái |
| `<Space>bP` | Đóng tất cả buffers không pin |

---

### 6️⃣ **Git Integration** 🔀

#### LazyGit
| Phím | Chức năng |
|------|-----------|
| `<Space>lg` | Mở LazyGit UI |

#### Gitsigns
| Phím | Chức năng |
|------|-----------|
| `]h` | Đi đến hunk tiếp theo |
| `[h` | Đi đến hunk trước |
| `<Space>hp` | Preview hunk |
| `<Space>hs` | Stage hunk |
| `<Space>hr` | Reset hunk |
| `<Space>hS` | Stage toàn bộ buffer |
| `<Space>hR` | Reset toàn bộ buffer |
| `<Space>hu` | Undo stage hunk |
| `<Space>hb` | Xem blame line (ai sửa dòng này) |
| `<Space>hB` | Toggle blame hiển thị |
| `<Space>hd` | Xem diff |
| `<Space>hD` | Xem diff với HEAD~ |
| `ih` | Select hunk (text object) |

---

### 7️⃣ **LSP (Language Server)** 💻

| Phím | Chức năng |
|------|-----------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Show references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `<Space>ca` | Code actions |
| `<Space>rn` | Rename symbol |
| `<Space>f` | Format code |
| `<Space>l` | Trigger linting |
| `[d` | Diagnostic trước |
| `]d` | Diagnostic sau |
| `<Space>q` | Quickfix cho diagnostic |

---

### 8️⃣ **Autocompletion** ✍️

**Trong Insert mode khi popup xuất hiện:**

| Phím | Chức năng |
|------|-----------|
| `Ctrl+j` | Suggestion tiếp theo |
| `Ctrl+k` | Suggestion trước |
| `Ctrl+b` | Scroll docs lên |
| `Ctrl+f` | Scroll docs xuống |
| `Ctrl+Space` | Trigger completion |
| `Ctrl+e` | Đóng completion |
| `Enter` | Confirm selection |

---

### 9️⃣ **GitHub Copilot AI** 🤖

#### Suggestions
**Trong Insert mode:**

| Phím | Chức năng |
|------|-----------|
| `Ctrl+y` | Chấp nhận suggestion |
| `Ctrl+n` | Suggestion tiếp theo |
| `Ctrl+p` | Suggestion trước |
| `Ctrl+e` | Đóng suggestion |
| `Alt+l` | Chấp nhận suggestion (alternative) |
| `Alt+]` | Next suggestion |
| `Alt+[` | Previous suggestion |

#### CopilotChat
| Phím | Chức năng |
|------|-----------|
| `<Space>cp` | Toggle chat panel |
| `<Space>ce` | Giải thích code |
| `<Space>cr` | Review code |
| `<Space>cf` | Fix code |
| `<Space>co` | Optimize code |
| `<Space>ct` | Generate tests |
| `<Space>cc` | Generate commit message |
| `<Space>cs` | Generate commit cho staged changes |
| `<Space>cd` | Fix diagnostic errors |
| `<Space>cv` | Chat với visual selection |
| `<Space>ci` | Quick inline chat |

---

### 🔟 **Tìm & Thay thế (Spectre)** 🔄

| Phím | Chức năng |
|------|-----------|
| `<Space>S` | Mở Spectre panel |
| `<Space>sw` | Tìm word dưới con trỏ |
| `<Space>sf` | Tìm trong file hiện tại |
| `<Space>sr` | Simple replace trong file |
| `<Space>sR` | Global replace (tất cả files) |

#### Trong Spectre Panel
| Phím | Chức năng |
|------|-----------|
| `dd` hoặc `Space` | Toggle dòng |
| `Enter` | Go to file |
| `R` | Replace all |
| `i` | Toggle ignore case |
| `u` | Toggle live update |

---

### 1️⃣1️⃣ **Navigation (Flash)** ⚡

| Phím | Chức năng |
|------|-----------|
| `s` | Jump đến vị trí (2 ký tự) |
| `S` | Jump đến dòng |

---

### 1️⃣2️⃣ **Comments** 💬

| Phím | Chức năng | Mode |
|------|-----------|------|
| `gcc` | Comment/uncomment dòng | Normal |
| `gc` | Comment/uncomment selection | Visual |
| `gbc` | Comment block | Normal |
| `gco` | Comment dòng phía dưới | Normal |
| `gcO` | Comment dòng phía trên | Normal |

**TODO Comments được highlight tự động:**
- `TODO:` - Việc cần làm
- `HACK:` - Workaround tạm thời
- `BUG:` - Bug cần fix
- `WARN:` - Warning
- `NOTE:` - Ghi chú quan trọng
- `FIX:` - Cần fix
- `PERF:` - Performance issue

---

### 1️⃣3️⃣ **Surround** 🔲

| Phím | Chức năng | Ví dụ |
|------|-----------|-------|
| `ys{motion}{char}` | Thêm surround | `ysiw"` - thêm "" quanh word |
| `ds{char}` | Xóa surround | `ds"` - xóa "" |
| `cs{old}{new}` | Thay surround | `cs"'` - đổi "" thành '' |
| `yss{char}` | Surround toàn dòng | `yss)` - thêm () quanh dòng |

**Ví dụ:**
```
Original: hello world
ysiw"    -> "hello" world
ysiw'    -> 'hello' world
ysiw(    -> ( hello ) world
ysiw)    -> (hello) world
ds"      -> hello world
cs"'     -> 'hello' world
yss)     -> (hello world)
```

---

### 1️⃣4️⃣ **Treesitter Text Objects** 🎯

#### Navigation
| Phím | Chức năng |
|------|-----------|
| `]m` | Đi đến function tiếp theo |
| `[m` | Đi đến function trước |
| `]]` | Đi đến class tiếp theo |
| `[[` | Đi đến class trước |
| `]M` | Đi đến end of function tiếp |
| `[M` | Đi đến end of function trước |

#### Selection (Visual mode)
| Phím | Chức năng |
|------|-----------|
| `af` | Select around function |
| `if` | Select inside function |
| `ac` | Select around class |
| `ic` | Select inside class |
| `aa` | Select around parameter |
| `ia` | Select inside parameter |

#### Swap
| Phím | Chức năng |
|------|-----------|
| `<Space>a` | Swap parameter với param sau |
| `<Space>A` | Swap parameter với param trước |

---

### 1️⃣5️⃣ **Session Management** 💾

**Auto-session tự động:**
- Lưu session khi thoát Neovim
- Restore session khi mở lại project

| Command | Chức năng |
|---------|-----------|
| `:SessionRestore` | Restore session cho thư mục hiện tại |
| `:SessionSave` | Lưu session manually |
| `:SessionDelete` | Xóa session |

---

### 1️⃣6️⃣ **Which-Key Helper** 🗝️

**Gõ `Space` và chờ 300ms** → Menu gợi ý các keymaps sẽ tự động hiện ra!

Hoặc gõ:
- `<Space>` - Xem tất cả leader keymaps
- `g` - Xem goto commands
- `z` - Xem fold commands
- `]` / `[` - Xem navigation commands

---

## ⚙️ Cấu hình

### Cấu trúc thư mục

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   └── josean/
│       ├── core/
│       │   ├── init.lua       # Core initialization
│       │   ├── options.lua    # Neovim options
│       │   ├── keymaps.lua    # Global keymaps
│       │   └── autocmds.lua   # Auto commands
│       ├── lazy.lua           # Lazy.nvim setup
│       └── plugins/           # Plugin configurations
│           ├── init.lua
│           ├── telescope.lua
│           ├── nvim-tree.lua
│           ├── treesitter.lua
│           ├── lsp/
│           │   ├── lspconfig.lua
│           │   ├── mason.lua
│           │   └── null-ls.lua
│           └── ...
├── after/
│   └── queries/
│       └── ecma/
│           └── textobjects.scm
├── lazy-lock.json            # Plugin versions lock file
└── README.md                 # This file
```

---

### Options chính (options.lua)

```lua
relativenumber = true         -- Relative line numbers
number = true                 -- Show line numbers
tabstop = 4                   -- 4 spaces per tab
shiftwidth = 4                -- 4 spaces indent
expandtab = true              -- Use spaces instead of tabs
clipboard = "unnamedplus"     -- System clipboard
mouse = "a"                   -- Enable mouse
termguicolors = true          -- True color support
swapfile = false              -- No swap files
```

---

### Customization

#### Thay đổi Leader key

Sửa trong `lua/josean/core/keymaps.lua`:
```lua
vim.g.mapleader = " "  -- Thay space bằng key khác
```

#### Thay đổi colorscheme

Sửa trong `lua/josean/plugins/colorscheme.lua`

#### Thêm LSP servers

```vim
:Mason
```
Tìm và install language servers bạn cần

#### Thay đổi formatting/linting

Sửa trong:
- `lua/josean/plugins/lsp/null-ls.lua` - Formatters & linters
- `lua/josean/plugins/linting.lua` - Additional linters

---

## 🚀 Performance

Config này được tối ưu với **lazy loading**:

- ⚡ Startup time: **~80-100ms**
- 🔌 Plugins chỉ load khi cần
- 💾 Memory usage thấp
- 🎯 Treesitter parsing nhanh

### Kiểm tra startup time:

```bash
nvim --startuptime startup.log +q && cat startup.log
```

### Xem plugins đã load:

```vim
:Lazy
```

---

## 🐛 Troubleshooting

### LSP không hoạt động

1. Kiểm tra LSP server đã cài chưa:
```vim
:Mason
```

2. Xem LSP logs:
```vim
:LspInfo
:LspLog
```

3. Restart LSP:
```vim
:LspRestart
```

### Treesitter lỗi parsing

```vim
:TSUpdate
:TSInstall <language>
```

### Plugins không load

```vim
:Lazy sync
:Lazy restore
```

### Clear cache

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
```

### Copilot không hoạt động

1. Đăng nhập:
```vim
:Copilot auth
```

2. Check status:
```vim
:Copilot status
```

### Formatter không chạy

1. Kiểm tra formatter đã cài:
```vim
:Mason
```

2. Format manually:
```vim
:lua vim.lsp.buf.format()
```

---

## 📊 Plugin Statistics

- **Total plugins:** ~40
- **Lazy loaded:** ~35
- **Load on startup:** ~5 (core plugins)
- **Average startup time:** 80-100ms

---

## 🤝 Contributing

Nếu bạn muốn đóng góp hoặc báo lỗi, vui lòng tạo issue hoặc pull request.

---

## 📝 License

MIT License - Tự do sử dụng và chỉnh sửa

---

## 🙏 Credits

- Config được lấy cảm hứng từ [Josean Dev](https://github.com/josean-dev/dev-environment-files)
- Cảm ơn cộng đồng Neovim đã tạo ra những plugins tuyệt vời!

---

## 📚 Tài liệu tham khảo

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Josean Dev YouTube](https://www.youtube.com/@joseanmartinez)
- [r/neovim](https://www.reddit.com/r/neovim/)

---

**Happy Coding! 🎉**
