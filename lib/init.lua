local SoundService = game:GetService("SoundService")
local Types = require(script.Types)
local GroupClass = require(script.GroupClass)

export type EasySound = Types.EasySound
export type Group = Types.GroupClass
export type Sound = Types.SoundClass
export type PlaybackConfig = Types.PlaybackConfig

local EasySound = {
	SoundDirectory = SoundService;

	__groups = {};
}

function EasySound.GetGroup(Name: string): Types.GroupClass
	local OldGroup: Types.GroupClass? = EasySound.__groups[Name]
	if (OldGroup) then
		return OldGroup
	end

	local Found: SoundGroup?
	for _, SoundGroup: SoundGroup? in EasySound.SoundDirectory:GetDescendants() do
		if (SoundGroup.Name ~= Name) then continue end
		if not (SoundGroup:IsA("SoundGroup")) then continue end

		Found = SoundGroup
		
		break
	end

	if not (Found) then return end

	local NewGroup: Types.GroupClass = GroupClass.new(Found)
	EasySound.__groups[Name] = NewGroup

	return NewGroup
end

return EasySound :: EasySound