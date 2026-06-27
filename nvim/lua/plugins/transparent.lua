return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      return opts
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local clear_groups = {
        "Normal",
        "NormalNC",
        "SignColumn",
        "EndOfBuffer",
        "MsgArea",
        "FloatBorder",
        "NormalFloat",
        "Pmenu",
        "PmenuSel",
        "PmenuSbar",
        "PmenuThumb",
      }

      local group = vim.api.nvim_create_augroup("LazyVimTransparentBackground", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = function()
          for _, name in ipairs(clear_groups) do
            vim.api.nvim_set_hl(0, name, { bg = "none" })
          end
        end,
      })

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("ColorScheme", { group = group })
      end)

      return opts
    end,
  },
}