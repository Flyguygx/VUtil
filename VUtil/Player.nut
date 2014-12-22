//=======================================//
//VUtil.Player - General player functions
//=======================================//

VUtil.Player <- {};

//Freezes a player in place
function VUtil::Player::Freeze(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.None);
	}
}

//Enables noclip for a player
function VUtil::Player::EnableNoclip(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.Noclip);
	}
}

//Enables fly mode for a player
function VUtil::Player::EnableFly(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.Fly);
	}
}

//Resets the player's movetype to WALK (disables freeze/noclip/fly).
function VUtil::Player::ResetMoveType(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.Walk);
	}
}

//Forces the player to look at the given position.
function VUtil::Player::LookAt(player, targetPos)
{
	if(player.GetClassname() == "player")
	{
		local eyePos = player.EyePosition();
		local eyeToTarget =  targetPos - eyePos;
		
		local ToDegrees = 180.0 / 3.14159; //Converts radians to degrees (SetAngles uses degrees, atan2 returns radians).
		
		local pitch = atan2(eyeToTarget.Length2D(),eyeToTarget.z) * ToDegrees - 90.0; //Calculate the pitch (up/down) angle.
		local yaw = atan2(eyeToTarget.y,eyeToTarget.x) * ToDegrees; //Calculate the yaw (left/right) angle.
		
		player.SetAngles(pitch,yaw,0);
	}
}

//Returns whether the player is crouching or not.
function VUtil::Player::IsCrouching(player)
{
	if(player.GetClassname() == "player")
	{
		return player.GetBoundingMaxs().z < 72.0;
	}
	return false;
}

//Returns an array containing all of the weapons the player is holding.
function VUtil::Player::GetCurrentWeapons(player)
{
	local weapons = [];
	
	local weapon = null;
	while(weapon = Entities.FindByClassname(weapon,"weapon_*"))
	{
		if(weapon.GetOwner() == player)
		{
			weapons.push(weapon);
		}
	}
	
	return weapons;
}

//Creates an 'Eye Tracker' entity which will mimic the player's view angles and position.
//GetAngles on the eye will return the player's view angles.
//GetForwardVector on the eye will return the player's looking direction (useful for traces).
//This is a work around for the lack of an EyeAngles function for players.
function VUtil::Player::CreateEye(player)
{
	if(player != null)
	{
		if(player.GetClassname() == "player")
		{
			local playerID = player.entindex();
			
			//Create unique entity names for this player 
			local playerName = "player_"+playerID;
			local refName = "eye_ref_"+playerID;
			local origName = "eye_orig_"+playerID;
			local trackName = "eye_tracker_"+playerID;
			
			//Give the player a targetname
			VUtil.Entity.SetName(player,playerName);
			
			//The entity that the logic_measure_movement measures relative to.
			VUtil.Entity.Create("path_track", { targetname = refName });// MeasureReference/TargetReference
			
			//The entity which has the player's eye position & angles.
			local eyeOrigin = VUtil.Entity.Create("path_track", { targetname = origName }); //Target
			
			//The logic_measure_movement entity that tracks the player's eye position & angles.
			local tracker = VUtil.Entity.Create("logic_measure_movement",
			{
				targetname = trackName
				MeasureReference = refName
				TargetReference = refName
				Target = origName
				MeasureType = 1
				TargetScale = 1
			});
			
			//These do not get assigned properly with VUtil.Entity.Create
			EntFireByHandle(tracker,"setmeasurereference",refName,0.01,null,null);
			EntFireByHandle(tracker,"setmeasuretarget",playerName,0.01,null,null);
			EntFireByHandle(tracker,"enable","",0.02,null,null);
			
			return eyeOrigin;
		}
		else
		{
			printl("[VUtil.Player.CreateEye] Tried to make an eye tracker for a non-player entity!" );
		}
	}
	else
	{
		printl("[VUtil.Player.CreateEye] Tried to make an eye tracker for an invalid player!" );
	}
}