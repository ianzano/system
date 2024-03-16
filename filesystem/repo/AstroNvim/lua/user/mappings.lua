-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },

    ["<C-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<C-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    ["<C-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    ["<C-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },

    ["<C-k>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    ["<C-j>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    ["<C-h>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    ["<C-l>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },

    ["<S-Tab>"] = { ":bprev<cr>" },
    ["<Tab>"] = { ":bnext<cr>" },

    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
