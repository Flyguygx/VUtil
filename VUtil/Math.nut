//===================================//
//VUtil.Math - General Math Utilities
//===================================//

VUtil.Math <- {};

//--Math Constants--
VUtil.Math.PI <- 3.14159265;
VUtil.Math.TAU <- 6.28318531;
VUtil.Math.Degrees <- 57.29577951;
VUtil.Math.Radians<- 0.01745329;
	
//--General Math Functions--
//Clamps a value to the range between low and high.
function VUtil::Math::Clamp(value,low,high)
{
	if(value < low) return low;
	if(value > high) return high;
	return value;
}	
//Returns the smallest of the two values.
function VUtil::Math::Min(a,b)
{
	if(a < b) return a;
	return b;
}
//Returns the largest of the two values.
function VUtil::Math::Max(a,b)
{
	if(a > b) return a;
	return b;	
}

//Interpolates between two numbers/vectors by the given fraction (0-1)
function VUtil::Math::Lerp(a,b,frac)
{
	return a + (b - a) * frac;
}

//Returns the modulus of a & b
function VUtil::Math::Mod(a,b) 
{ 
	return ((a/b) - floor(a/b))*b; 
}

//--Vector Math Functions--
//Returns the distance between v1 and v2.
function VUtil::Math::Distance(v1,v2)
{
	return (v1-v2).Length();
}
//Scales vector v to have a length of 1.
function VUtil::Math::Normalize(v)
{
	return v * (1.0 / v.Length());
}
//Returns the pitch/yaw angles between vectors v1 and v2
function VUtil::Math::AnglesBetween(v1,v2)
{
	local dir = v2 - v1;
	local yaw = atan2(dir.y,dir.x);
	local pitch = atan2(dir.Length2D(),dir.z);
	
	return Vector(pitch,yaw,0);
}