-- Miscellaneous plugins
-- Focused on fun and learning

return {
  -- leetcode.nvim
  -- https://github.com/kawre/leetcode.nvim
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "rcarriga/nvim-notify",
    },
    init = function(_, opts)
      -- Require only when needed
      if vim.tbl_contains(vim.fn.argv(), 'leetcode.nvim') then
        require("leetcode").setup(opts)
      end
    end,
    cmd = "Leet",
    opts = {
      lang = "typescript",
    },
  },

  -- hardtime.nvim
  -- https://github.com/m4xshen/hardtime.nvim
  {
    "m4xshen/hardtime.nvim",
    event = "User BaseFile",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = {
        "qf",
        "netrw",
        "aerial",
        "dashboard",
        "help",
        "lazy",
        "leetcode.nvim",
        "mason",
        "neo-tree",
        "NvimTree",
        "neogitstatus",
        "notify",
        "startify",
        "toggleterm",
        "Trouble",
        "oil",
        "calltree",
        "coverage"
      },
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
    end,
  },

  -- precognition.nvim
  -- https://github.com/tris203/precognition.nvim
  {
    "https://github.com/tris203/precognition.nvim",
    event = "User BaseFile",
    opts = {
      startVisible = false,
    },
    config = function(_, opts)
      require("precognition").setup(opts)
    end,
  }
}
