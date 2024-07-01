local WebhookId = ""
local WebhookToken = ""

local Voyager = script.Voyager
local webhook = require(Voyager.Webhook).new(WebhookId, WebhookToken)
local Folder = game:GetService("ServerStorage"):FindFirstChild("ADONIS-WebhookLogging-STORAGE"
local PlaceName = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name

local HTTPS = game:GetService("HttpService")

local Folder = Instance.new("Folder", game:GetService("ServerStorage"))
  Folder.Name = "ADONIS-WebhookLogging-STORAGE"

local Data = Instance.new("Folder", Folder)
  Data.Name = "Data"

local Count = Instance.new("IntValue", Folder)
  Count.Name = "Count"



Folder.Count.Changed:Connect(function()
    if Folder.Count.Value >= 10 then
        wait(1)
        local Embeds = {}
        for i,v in pairs(Folder.Data:GetChildren()) do
            local embed = require(Voyager.Embed).new()
            
            embed:setColor(Settings.Color)
            embed:addField("User", "["..game:GetService("Players"):GetNameFromUserIdAsync(v.User.Value).."](https://www.roblox.com/users/"..v.User.Value.."/profile)", true)
            embed:addField("Level",tostring(v.Level.Value), true)
            embed:addField("Command", tostring(v.Command.Value), true)
            embed:addField("Timestamp", "<t:"..tostring(v.Time.Value)..">", true)
            embed:addField("Game","["..tostring(PlaceName).."](https://www.roblox.com/games/"..(tostring(game.PlaceId))..")", true)
            
            table.insert(Embeds, embed)
            v:Destroy()
        end
        Folder.Count.Value = 0
                
        local _, requestStatus = webhook:execute(nil, Embeds, true, false)

        if not requestStatus.success then
            warn("Request was not successful! " .. requestStatus.statusCode .. " " .. requestStatus.statusMessage)
        end

    end
end)

game:BindToClose(function()
        
    if Folder.Count.Value > 0 then
        local Embeds = {}
        for i,v in pairs(Folder.Data:GetChildren()) do
            local embed = require(Voyager.Embed).new()

            embed:setColor(Color3.fromRGB(10, 112, 51))
            embed:addField("User", "["..game:GetService("Players"):GetNameFromUserIdAsync(v.User.Value).."](https://www.roblox.com/users/"..v.User.Value.."/profile)", true)
            embed:addField("Level",tostring(v.Level.Value), true)
            embed:addField("Command", tostring(v.Command.Value), true)
            embed:addField("Timestamp", "<t:"..tostring(v.Time.Value)..">", true)
            embed:addField("Game","["..tostring(PlaceName).."](https://www.roblox.com/games/"..(tostring(game.PlaceId))..")", true)

            table.insert(Embeds, embed)

            v:Destroy()
        end
        Folder.Count.Value = 0

        local _, requestStatus = webhook:execute(nil, Embeds, true, false)

        if not requestStatus.success then
            warn("Request was not successful! " .. requestStatus.statusCode .. " " .. requestStatus.statusMessage)
        end

    end
    
    wait(2)
end)
