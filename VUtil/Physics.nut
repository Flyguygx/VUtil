//=========================================//
//VUtil.Physics - General Physics Functions
//=========================================//

VUtil.Physics <- {};

//--Trace Helpers--//
//Traces a line from start to end and returns the hit position, distance, and fraction
function VUtil::Physics::TraceLine(start, end, filter)
{
	local line = end-start;
	local frac = ::TraceLine(start,end,filter);
	
	local traceInfo = {}
	traceInfo.Hit <- start + (line * frac);
	traceInfo.Distance <- (line * frac).Length();
	traceInfo.Fraction <- frac;
	
	return traceInfo;
}

//Traces a ray from start in a given direction and returns the hit position, distance, and fraction
function VUtil::Physics::TraceRay(start, direction, distance, filter)
{
	local line = direction * distance;
	local end = start + line;
	local frac = ::TraceLine(start,end,filter);
	
	local traceInfo = {}
	traceInfo.Hit <- start + (line * frac);
	traceInfo.Distance <- (line * frac).Length();
	traceInfo.Fraction <- frac;
	
	return traceInfo;
}
