-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  ["@comment"] = { italic = true },
  Comment = { italic = true },
  TelescopeSelection = { bg = "#353A46", fg = "#abb2bf" },
  IblScopeChar = { fg = "#9196a1" },
}

M.add = {
  VisualWhitespace = { fg = "#4a505b", bg = "#231631" },

  -- Markview
  MarkviewHeading1 = { bg = "#453244", fg = "#f38ba8" },
  MarkviewHeading1Sign = { fg = "#f38ba8" },
  MarkviewHeading2 = { bg = "#46393E", fg = "#fab387" },
  MarkviewHeading2Sign = { fg = "#fab387" },
  MarkviewHeading3 = { bg = "#464245", fg = "#f9e2af" },
  MarkviewHeading3Sign = { fg = "#f9e2af" },
  MarkviewHeading4 = { bg = "#374243", fg = "#a6e3a1" },
  MarkviewHeading4Sign = { fg = "#a6e3a1" },
  MarkviewHeading5 = { bg = "#2E3D51", fg = "#74c7ec" },
  MarkviewHeading5Sign = { fg = "#74c7ec" },
  MarkviewHeading6 = { bg = "#393B54", fg = "#b4befe" },
  MarkviewHeading6Sign = { fg = "#b4befe" },
}

return M