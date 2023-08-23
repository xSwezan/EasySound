local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EasySound = require(ReplicatedStorage.lib)

local SFX = EasySound:GetGroup("SFX")

task.delay(5,function()
	SFX:GetSound("Reload"):Play{
		Pitch = -1;
	}
end)