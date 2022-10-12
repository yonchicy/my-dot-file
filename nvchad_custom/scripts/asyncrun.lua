local function amake()
	local results = {}

	local mp = vim.api.nvim_get_option("makeprg")
	if not mp then
		print("no mp founded")
		return
	end

	local cmd = vim.fn.expandcmd(mp)

	local function on_event(job_id, data, event)
		if event == "stdout" or event == "stderr" then
			if data then
        vim.list_extend(results,data)
			end
		end

		if event == "exit" then

			vim.fn.setqflist({}, "r", { titles = cmd, lines = results })
      vim.api.nvim_command("copen")
		end
	end

	local job_id = vim.fn.jobstart(cmd, {
		on_stderr = on_event,
		on_stdout = on_event,
		on_exit = on_event,
		stdout_buffered = true,
		stderr_buffered = true,
	})
end

vim.api.nvim_create_user_command("Make", amake, {})
