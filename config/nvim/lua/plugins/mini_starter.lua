---@class LazySpec
return {
    "echasnovski/mini.starter",
    version = "*",
    lazy = false,
    config = function()
        local starter = require("mini.starter")

        local function pinned_dirs()
            local section = "Pinned Directories"
            local paths = {
                { name = "Home",      path = "~/" },
                { name = "Dev",       path = "~/dev" },
                { name = "Temporary", path = "~/tmp" },
                { name = "Dotfiles",  path = "~/dotfiles" },
            }

            local items = {}
            for index, item in ipairs(paths) do
                table.insert(items, index, {
                    name = string.format("%s (%s)", item.name, item.path),
                    action = function()
                        local path = vim.fn.expand(item.path)
                        vim.cmd(string.format("cd %s", path))
                        require("oil").open_float(path)
                    end,
                    section = section,
                })
            end
            return items
        end

        local my_items = {
            starter.sections.builtin_actions(),
            pinned_dirs(),
            starter.sections.recent_files(10),
        }

        local function header() return string.format("Neovim %s", vim.v.version) end

        starter.setup({
            evaluate_single = true,
            items = my_items,
            header = header,
            content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.padding(3, 2),
                starter.gen_hook.aligning("center", "center"),
            },
        })
    end,
}
