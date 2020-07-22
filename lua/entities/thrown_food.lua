AddCSLuaFile()
-- maybe doing it later
DEFINE_BASECLASS( "base_anim" )
ENT.Base			= "base_anim"
ENT.Type			= "anim"
 
ENT.PrintName		= "Thrown Food"
ENT.Author			= "catSIXe"
ENT.FoodType		= "generic"
ENT.FoodSplashColor	= Color(255, 255, 255)

if SERVER then
	util.AddNetworkString( "Food_Explosion" )
	util.AddNetworkString( "Food_DecalEx" )
end
if CLIENT then
	local emitter = ParticleEmitter(Vector(0,0,0))
	function food_splash_init(particle, vel, color)
		particle:SetColor(color.r,color.g,color.b)
		particle:SetVelocity( vel or VectorRand():GetNormalized() * 15)
		particle:SetGravity( Vector(0,0,-500) )
		particle:SetLifeTime(0)
		particle:SetDieTime(math.Rand(5,10))
		particle:SetStartSize(4)
		particle:SetEndSize(0)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetCollide(true)
		particle:SetBounce(0.3)
		particle:SetRoll(math.pi*math.Rand(0,1))
		particle:SetRollDelta(math.pi*math.Rand(-10,10))
	end
	net.Receive("Food_Explosion",function ()
		if !emitter then emitter = ParticleEmitter(Vector(0,0,0)) end
		--if !self or !emitter then return MsgN("No Emitter or self exist") end
		local pos = net.ReadVector()
		local norm = net.ReadVector()
		local bucketvel = net.ReadVector()
		local entid = net.ReadFloat()
		local color = Color(net.ReadInt(8), net.ReadInt(8), net.ReadInt(8))
		MsgN(color)
		timer.Destroy("particle_timer"..entid)
		
		for i = 1,20 do
			local particle = emitter:Add( "decals/decal_paintsplatter002", pos )
			if particle then
				local dir = VectorRand():GetNormalized()
				food_splash_init(particle, ((-norm)+dir):GetNormalized() * math.Rand(0,200) + bucketvel*0.5, color)
			end
		end
	end)
	net.Receive("Food_DecalEx",function ()
		local material = net.ReadString()
		local ent = net.ReadEntity()
		local position = net.ReadVector()
		local normal = net.ReadVector()
		local color = Color(net.ReadInt(8), net.ReadInt(8), net.ReadInt(8))
		local s = net.ReadInt(10)
		--local entid = net.ReadFloat()
		util.DecalEx(Material(material), ent, position, normal, color, s, s)
	end)
end
function ENT:SetupFoodType(foodType)
	self:SetNWString("foodType", foodType)
	self.FoodType = foodType
end
function ENT:SetupColor(color)
	self:SetNWInt("color_R", color.r)
	self:SetNWInt("color_G", color.g)
	self:SetNWInt("color_B", color.b)
	self.FoodSplashColor = color
