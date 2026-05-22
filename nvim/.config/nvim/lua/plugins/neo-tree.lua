return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      commands = {
        delete = function(state)
          local node = state.tree:get_node()
          local path = node.path
          vim.fn.system({ "trash", vim.fn.fnameescape(path) })
        end,
      },
      follow_current_file = true,
    },
  },
}
