local M={}

function M.make()
	local num=vim.fn.winnr()
	print(type(num))
end
return M
