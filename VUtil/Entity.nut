//=======================================//
//VUtil.Entity - General entity functions
//=======================================//

VUtil.Entity <- {};

//Creates an entity with the given classname and keyvalues
//targetname = entity name
//origin = x,y,z position
//angles = pitch,yaw,roll angles
function VUtil::Entity::Create(classname,keyvalues = {})
{
	local entity = Entities.CreateByClassname(classname);
	
	foreach( key, value in keyvalues )
	{
		VUtil.Entity.SetKeyValue(entity,key,value);
	}	
	return entity;
}

function VUtil::Entity::SetKeyValue(entity,key,value)
{
	//modified from Alien Swarm SDK /src/game/server/spawn_helper.nut
	switch ( typeof( value ) )
	{
		case "string":
			entity.__KeyValueFromString( key, value );
		break;
		
		case "bool":
			entity.__KeyValueFromInt( key, value.tointeger() );
		break;
		
		case "integer":
			entity.__KeyValueFromInt( key, value );
		break;
		
		case "float":
			entity.__KeyValueFromFloat( key, value );
		break;

		case "Vector":
			entity.__KeyValueFromVector( key, value );
		break;
		
		case "instance": //Allows passing a named entity as a key.
			if(value.IsValid())
			{
				if(value.GetName().len() != 0)
				{
					entity.__KeyValueFromString( key, value.GetName() );
				}
				else
				{
					printl( "[VUtil.Entity.SetKeyValue] Entity must have a name to be used as a value! (" + key + ")");
				}
			}
			else
			{
				printl( "[VUtil.Entity.SetKeyValue] Cannot use an invalid entity as a value! (" + key + ")");
			}
		break;

		default:
			printl( "[VUtil.Entity.SetKeyValue] Cannot use " + typeof( value ) + " as a value! (" + key + ")" );
	}
}

//Gives the entity a unique name if it doesn't already have a name.
function VUtil::Entity::EnsureHasName(entity)
{
	if(entity.GetName().len() == 0)
	{
		local name = entity.GetClassname()+ "_" + UniqueString();
		entity.__KeyValueFromString("targetname",name);
	}
}

//Gives the entity a unique name.
function VUtil::Entity::GiveUniqueName(entity)
{
	local name = entity.GetClassname()+ "_" + UniqueString();
	entity.__KeyValueFromString("targetname",name);
}

//Gives the entity a unique name.
function VUtil::Entity::SetName(entity,name)
{
	entity.__KeyValueFromString("targetname",name);
}

//Sets the entity's movetype
function VUtil::Entity::SetMoveType(entity,movetype)
{
	entity.__KeyValueFromInt("movetype",movetype);
}

//Returns an array containing all of the entities in the map.
function VUtil::Entity::GetAll()
{
	local entities = [];
	local entity = null;
	while(entity = Entities.Next(entity))
	{
		entities.push(entity);
	}
	return entities;
}

//Returns an array containing all of the entities with the given class name.
function VUtil::Entity::GetAllByClassname(classname)
{
	local entities = [];
	local entity = null;
	while(entity = Entities.FindByClassname(entity,classname))
	{
		entities.push(entity);
	}
	return entities;
}

//Returns an array containing all of the entities with the given name.
function VUtil::Entity::GetAllByName(name)
{
	local entities = [];
	local entity = null;
	while(entity = Entities.FindByName(entity,name))
	{
		entities.push(entity);
	}
	return entities;
}

//Returns an array containing all of the entities with the given name.
function VUtil::Entity::GetAllByModel(modelname)
{
	local entities = [];
	local entity = null;
	while(entity = Entities.FindByModel(entity,modelname))
	{
		entities.push(entity);
	}
	return entities;
}

//Returns an array containing all of the entities in a sphere
function VUtil::Entity::GetAllInSphere(position,radius)
{
	local entities = [];
	local entity = null;
	while(entity = Entities.FindInSphere(entity,position,radius))
	{
		entities.push(entity);
	}
	return entities;
}

//Iterates over all entities with the given classname and calls the modifier function with them.
function VUtil::Entity::IterateAll(modifier)
{
	local entity = null;
	while(entity = Entities.Next(entity))
	{
		modifier(entity);
	}
}

//Iterates over all entities with the given classname and calls the modifier function with them.
function VUtil::Entity::IterateByClassname(classname,modifier)
{
	local entity = null;
	while(entity = Entities.FindByClassname(entity,classname))
	{
		modifier(entity);
	}
}

//Iterates over all entities with the given name and calls the modifier function with them.
function VUtil::Entity::IterateByName(name,modifier)
{
	local entity = null;
	while(entity = Entities.FindByName(entity,name))
	{
		modifier(entity);
	}
}

//Iterates over all entities with the given model and calls the modifier function with them.
function VUtil::Entity::IterateByModel(modelname,modifier)
{
	local entity = null;
	while(entity = Entities.FindByModel(entity,modelname))
	{
		modifier(entity);
	}
}

//Iterates over all entities with the given model and calls the modifier function with them.
function VUtil::Entity::IterateInSphere(position,radius,modifier)
{
	local entity = null;
	while(entity = Entities.FindInSphere(entity,position,radius))
	{
		modifier(entity);
	}
}

//Creates a decal with the specified material on the nearest surface.
function VUtil::Entity::CreateDecal(position,material)
{
	local decal = VUtil.Entity.Create("infodecal", { texture = material });
	decal.SetOrigin(position);
	EntFireByHandle(decal,"activate","",0,null,null);
}
