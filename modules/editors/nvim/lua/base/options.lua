local function copy(lines, _)
	require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.g.clipboard = {
	name = "osc52",
	copy = { ["+"] = copy, ["*"] = copy },
	paste = { ["+"] = paste, ["*"] = paste },
}

local options = {
	clipboard = "unnamedplus",
	mouse = "a",
	undofile = true,
	ignorecase = true,
	smartcase = true,
	showmode = false,
	showtabline = 2,
	smartindent = true,
	autoindent = true,
	swapfile = false,
	hidden = true, --default on
	expandtab = true,
	cmdheight = 1,
	shiftwidth = 2, --insert 2 spaces for each indentation
	tabstop = 2, --insert 2 spaces for a tab
	cursorline = true, --Highlight the line where the cursor is located
	cursorcolumn = false,
	number = true,
	numberwidth = 4,
	relativenumber = true,
	--[[ wrap = false, ]]
	scrolloff = 8,
	fileencodings = "utf-8,gbk",
	updatetime = 50, -- faster completion (4000ms default)
	foldenable = false,
	foldlevel = 99,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- autorun
vim.api.nvim_set_keymap("n", ",r", ":lua CompileRunGcc()<CR>", { noremap = true })

function CompileRunGcc()
	vim.cmd("w")
	local filetype = vim.bo.filetype
	if filetype == "c" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term gcc % -o %< && time ./%<")
	elseif filetype == "cpp" then
		vim.o.splitbelow = true
		vim.cmd("!g++ -std=c++11 % -Wall -o %<")
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term ./%<")
	elseif filetype == "cs" then
		vim.o.splitbelow = true
		vim.cmd("!mcs %")
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term mono %<.exe")
	elseif filetype == "java" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term javac % && time java %<")
	elseif filetype == "sh" then
		vim.cmd("!time bash %")
	elseif filetype == "python" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("term python3 %")
	elseif filetype == "html" then
		vim.cmd("!" .. vim.g.mkdp_browser .. " % &")
	elseif filetype == "markdown" then
		vim.cmd("InstantMarkdownPreview")
	elseif filetype == "tex" then
		vim.cmd("VimtexStop")
		vim.cmd("VimtexCompile")
	elseif filetype == "dart" then
		vim.cmd("CocCommand flutter.run -d " .. vim.g.flutter_default_device .. " " .. vim.g.flutter_run_args)
		vim.cmd("CocCommand flutter.dev.openDevLog")
	elseif filetype == "javascript" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd('term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .')
	elseif filetype == "racket" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("res -5")
		vim.cmd("term racket %")
	elseif filetype == "go" then
		vim.o.splitbelow = true
		vim.cmd("sp")
		vim.cmd("term go run .")
	end
end
