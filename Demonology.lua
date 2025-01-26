local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Boundless",
        Content = "Script is loading be patient.",
        SubContent = "", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })



    Tabs.Main:AddParagraph({
        Title = "Boundless",
        Content = "Made this in like 5 mins. Enjoy."
    })



    local ghost = game.Workspace.Ghost
    local attributes = {
        Age = ghost:GetAttribute("Age") or "Unknown",
        CurrentRoom = ghost:GetAttribute("CurrentRoom") or "Unknown",
        FavoriteRoom = ghost:GetAttribute("FavoriteRoom") or "Unknown",
        Gender = ghost:GetAttribute("Gender") or "Unknown",
        GhostType = ghost:GetAttribute("GhostType") or "Unknown"
    }
    






    Tabs.Main:AddButton({
        Title = "Show Information",
        Description = "Gives you information about the Ghost",
        Callback = function()
            Fluent:Notify({
                Title = "Boundless",
                Content = string.format("Age: %s Current Room: %s Favorite Room: %s Gender: %s Ghost Type: %s", 
                    attributes.Age, 
                    attributes.CurrentRoom, 
                    attributes.FavoriteRoom, 
                    attributes.Gender, 
                    attributes.GhostType
                ),
                Duration = 6
            })
            
            print(ghost:GetAttribute("GhostType"))
        end
    })
    

    Tabs.Main:AddButton({
        Title = "Infinite Yield",
        Description = "executes infinite yield",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })



-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Boundless",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
end