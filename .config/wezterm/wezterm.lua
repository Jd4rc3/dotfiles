local wezterm = require("wezterm")

local config = {
    font = wezterm.font("JetBrainsMono Nerd Font"),
    color_scheme = "Catppuccin Mocha",
    audible_bell = "Disabled",
    default_prog = { "/bin/zsh", "-l" },
    font_size = 16.0,
    launch_menu = {},
    enable_scroll_bar = true,
    adjust_window_size_when_changing_font_size = false,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    animation_fps = 60,
}

-- Padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.window_decorations = "NONE"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    -- config.term = "" -- Set to empty to FZF works on windows
    config.default_prog = { "C:\\Users\\arce\\scoop\\apps\\pwsh\\current\\pwsh.exe", "-NoLogo" }

    table.insert(
        config.launch_menu,
        { label = "PowerShell", args = { "C:\\Users\\arce\\scoop\\apps\\pwsh\\current\\pwsh.exe", "-NoLogo" } }
    )

    table.insert(config.launch_menu, { label = "cmd", args = { "cmd.exe" } })

    table.insert(config.launch_menu, { label = "Arch", args = { "C:\\Windows\\system32\\wsl.exe", "-d", "Arch" } })

    table.insert(
        config.launch_menu,
        { label = "Ubuntu", args = { "C:\\Windows\\system32\\wsl.exe", "-d", "Ubuntu-24.04" } }
    )

    -- Find installed visual studio version(s) and add their compilation
    -- environment command prompts to the menu

    for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
        local year = vsvers:gsub("Microsoft Visual Studio/", "")
        table.insert(config.launch_menu, {
            label = "x64 Native Tools VS " .. year,

            args = {
                "cmd.exe",
                "/k",
                "C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
            },
        })
    end
else
    table.insert(config.launch_menu, { label = "bash", args = { "bash", "-l" } })
    table.insert(config.launch_menu, { label = "fish", args = { "fish", "-l" } })
end

return config
