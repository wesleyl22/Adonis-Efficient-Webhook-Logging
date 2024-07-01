local set = require(script.Parent.Parent.Settings)
local Loc = game:GetService("ServerStorage"):WaitForChild("ADONIS-WebhookLogging-STORAGE")

server = nil 
service = nil

local PlaceName = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name
local HTTPS = game:GetService("HttpService")


return function()
    service.Events.CommandRan:Connect(function(player, Data)

        local lvl = nil
        local command = nil
        local success = nil

        for i,v in pairs(Data) do
            if i == "Success" then
                success = v
            end
            if i == "Message" then
                command = v
            end
            if type(v) == "table" then
                for e,n in pairs(v) do
                    if e == "Level" then
                        lvl = "Player"
                        
                        for a,b in pairs(set.Settings.Ranks) do
                            if n >= b.Level then
                                lvl = a
                            end
                        end
                    end
                end
            end
        end
        
        if success then
            if Loc.Count.Value >= 10 then
                wait(1)
            end

            Loc.Count.Value += 1
            
            local Folder = Instance.new("Folder", Loc.Data)
            Folder.Name = Loc.Count.Value

            local User = Instance.new("StringValue", Folder)
            User.Name = "User"
            User.Value = player.UserId

            local Command = Instance.new("StringValue", Folder)
            Command.Name = "Command"
            Command.Value = command

            local Level = Instance.new("StringValue", Folder)
            Level.Name = "Level"
            Level.Value = lvl

            local Time = Instance.new("StringValue", Folder)
            Time.Name = "Time"
            Time.Value = service.GetTime()
        end
        
    end)
end