end
function ENT:Initialize()
	self:SetModel( "models/props_phx/misc/potato.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	--self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	if CLIENT then
		if !emitter then emitter = ParticleEmitter(Vector(0,0,0)) end
		emitter:SetPos(LocalPlayer():GetPos())

		if IsValid(self) then
			local kt = "particle_timer"..self:EntIndex()
			timer.Create(kt, 0.01, 0, function()
				if !emitter then
					emitter = ParticleEmitter(LocalPlayer():GetPos())
					return
				end
				if !IsValid(self) then
					timer.Destroy(kt)
					return
				end
				color = Color(self:GetNWInt("color_R"), self:GetNWInt("color_G"), self:GetNWInt("color_B"))
				if math.Rand(0,1) < 0.33 then
					local particle = emitter:Add( "decals/decal_paintsplatter002", self:GetPos() + VectorRand():GetNormalized() * 4)
					if particle then
						food_splash_init(particle, Vector(0), color)
					end
				end
			end)
		end
	end
end

function ENT:PhysicsCollide(colData, collider)
	if CLIENT then return end
	--[[net.WriteVector()
	net.WriteVector(colData.HitNormal)
	net.WriteVector(colData.OurOldVelocity)
	net.WriteFloat(entid)--]]
	PrintTable(colData)

	if IsValid(colData.HitEntity) then
		if colData.HitEntity:IsPlayer() then
			MsgN("Collision with Player")
			colData.HitEntity:ViewPunch( Angle( math.Rand(-8,8), math.Rand(-8,8), 0 ) )
			self:EmitSound("physics/body/body_medium_impact_hard"..math.floor(math.Rand(1,6))..".wav")
		else
			self:EmitSound("physics/cardboard/cardboard_box_impact_soft"..math.floor(math.Rand(1,7))..".wav")
		end
		--[[if not self.Paneled and colData.HitEntity:GetClass() == "mediaplayer_tv" then
			self.Paneled = true
			local overlayPanel = ents.Create("prop_physics")
			overlayPanel:SetPos(colData.HitPos)
			local a = colData.HitNormal:Angle()
			a:RotateAroundAxis(a:Forward(), 90)
			a:RotateAroundAxis(a:Right(), 90)
			overlayPanel:SetAngles(a)
			overlayPanel:SetModel("models/props_phx/construct/glass/glass_plate1x1.mdl")
			overlayPanel:Spawn()
			--overlayPanel:SetMoveType(MOVETYPE_NONE)
			overlayPanel:SetColor(Color(255,255,255,1))
			overlayPanel:Activate()
			local phys = overlayPanel:GetPhysicsObject( )
			if IsValid( phys ) then
				phys:Wake()
				phys:EnableMotion(false)
			end
			local p1 = colData.HitPos - (colData.HitNormal * 20)
			local p2 = colData.HitPos + (colData.HitNormal * 20)
			self:Splash(p1, p2)
			SafeRemoveEntityDelayed(overlayPanel, 15)
			SafeRemoveEntity( self )
			-- return true --exit prematurely
			--self.Hitted = false
		end--]]
	end
	local p1 = colData.HitPos--colData.HitPos - (colData.HitNormal * 10)
	local p2 = colData.HitNormal --HitPos + (colData.HitNormal * 10)
	local entid = self:EntIndex()
	net.Start("Food_Explosion")
		net.WriteVector(self:GetPos())
		net.WriteVector(colData.HitNormal)
		net.WriteVector(colData.OurOldVelocity)
		net.WriteFloat(entid)
		net.WriteInt(self.FoodSplashColor.r or 255,8)
		net.WriteInt(self.FoodSplashColor.g or 255,8)
		net.WriteInt(self.FoodSplashColor.b or 255,8)
	net.Broadcast()
	if self.FoodType == "generic" then
		util.Decal("YellowBlood", p1, p2)
	elseif self.FoodType == "icecream" then
		self:EmitSound("physics/flesh/flesh_impact_hard"..math.floor(math.Rand(1,6))..".wav")
		net.Start("Food_DecalEx")
			net.WriteString("decals/decal_paintsplatterblue001")
			net.WriteEntity(colData.HitEntity)
			net.WriteVector(colData.HitPos)
			net.WriteVector(colData.HitNormal)
			net.WriteInt(self.FoodSplashColor.r or 255,8)
			net.WriteInt(self.FoodSplashColor.g or 255,8)
			net.WriteInt(self.FoodSplashColor.b or 255,8)
			net.WriteInt(1,10)	
		net.Broadcast()
	elseif self.FoodType == "beer" then
		util.Decal("BeerSplash", p1, p2)
	--else if self.FoodType == "generic" then
	end
	timer.Create("kill_kt"..entid,0.25,2,function ()
		for _,v in pairs(player.GetAll()) do
			v:SendLua("timer.Destroy('particle_timer"..entid.."')")
		end
	end)
	SafeRemoveEntity( self )
end
function ENT:Splash(p1, p2)
end
