local function get_matugen()
  local ok, matugen = pcall(require, "config.matugen_colors")
  if ok and type(matugen) == "table" and matugen.primary then
    return matugen
  end
  return nil
end

return {
  -- Configure LazyVim to default to Catppuccin Mocha
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Catppuccin configuration with smart transparency and Matugen alignment
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = function()
      return {
        flavour = "mocha",
        transparent_background = true, -- Clean buffer transparency (inherits terminal background & blur)
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          blink_cmp = true,
          gitsigns = true,
          mason = true,
          mini = {
            enabled = true,
          },
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          noice = true,
          notify = true,
          snacks = true,
          treesitter = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          local m = get_matugen()
          local primary = m and m.primary or colors.blue
          local primary_container = m and m.primary_container or colors.surface1
          local float_bg = m and m.surface_container or colors.mantle
          local float_bg_high = m and m.surface_container_high or colors.crust
          local border = m and m.primary or colors.blue

          return {
            -- 1. Main Buffers: Pure transparency so terminal background and wallpaper blur show through
            Normal = { bg = "NONE" },
            NormalNC = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            LineNr = { bg = "NONE", fg = colors.surface1 },
            CursorLineNr = { bg = "NONE", fg = primary, bold = true },
            FoldColumn = { bg = "NONE" },
            EndOfBuffer = { bg = "NONE" },

            -- 2. Floating Windows: Solid/tinted backdrop to guarantee 100% legibility (no text bleeding)
            NormalFloat = { bg = float_bg, fg = colors.text },
            FloatBorder = { bg = float_bg, fg = border },
            FloatTitle = { bg = float_bg, fg = primary, bold = true },

            -- 3. Autocompletion Menus (blink.cmp / nvim-cmp)
            Pmenu = { bg = float_bg, fg = colors.text },
            PmenuSel = { bg = primary_container, fg = primary, bold = true },
            PmenuSbar = { bg = float_bg_high },
            PmenuThumb = { bg = primary },
            BlinkCmpMenu = { bg = float_bg, fg = colors.text },
            BlinkCmpMenuBorder = { bg = float_bg, fg = border },
            BlinkCmpDoc = { bg = float_bg, fg = colors.text },
            BlinkCmpDocBorder = { bg = float_bg, fg = border },

            -- 4. Window Splits: Distinct border
            WinSeparator = { fg = primary, bg = "NONE" },

            -- 5. Search and Selection
            Search = { bg = primary_container, fg = colors.text, bold = true },
            IncSearch = { bg = primary, fg = m and m.surface or colors.base, bold = true },
            CurSearch = { bg = primary, fg = m and m.surface or colors.base, bold = true },
            Visual = { bg = primary_container },

            -- 6. Diagnostics & Popups
            DiagnosticFloatingError = { bg = float_bg, fg = colors.red },
            DiagnosticFloatingWarn = { bg = float_bg, fg = colors.yellow },
            DiagnosticFloatingInfo = { bg = float_bg, fg = colors.sky },
            DiagnosticFloatingHint = { bg = float_bg, fg = colors.teal },

            -- 7. Snacks Popups & Pickers
            SnacksBackdrop = { bg = "NONE" },
            SnacksNormal = { bg = float_bg, fg = colors.text },
          }
        end,
      }
    end,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

