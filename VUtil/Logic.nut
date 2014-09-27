//============================================//
//VUtil.Logic - Entity logic and I/O functions
//============================================//

VUtil.Logic <- {};

//Links two entities together with the given input & output
function VUtil::Logic::Link(entity,output,target,input = "use",param = "",delay = 0,max = -1)
{
	//addoutput format: addoutput "<output name> <target entity>, <input name>, <parameter>, <delay time>, <max times to fire>"
	local kvString = format("%s %s,%s,%s,%f,%d",output,target.GetName(),input,param,delay,max);
	EntFireByHandle(entity,"addoutput",kvString,0.0,null,null);
}

//Link a table of inputs/outputs together
//Note: Muliple links to one output not yet supported
/*
Format:
Outputs <- {
	<output1> = [<target entity>,<input>,<parameter>,<delay>,<times to fire>]
	<output2> = [<target entity>,<input>,<parameter>,<delay>,<times to fire>]
	...
}
VUtil.Logic.LinkTable(<entity>, Outputs)
*/
function VUtil::Logic::LinkTable(entity,connections)
{
	foreach(output,param in connections)
	{
		local kvString = format("%s %s,%s,%s,%f,%d",output,param[0].GetName(),param[1],param[2],param[3],param[4]);
		EntFireByHandle(entity,"addoutput",kvString,0.0,null,null);
	}
}

//Link an output to a script function
function VUtil::Logic::LinkFunction(entity,output,target,func,delay = 0,max = -1)
{		
	VUtil.Logic.Link(entity,output,target,"callscriptfunction",func,delay,max);//Add an output that calls the function.
}