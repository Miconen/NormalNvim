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
}
