-- Start qemu without exiting vim or switching to another term tab (yes I know its just one shortcut with tmux :D).
local user_cmd = vim.api.nvim_create_user_command
local M = { }

function M.qemu_run(opts)
	-- we have the follwoing options to specify:
	-- - kernel or rom
	-- - path to kernel oder rom
	-- - smp and nr cpus (default single core)
	-- - enable kvm (default no)
	-- - mainboard (default q35)
	-- - qemu arch (default x86_64)
	-- - display (default vsplit)
	-- - serial (default stdio)
	-- graphical qemu is disabled and I won't add any option to enable it,
	-- it makes zero sense to spawn a qemu window from within nvim. If needed
	-- feel free to just remove -nographic -nodefaults flags.
	local mode = opts.mode or "-bios"
	local image = opts.image or "build/coreboot.rom"
	local smp = opts.smp or 1
	local kvm = opts.kvm or ""
	local mainboard = opts.mainboard or "q35"
	local arch = opts.arch or "x86_64"
	local display = opts.display or "vsplit"
	local serial = opts.serial or "stdio"
	-- Okay this is extremely ugly. But hey it works :D
	vim.cmd(display .. " term://qemu-system-" .. arch .. " " .. mode .. " "
			.. image .. " -M " .. mainboard .. " -serial " .. serial .. " -nographic -nodefaults -smp "
			.. smp .. " " .. kvm)
end

function M.setup(opts)
	user_cmd("QemuRun", function()
		M.qemu_run(opts)
	end, { desc = "Run qemu in the interactive shell term" })
end

return M
