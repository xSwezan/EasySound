local SoundService = game:GetService("SoundService")
local Types = require(script.Parent.Types)
local Janitor = require(script.Parent.Parent.Janitor)

local SoundClass: Types.SoundClass = {}
SoundClass.__index = SoundClass

function SoundClass.new(SoundInstance: Instance): Types.SoundClass
	local self = setmetatable({
		Instance = SoundInstance;

		__janitor = Janitor.new();
	}, SoundClass)

	self.__janitor:LinkToInstance(SoundInstance)

	return self
end

function SoundClass:Play(PlaybackConfig: Types.PlaybackConfig): Sound
	local Config: Types.PlaybackConfig = PlaybackConfig or {}

	local NewSound: Sound = self.Instance:Clone()
	NewSound.Volume = Config.Volume or NewSound.Volume
	NewSound.Name = `Playing_{NewSound.Name}`
	NewSound.Parent = Config.Parent or SoundService

	if (type(Config.Pitch) == "number") then
		local PitchEffect: PitchShiftSoundEffect = Instance.new("PitchShiftSoundEffect")
		PitchEffect.Octave = Config.Pitch
		PitchEffect.Parent = NewSound
	end

	NewSound:Play()

	if (Config.AutoDestroy ~= false) then -- AutoDestroy
		self.__janitor:Add(NewSound.Ended:Connect(function()
			pcall(NewSound.Destroy, NewSound)
		end),"Disconnect")
	end

	self.__janitor:Add(NewSound,"Destroy")

	return self.Instance
end

function SoundClass:Destroy()
	self.__janitor:Destroy()
end

return SoundClass