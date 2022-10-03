
Physics = {}
Physics.__index = Physics

Physics.CONTROLLER_ABSOLUTE = 0
Physics.CONTROLLER_RELATIVE = 1
Physics.CONTROLLER_VEHICLE = 2

-- Main Constructor
function Physics:new()
	
	return setmetatable( {}, Physics )
	
end

-- Metamethods
function Physics:__eq(physics)
	
	return self:getId() == physics:getId()
	
end

function Physics:__tostring()
	
	return "Physics #" .. self:getId()
	
end

-- Id constructors
function Physics:fromId(id)
	
	return Physics:new():setId(id)
	
end

function Physics:ofPlayer(id)
	
	return Physics:fromId( player(id, "physicsid") )
	
end

function Physics:ofItem(id)
	
	return Physics:fromId( item(id, "physicsid") )
	
end

function Physics:ofProjectile(id)
	
	return Physics:fromId( projectile(id, "physicsid") )
	
end

-- Class Constructors
function Physics:newRectanglePlatform(x, y, rotation, width, height)

	return Physics:fromId( physics_platform_rectangle(x, y, rotation, width, height) )
	
end

function Physics:newCirclePlatform(x, y, rotation, radius, edges)
	
	return Physics:fromId( physics_platform_circle(x, y, rotation, radius, edges) )
	
end

function Physics:newPolygonPlatform(x, y, rotation, polygon)
	
	return Physics:fromId( physics_platform_polygon(x, y, rotation, polygon) )
	
end

function Physics:newRectangle(x, y, rotation, width, height)
	
	return Physics:fromId( physics_object_rectangle(x, y, rotation, width, height) )
	
end

function Physics:newCircle(x, y, rotation, radius, edges)
	
	return Physics:fromId( physics_object_circle(x, y, rotation, radius, edges) )
	
end

function Physics:newPolygon(x, y, rotation, polygon)
	
	return Physics:fromId( physics_object_polygon(x, y, rotation, polygon) )
	
end

function Physics:newTile(x, y, rotation, _type)
	
	return Physics:fromId( physics_object_tile(x, y, rotation, _type) )
	
end

function Physics:newTire(x, y, rotation, width, height)
	
	return Physics:fromId( physics_object_tire(x, y, rotation, width, height) )
	
end

function Physics:newController(x, y, radius, physics, mode)
	
	return Physics:fromId( physics_controller(x, y, radius, physics:getId(), mode ) )
	
end

-- List methods (get a table containing physics objects)
function Physics:fromIdTable(idTable)
	
	local physicsTable = {}
	
	for i = 1, #idTable do
		
		physicsTable[i] = Physics:fromId( idTable[i] )
		
	end
	
	return physicsTable
	
end

function Physics:ofAll()
	
	return Physics:fromIdTable( physics(0, "table") )
	
end

function Physics:ofPlatforms()
	
	return Physics:fromIdTable( physics(0, "platforms") )
	
end

function Physics:ofPlayers()
	
	return Physics:fromIdTable( physics(0, "players") )
	
end

function Physics:ofProjectiles()
	
	return Physics:fromIdTable( physics(0, "projectiles") )
	
end

function Physics:ofControllers()
	
	return Physics:fromIdTable( physics(0, "controllers") )
	
end

function Physics:ofItems()
	
	return Physics:fromIdTable( physics(0, "items") )
	
end

function Physics:ofObjects()
	
	return Physics:fromIdTable( physics(0, "objects") )
	
end

-- Methods
function Physics:getType()
	
	return physics(self:getId(), "type")
	
end

function Physics:getTypename()
	
	return physics(self:getId(), "typename")
	
end

function Physics:getRotation()
	
	return physics(self:getId(), "rot")
	
end

function Physics:x()
	
	return physics(self:getId(), "posx")
	
end

function Physics:y()
	
	return physics(self:getId(), "posy")
	
end

function Physics:velX()
	
	return physics(self:getId(), "velx")
	
end

function Physics:velY()
	
	return physics(self:getId(), "vely")
	
end

function Physics:getAngVel()
	
	return physics(self:getId(), "angularvel")
	
end

function Physics:getStatic()
	
	return physics(self:getId(), "static")
	
end

function Physics:setId(id)
	
	self.id = id
	
	return self
	
end

function Physics:getId()
	
	return self.id
	
end

function Physics:setParent(parent)
	
	if parent then
	
		physics_setparent(self:getId(), parent:getId())
		
	else
		
		physics_setparent(self:getId(), 0)
		
	end
	
	return self
	
end

function Physics:setBounciness(bounciness)
	
	physics_setbounciness(self:getId(), bounciness)
	
	return self
	
end

function Physics:setFriction(friction)
	
	physics_setfriction(self:getId(), friction)
	
	return self
	
end

function Physics:setLinearDrag(drag)
	
	physics_setlineardrag(self:getId(), drag)
	
	return self
	
end

function Physics:setRotationalDrag(drag)
	
	physics_setrotationaldrag(self:getId(), drag)
	
	return self
	
end

function Physics:setMass(mass)
	
	physics_setmass(self:getId(), mass)
	
	return self
	
end

function Physics:getMass()
	
	return physics(self:getId(), "mass")
	
end

function Physics:setTexture(texture)
	
	physics_settexture(self:getId(), texture)
	
	return self
	
end

function Physics:setForce(x, y)
	
	physics_setforce(self:getId(), x, y)
	
	return self
	
end

function Physics:setTorque(torque)
	
	physics_settorque(self:getId(), torque)
	
	return self
	
end

function Physics:getTorque()
	
	return physics(self:getId(), "torque")
	
end

function Physics:applyForce(x, y)
	
	physics_addforce(self:getId(), x, y)
	
	return self
	
end

function Physics:applyTorque(torque)
	
	physics_addtorque(self:getId(), torque)
	
	return self
	
end

function Physics:stopMovement()
	
	physics_clearforce(self:getId())
	
	return self
	
end

function Physics:stopRotation()
	
	physics_cleartorque(self:getId())
	
	return self
	
end

function Physics:stop()
	
	physics_clearforce(self:getId())
	physics_cleartorque(self:getId())
	
	return self
	
end

function Physics:set(...)
	
	physics_setattribute(self:getId(), ...)
	
	return self
	
end

function Physics:addFrontWheel(frontWheel)
	
	physics_setattribute(self:getId(), "add_frontwheel", frontWheel:getId())
	
	return self
	
end

function Physics:addRearWheel(rearWheel)
	
	physics_setattribute(self:getId(), "add_rearwheel", rearWheel.getId())
	
	return self
	
end

function Physics:setSteeringSensitivity(steeringSensitivity)
	
	physics_setattribute(self:getId(), "steering_sensitivity", steeringSensitivity)
	
	return self
	
end

function Physics:setSteeringAngle(steeringAngle)
	
	physics_setattribute(self:getId(), "steering_angle", steeringAngle)
	
	return self
	
end

function Physics:destroy()
	
	return physics_destroy(self:getId())
	
end