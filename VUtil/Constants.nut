//=============================================//
//VUtil.Constants - Engine & Gameplay Constants
//=============================================//

VUtil.Constants <- {};

//Team Numbers for GetTeam/SetTeam
VUtil.Constants.Teams <-
{
	Unknown = 0
	Spectator = 1
	T = 2
	CT = 3
};

//Chat color characters for ScriptPrintMessageChatAll/Team
VUtil.Constants.ChatColors <-
{
	White = (1).tochar()
	Red = (2).tochar()
	Purple = (3).tochar()
	Green = (4).tochar()
	LightGreen = (5).tochar()
	LimeGreen = (6).tochar()
	LightRed = (7).tochar()
	Grey = (8).tochar()
	Yellow = (9).tochar()
	LightBlue = (10).tochar()
	Blue = (11).tochar()
	DarkBlue = (12).tochar()
	DarkGrey = (13).tochar()
	Pink = (14).tochar()
	OrangeRed = (15).tochar()
	Orange = (16).tochar()
};

//Entity movetypes (some are non-functional/redundant)
//Values and descriptions found in Alien Swarm SDK /src/public/const.h
VUtil.Constants.MoveTypes <-
{
	None = 0 		// never moves
	Isometric = 1 	// For players -- in TF2 commander view, etc. (same as Walk)
	Walk = 2 		// Player only - moving on the ground
	Step = 3 		// gravity, special edge handling -- monsters use this
	Fly = 4 		// No gravity, but still collides with stuff
	FlyGravity = 5	// flies through the air + is affected by gravity
	VPhysics = 6	// uses VPHYSICS for simulation
	Push = 7		// no clip to world, push and crush
	Noclip = 8		// No gravity, no collisions, still do velocity/avelocity
	Ladder = 10		// Used by players only when going onto a ladder
	Observer = 11	// Observer movement, depends on player's observer mode
	Custom = 12		// Allows the entity to describe its own physics
}
