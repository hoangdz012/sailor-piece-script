local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Sailor Piece Hub",
   LoadingTitle = "Sailor Piece",
   LoadingSubtitle = "Auto Farm",
})

local Tab = Window:CreateTab("Main", 4483362458)

local AutoFarm = false
local player = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

-- tìm enemy gần nhất
function getNearestEnemy()
    local nearest = nil
    local dist = math.huge

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if v ~= player.Character and v.Humanoid.Health > 0 then
                local d = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end
    end

    return nearest
end

-- toggle auto farm
Tab:CreateToggle({
   Name = "Auto Farm (Teleport + Skill)",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarm = Value
   end,
})

-- loop
task.spawn(function()
    while true do
        task.wait(0.3)

        if AutoFarm then
            local enemy = getNearestEnemy()

            if enemy then
                -- teleport tới quái
                player.Character.HumanoidRootPart.CFrame =
                    enemy.HumanoidRootPart.CFrame * CFrame.new(0,0,2)

                task.wait(0.2)

                -- dùng skill
                for _,k in pairs({"Z","X","C","V","J"}) do
                    VIM:SendKeyEvent(true,k,false,game)
                    task.wait(0.15)
                    VIM:SendKeyEvent(false,k,false,game)
                end
            end
        end
    end
end)