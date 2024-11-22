require("alpha").setup(require("alpha.themes.dashboard").config)
local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"
local neovim_version = vim.version()
local neovim_version_str = string.format(
  "  v%s.%s.%s%s",
  neovim_version.major,
  neovim_version.minor,
  neovim_version.patch,
  neovim_version.prerelease and " nightly" or ""
)

dashboard.section.header.val = {
  [[ ________   _______    _____ ______    ________   ________    ___        ________   ___      ___  _______    ________       ]],
  [[|\   ___ \ |\  ___ \  |\   _ \  _   \ |\   __  \ |\   ___  \ |\  \      |\   __  \ |\  \    /  /||\  ___ \  |\   __  \      ]],
  [[\ \  \_|\ \\ \   __/| \ \  \\\__\ \  \\ \  \|\  \\ \  \\ \  \\ \  \     \ \  \|\  \\ \  \  /  / /\ \   __/| \ \  \|\  \     ]],
  [[ \ \  \ \\ \\ \  \_|/__\ \  \\|__| \  \\ \  \\\  \\ \  \\ \  \\ \  \     \ \  \\\  \\ \  \/  / /  \ \  \_|/__\ \   _  _\    ]],
  [[  \ \  \_\\ \\ \  \_|\ \\ \  \    \ \  \\ \  \\\  \\ \  \\ \  \\ \  \____ \ \  \\\  \\ \    / /    \ \  \_|\ \\ \  \\  \|   ]],
  [[   \ \_______\\ \_______\\ \__\    \ \__\\ \_______\\ \__\\ \__\\ \_______\\ \_______\\ \__/ /      \ \_______\\ \__\\ _\   ]],
  [[    \|_______| \|_______| \|__|     \|__| \|_______| \|__| \|__| \|_______| \|_______| \|__|/        \|_______| \|__|\|__|  ]] .. neovim_version_str,
}

local plugins_config_path = vim.fn.stdpath "config" .. "/lua/kiyoon/lazy.lua"
dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file (\\ff)", ":Telescope find_files hidden=true no_ignore=true<CR>"),
  dashboard.button("F", "  Find git file (\\fF)", ":Telescope git_files<CR>"),
  dashboard.button("r", "  Recently opened files (\\fr)", "<cmd>Telescope oldfiles<CR>"),
  -- dashboard.button("p", " " .. " Recent projects", ":lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("W", "  Find word (\\fW)", "<cmd>Telescope live_grep<cr>"),
  dashboard.button("g", "  Find word with args (\\fg)", "<cmd>Telescope live_grep_args<cr>"),
  dashboard.button(
    "w",
    "  Find word in git dir (\\fw)",
    "<cmd>lua require'telescope'<cr><cmd>lua require'kiyoon.telescope'.live_grep_gitdir()<cr>"
  ),
  dashboard.button("d", " " .. " Diff view (\\dv)", "<cmd>DiffviewOpen<CR>"),
  dashboard.button("l", " " .. " Install language support (:Mason)", ":Mason<CR>"),
  dashboard.button("p", " " .. " Plugins", "<cmd>Lazy<CR>"),
  dashboard.button("P", " " .. " Plugins config", ":e " .. plugins_config_path .. "<CR>"),
  dashboard.button("c", " " .. " Neovim config", ":e $MYVIMRC <CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}
-- local handle = io.popen('fortune')
-- local fortune = handle:read("*a")
-- handle:close()
-- dashboard.section.footer.val = fortune

-- local function footer()
--   return {
--     "https://github.com/kiyoon/dotfiles",
--   }
-- end
--
-- dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.config.opts.noautocmd = true

vim.cmd [[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = {
      "👍               good code bro",
      "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms",
    }
    pcall(vim.cmd.AlphaRedraw)
  end,
})
