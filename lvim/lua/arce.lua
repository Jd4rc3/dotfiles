lvim.plugins = {
  -- {
  --   "folke/trouble.nvim",
  --   cmd = "TroubleToggle",
  -- },
  { "softoika/ngswitcher.vim" },
  { "mattn/emmet-vim" },
  { 'andweeb/presence.nvim' },
  { "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
  {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  }
}

local js = require "config.dap.javascript"
js.setup()


lvim.builtin.which_key.mappings["a"] = {
  name = "+NgSwitcher",
  a = { "<cmd>NgSwitchTS<cr>", "TS" },
  d = { "<cmd>NgSwitchCSS<cr>", "StyleSheet" },
  s = { "<cmd>NgSwitchHTML<cr>", "HTML" },
}

vim.cmd("let g:user_emmet_leader_key='<C-Q>'")

-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   {
--     command = "rome",
--     filetypes = { "typescript", "javascript", "html", "typescriptreact" },
--   },
-- }

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "eslint", filetypes = { 'javascript', 'typescript' } }
-- }

-- local p = require("presence")

-- p:setup({
--   auto_update        = true,
--   neovim_image_text  = "One editor to rule them all",
--   main_image         = "neovim",
--   editing_text       = "✏️  %s",
--   file_explorer_text = "📂 %s",
--   client_id          = ""
-- })
