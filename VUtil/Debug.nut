//=========================================//
//VUtil.Debug - Debug Draw helper functions
//=========================================//

VUtil.Debug <- {};

//Draws the entity's bounding box
function VUtil::Debug::DrawEntityBBox(entity,r,g,b,a,time = 0.15)
{
	DebugDrawBox(entity.GetOrigin(),entity.GetBoundingMins(), entity.GetBoundingMaxs(), r, g, b, a, time)
}

//Draws the entity's local direction vectors
function VUtil::Debug::DrawEntityVectors(entity,size,xray = false,time = 0.15)
{
	local origin = entity.GetOrigin();
	DebugDrawLine(origin, origin + (entity.GetLeftVector() * size), 255, 0, 0, xray, time)
	DebugDrawLine(origin, origin + (entity.GetForwardVector() * size), 0, 255, 0, xray, time)
	DebugDrawLine(origin, origin + (entity.GetUpVector() * size), 0, 0, 255, xray, time)
}

//Draws the entity's attachments
function VUtil::Debug::DrawEntityAttachments(entity,size,xray = false,time = 0.15,amount = 32) //No way to get the number of attachments so assume there are 32 or less
{
	for(local i = 0;i < amount;i++)
	{
		local origin = entity.GetAttachmentOrigin(i);
		local angles = entity.GetAttachmentAngles(i); //todo
		DebugDrawLine(origin, origin + (Vector(1,0,0) * size), 255, 0, 0, xray, time)
		DebugDrawLine(origin, origin + (Vector(0,1,0) * size), 0, 255, 0, xray, time)
		DebugDrawLine(origin, origin + (Vector(0,0,1) * size), 0, 0, 255, xray, time)
	}
}

function VUtil::Debug::DrawCross(origin,size,xray = false,time = 0.15)
{
	DebugDrawLine(origin - (Vector(1,0,0) * size), origin + (Vector(1,0,0) * size), 255, 0, 0, xray, time)
	DebugDrawLine(origin - (Vector(0,1,0) * size), origin + (Vector(0,1,0) * size), 0, 255, 0, xray, time)
	DebugDrawLine(origin - (Vector(0,0,1) * size), origin + (Vector(0,0,1) * size), 0, 0, 255, xray, time)
}