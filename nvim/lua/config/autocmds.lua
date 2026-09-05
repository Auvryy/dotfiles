-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Hot-reload Matugen colors when switching back to Neovim after wallpaper/theme change
local matugen_path = vim.fn.stdpath("config") .. "/lua/config/matugen_colors.lua"
local last_mtime = 0

local stat = vim.uv.fs_stat(matugen_path)
if stat and stat.mtime then
  last_mtime = stat.mtime.sec
end

vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("auvry_matugen_reload", { clear = true }),
  callback = function()
    local current_stat = vim.uv.fs_stat(matugen_path)
    if current_stat and current_stat.mtime and current_stat.mtime.sec > last_mtime then
      last_mtime = current_stat.mtime.sec
      package.loaded["config.matugen_colors"] = nil
      local ok, _ = pcall(require, "config.matugen_colors")
      if ok then
        local current = vim.g.colors_name or "catppuccin"
        vim.cmd.colorscheme(current)
      end
    end
  end,
})

