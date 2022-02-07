-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'

local M = {}
local opt = vim.opt
-- NOTE: To use this, make a copy with `cp example_chadrc.lua chadrc.lua`
--------------------------------------------------------------------

-- To use this file, copy the structure of `core/default_config.lua`,
-- examples of setting relative number & changing theme:

-- M.options = {
--    relativenumber = true,
-- }

opt.shell = 'pwsh -nol'
opt.shellcmdflag = '-nop -c'
opt.shellquote = '"'
opt.shellxquote = ''
opt.shellpipe = '| Out-File -Encoding UTF8 %s'
opt.shellredir = '| Out-File -Encoding UTF8 %s'

M.ui = {
  theme = "onedark"
}
-- NvChad included plugin options & overrides

local userPlugins = require "custom.plugins" -- path to table

M.plugins = {
   status = {
      blankline = true, -- indentline stuff
      bufferline = true, -- manage and preview opened buffers
      colorizer = true, -- color RGB, HEX, CSS, NAME color codes
      comment = true, -- easily (un)comment code, language aware
      dashboard = true,
      better_escape = true, -- map to <ESC> with no lag
      feline = true, -- statusline
      gitsigns = true,
      lspsignature = true, -- lsp enhancements
      vim_matchup = true, -- improved matchit
      cmp = true,
      nvimtree = true,
      autopairs = true,
   },
   
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   default_plugin_config_replace = {},

   install = userPlugins,
}

return M
