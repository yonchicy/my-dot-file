local function clock()
	return "🎈"..os.date("%H:%M")	
end
local function lsp_pregress()
	local messages=vim.lsp.util.get_progress_messages()

	if #messages==0 then
		return
	end
	local status={}
	for _,msg in pairs(messages) do
		table.insert(status,(msg.percentage or 0).."%%"..(msg.title or ""))
	end

end
