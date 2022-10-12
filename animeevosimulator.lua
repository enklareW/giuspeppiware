local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local v1 = require(game.Players.LocalPlayer.PlayerGui.UI.Client:FindFirstChild("Services"));
local vu = game:GetService("VirtualUser")
local plr = game.Players.LocalPlayer
local plrgui = plr.PlayerGui
local UI = plrgui.UI
local centerframe = UI.CenterFrame
local teleportframe = centerframe:FindFirstChild("Teleport")
local giftsframe = centerframe:FindFirstChild("Gifts")


local Window = Library.CreateLib("Giuseppiware", "Ocean")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Autofarm")
local Section2 = Tab:NewSection("Player")

Section:NewToggle("Auto Click", "", function(state)
while task.wait() and state == true do
    if v1.CurrentMob then
		v1.ReplicatedStorage.Remotes.Client:FireServer({ "AttackMob", v1.CurrentMob });
	end;
	v1.ReplicatedStorage.Remotes.Client:FireServer({ "PowerTrain", v1.CurrentAreaBuy });
end
end)

Section:NewToggle("Auto Collect Coins", "", function(state)
local u1 = nil;

while task.wait() and state == true do
local v7 = v1.MyCharacter();
	if not v7 then
		return;
	end;
	local v8 = workspace.__OUT:FindFirstChild(v1.Players.LocalPlayer.Name);
	for v9, v10 in pairs(workspace.__DROPS:GetChildren()) do
   if (v7.PrimaryPart.Position - v10.Position).Magnitude <= math.huge then
			v10.CanCollide = false;
			v10.Anchored = true;
			v10.CFrame = v10.CFrame:Lerp(v7.PrimaryPart.CFrame, 0.1);
			if not v10:GetAttribute("Picked") then
				v10:SetAttribute("Picked", true);
				task.wait(math.random() / 7);
				u1 = v10.Name;
				v1.ReplicatedStorage.Remotes.Client:FireServer({ "DropCollect", v10.Name });
				v10:Destroy();
			end;
		end;
	end;
	if u1 then
		v1.ReplicatedStorage.Remotes.Client:FireServer({ "DropCollect", u1 });
	end;
end
end)

Section:NewToggle("Auto Collect Gifts", "", function(state)
    while task.wait() and state == true do
for v7, v8 in pairs(giftsframe.Frame:GetChildren()) do
	if v8:IsA("ImageLabel") and v8.Frame.TextLabel.Text == "Claim" then
			v1.ReplicatedStorage.Remotes.Client:FireServer({ "Gift", v8.Name });
	end;
     end
  end
end)

Section2:NewKeybind("Pop up teleport menu", "", Enum.KeyCode.J, function()
teleportframe.Visible = true
teleportframe.Position = UDim2.new(-5,0,-2,0)
end)

if not v1.PlayerGroup then
    v1.PlayerGroup = true
end

game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
