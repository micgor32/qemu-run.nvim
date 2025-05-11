# qemu-run.nvim

Neovim plugin for running QEMU in [embedded terminal emulator](https://neovim.io/doc/user/terminal.html#terminal-emulator).
Written just because I am sick of having to switch tabs every time I have to test kernel/coreboot image. So instead, here 
is the plugin that does exactly the same thing just by running `:QemuRun` or whatever keybinding you choose to map it to.

## Installation and configuration

It can probably work with most of the Neovim plugin managers, but I have only tested it with [lazy.nvim](https://github.com/folke/lazy.nvim).
Therefore, assuming that lazy.nvim is our plugin manager of choice:

```lua
-- your init.lua or lazy.lua
require("lazy").setup({
    -- rest of your plugins
    {
		"micgor32/qemu-run.nvim",
		opts = {
            display = ""
            arch = "x86_64" -- QEMU target architecture, if left empty -> x86_64
            mode = "-bios" -- specify whether you want to run bios image (coreboot/EDK2/u-boot) or kernel, if left empty -> -bios
			image = "build/coreboot" -- (full) path to the kernel/bios image. By default it assumes that qemu is started in coreboot source tree with rom already built
            mainboard = "q35" -- specify mainboard, if left empty -> Q35
            kvm = "" -- enables KVM hardware acceleration (Linux only). Disabled by default, change to "-enable-kvm" if you want to use it.
            serial = "stdio" -- specify where the serial output is redirected. By deafult to stdio.
            smp = 1 -- specify number of CPUs that are going to be emulated. By default single core.
		}
	},
```

## Mappings

Typing `:QemuRun` is a lot of work, so it is smart to configuration a keybinding for it. An example:

```lua
vim.keymap.set("n", "<leader>qr", ":QemuRun<CR>")
```
