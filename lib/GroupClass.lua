local SoundClass = require(script.Parent.SoundClass)
local Types = require(script.Parent.Types)
local Janitor = require(script.Parent.Parent.Janitor)

local GroupClass = {}
GroupClass.__index = GroupClass

function GroupClass.new(SoundGroupInstance: SoundGroup)
	local self = setmetatable({
		Instance = SoundGroupInstance;

		__sounds = {};
		__janitor = Janitor.new();
	}, GroupClass)

	for _, Sound: Sound in SoundGroupInstance:GetChildren() do
		if not (Sound:IsA("Sound")) then continue end

		self:__addSound(Sound)
	end

	self.__janitor:Add(SoundGroupInstance.ChildAdded:Connect(function(Child: Instance)
		self:__addSound(Child)
	end),"Disconnect")

	self.__janitor:Add(SoundGroupInstance.ChildRemoved:Connect(function(Child: Instance)
		self:__removeSound(Child)
	end),"Disconnect")

	self.__janitor:LinkToInstance(SoundGroupInstance)

	return self
end

function GroupClass:Destroy()
	self.__janitor:Destroy()
end

-->-----------------<--
--> Private Methods <--
-->-----------------<--

function GroupClass:__addSound(Sound: Sound)
	if (self.__sounds[Sound.Name]) then return end

	self.__sounds[Sound.Name] = SoundClass.new(Sound)
end

function GroupClass:__removeSound(Sound: Sound)
	local SoundClass: Types.SoundClass = self.__sounds[Sound.Name]
	if not (SoundClass) then return end

	SoundClass:Destroy()
end

-->----------------<--
--> Public Methods <--
-->----------------<--

function GroupClass:GetSound(Name: string): Types.SoundClass?
	return self.__sounds[Name]
end

function GroupClass:GetRandomSound(): Types.SoundClass?
	local SoundNames: {string} = {}

	for Name: string in self.__sounds do
		table.insert(SoundNames, Name)
	end

	if (#SoundNames == 0) then return end

	return self.__sounds[SoundNames[math.random(#SoundNames)]]
end

return GroupClass