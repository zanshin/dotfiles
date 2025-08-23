return {
  "zanshin/floatingtodo.nvim",
  config = function()
    require('floatingtodo').setup({ target_file = '~/Documents/notes/todo.md' })
  end
}
