require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  -- size = 20 |function(term)
  size = function(term)
    if term.direction == "horizontal" then
      return 13
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
		end
}
