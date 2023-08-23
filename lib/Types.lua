local Types = {}

export type EasySound = {
	SoundDirectory: Instance;

	GetGroup: (self: EasySound, Name: string) -> GroupClass;
}

export type GroupClass = {
	Instance: SoundGroup;

	GetSound: (self: GroupClass, Name: string) -> SoundClass;
	GetRandomSound: (self: GroupClass) -> SoundClass;
}

export type SoundClass = {
	Instance: Sound;

	Play: (self: SoundClass, PlaybackConfig: PlaybackConfig) -> Sound;
}

export type PlaybackConfig = {
	Parent: Instance?;
	AutoDestroy: boolean;

	Volume: number?;
	Pitch: number?;
}

return Types