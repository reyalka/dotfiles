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
                { name = "Neovim",    path = "~/dotfiles/config/nvim" },
                { name = "Fish",      path = "~/dotfiles/config/fish/" },
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

        local items = {
            pinned_dirs(),
            starter.sections.recent_files(10),
            starter.sections.builtin_actions(),
        }

        local function header()
            return string.format("Neovim %s",
                vim.fn.execute("version", "silent!"):match("NVIM (v[%d%.]+)")
            )
        end

        starter.setup({
            evaluate_single = true,
            items = items,
            header = header,
            content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.indexing("all", { "Recent files", "Builtin actions" }),
                starter.gen_hook.padding(3, 2),
                starter.gen_hook.aligning("center", "center"),
            },
        })
    end,
}
