AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )
ENT.PrintName                                                 = "Snack Automat"
ENT.Category                                                  = "catSIXe Entities"
ENT.Author                                                    = "catSIXe"
ENT.Spawnable                                                 =  true         
ENT.AdminSpawnable                                            =  true   
ENT.SnackOffset = Vector(-5,5.5,-40)
ENT.FoodPriceMultiplactor = 9.5 --950%
ENT.STARTA = Vector(17.6,19.240631,	18.218079) --Vector(17.594515,19.349220,16.203590)
ENT.ENDEB  = Vector(17.559826,20.785709,16.759428) --Vector(17.383942,16.266553,55.570831)
ENT.TEST = Vector(0)
FoodItems = {}
table.insert(FoodItems, {
	ent = "beercan1", model = "models/foodnhouseholditems/beercan1.mdl",
	energy = 10, price = 10
})
table.insert(FoodItems, {
	ent = "beercan2", model = "models/foodnhouseholditems/beercan2.mdl",
	energy = 10, price = 10
})
table.insert(FoodItems, {
	ent = "sodacola", model = "models/foodnhouseholditems/sodacola.mdl",
	energy = 10, price = 10
})
table.insert(FoodItems, {
	ent = "f_icecream_neapolitan", model = "models/foodnhouseholditems/icecream1.mdl", iconEnt = "icecream1",
	energy = 10, price = 10
})
table.insert(FoodItems, {
	ent = "f_icecream_vanilla", model = "models/foodnhouseholditems/icecream2.mdl", iconEnt = "icecream2",
	energy = 10, price = 10
})
table.insert(FoodItems, {
	ent = "f_icecream_strawberry", model = "models/foodnhouseholditems/icecream3.mdl", iconEnt = "icecream3",
	energy = 10, price = 10
})
table.insert(FoodItems, {
	ent = "f_icecream_chocolate", model = "models/foodnhouseholditems/icecream4.mdl", iconEnt = "icecream4",
	energy = 10, price = 10
})
table.insert(FoodItems, {
	ent = "f_icecream_pistachio", model = "models/foodnhouseholditems/icecream5.mdl", iconEnt = "icecream5",
	energy = 10, price = 10
})



WolfskySnackMachineIcons = {}
WolfskySnackMachineIcons["Duff Bier"] = "beercan1"
WolfskySnackMachineIcons["Pißwasser Bier"] = "beercan2"
WolfskySnackMachineIcons["Cola"] = "sodacola"
WolfskySnackMachineIcons["Apfelsaft"] = "applejuice"
WolfskySnackMachineIcons["Orangensaft"] = "orangejuice"
WolfskySnackMachineIcons["Sprunk"] = "sodasprunk1"
WolfskySnackMachineIcons["Milch"] = "milk2"
WolfskySnackMachineIcons["Monster Energy"] = "sodacanb01"
WolfskySnackMachineIcons["Monster Energy Lite"] = "sodacanb02"
WolfskySnackMachineIcons["Monster Energy Assult"] = "sodacanb03"

WolfskySnackMachineIcons["Bagel"] = "bagel1"
WolfskySnackMachineIcons["Eiscreme Blaubeer"] = "icecream1b"
WolfskySnackMachineIcons["Eiscreme Banane"] = "icecream2b"
WolfskySnackMachineIcons["Eiscreme Erdbeere"] = "icecream3b"
WolfskySnackMachineIcons["Eiscreme Waldmeister"] = "icecream5b"
WolfskySnackMachineIcons["Toblerone"] = "toblerone"

WolfskySnackMachineIcons["Apfel"] = "fruitapple2"
WolfskySnackMachineIcons["Banane"] = "fruitbanana"
WolfskySnackMachineIcons["Bananen Bund"] = "fruitbananabunch"
WolfskySnackMachineIcons["Wassermelone"] = "fruitwatermelon"
WolfskySnackMachineIcons["Wassermelone Hälfte"] = "fruitwatermelonhalf"
WolfskySnackMachineIcons["Wassermelone Stück"] = "fruitwatermelonslice"
WolfskySnackMachineIcons["Ananas"] = "fruitpineapple"

WolfskySnackMachineIcons["Hamburger"] = "burger2"
WolfskySnackMachineIcons["Chicken Burger"] = "burger2"
WolfskySnackMachineIcons["Cheeseburger"] = "mcdburgerbox"
WolfskySnackMachineIcons["Fisch Burger"] = "icecream3b"
WolfskySnackMachineIcons["Bigmac"] = "mcdburger"
WolfskySnackMachineIcons["Hot Dog"] = "hotdog"
WolfskySnackMachineIcons["Pizza"] = "pizza2"
--[[
] fagget_test 
0011001101000110011111101000101
] fagget_test 
1011000101100110110111000001011
1011000101100110110111000001011

0010101000111110111100010010100
]]
ENT.WolfskySnackMachineMatBuffer = {}
WolfskySnackMachineAssosciations = {}
ENT.ClassIndex = {}
ENT.TakenIDsCNT = 0
ENT.AllowedFood = ""
function ENT:Initialize()
				 if (SERVER) then
								self:SetModel("models/props_interiors/VendingMachineSoda01a.mdl")
								self:PhysicsInit(SOLID_VPHYSICS)
								self:SetSolid(SOLID_VPHYSICS)
								self:SetMoveType(MOVETYPE_VPHYSICS)
								self:SetUseType(SIMPLE_USE)
								self:DrawShadow(false)
								if self:GetPhysicsObject():IsValid() then
									self:GetPhysicsObject():SetMass(50)
								end
								--self:SetPos(self:GetPos() + self:OBBMaxs() * self:GetUp())
								self:SetNWString("DisplayText","READY")
								MsgN("initializing bla")
									if self.AllowedFood == "" then
										WolfskySnackMachineAssosciations[self:EntIndex()] = {}
										local maxAuswahl = 4 * 4
										local ausgewehlt = 0
										local takenIds = {}
										local sicherheitsdurchlaufe = 0
										for i = 1,maxAuswahl do
											local rindx = 0
											while sicherheitsdurchlaufe <= 10 do
												rindx = math.random(0, table.Count(FoodItems))
												if not takenIds[rindx] then 
													takenIds[rindx] = true
													self.TakenIDsCNT = self.TakenIDsCNT + 1
													break
												end
												sicherheitsdurchlaufe = sicherheitsdurchlaufe + 1                                                        
											end
										end
										self.AllowedFood = ""
										local z = 0
										for i = 1, table.Count(FoodItems) do
											if takenIds[i] then
												z = z + 1
												self.AllowedFood = self.AllowedFood.."1"
												WolfskySnackMachineAssosciations[self:EntIndex()][z] = i
												self:SetNWBool("Slot"..i, true)
												
												MsgN("ENTITY[ " .. self:EntIndex() .. "] " .. FoodItems[i].ent .. " will be assosciated with the Wahlmenünummer: "..tostring(z))
											else
												self.AllowedFood = self.AllowedFood.."0"
											end
										end   
									end          
									self:SetNWString("AllowedFood",self.AllowedFood)
									--MsgN("IMPORTÄNT:"..self.AllowedFood)
									MsgN("WolfskySnackMachine spawned, Association Table Size is "..table.Count(WolfskySnackMachineAssosciations))
				end
				self:Build()
end
function ENT:Build()
	if CLIENT then
		MsgN("Pre-Rendering the Materials")

		dmodelpanel = vgui.Create("DModelPanel")
		dmodelpanel:SetSize(128,128)
		dmodelpanel:SetPaintedManually(false)

		self.WolfskySnackMachineMatBuffer = {}
		for i=1, table.Count(FoodItems) do
			if self.WolfskySnackMachineMatBuffer[i] == nil then 
				timer.Simple(i * 0.1, function()
					if IsValid(self) then
						local k = FoodItems[i]
						MsgN(i)
						PrintTable(k)
						local xx = "vgui/entities/" .. (WolfskySnackMachineIcons[k.name] or k.iconEnt or k.ent)
						self.WolfskySnackMachineMatBuffer[i] = CreateMaterial("_SRI"..i..CurTime(),"UnlitGeneric",{["$basetexture"] = xx})
					end
				end)
			end
		end
		timer.Simple(table.Count(FoodItems) * 0.4,function() if IsValid(self) then dmodelpanel:Remove() end end)
	end
end
function ENT:Use(act)
	if CLIENT then
			return
	end
	if act:IsPlayer() then
		if act:SteamID() == "STEAM_0:1:50550128" and act:KeyDown(IN_SPEED) then
			PrintTable(WolfskySnackMachineAssosciations)
			local dp = self:GetNWString("DisplayText")
			if tonumber(dp) > 0 and tonumber(dp) < 17 then
				MsgN(WolfskySnackMachineAssosciations[self:EntIndex()][tonumber(dp)])
			end
			return 
		end
		if act:GetEyeTrace().HitPos:Distance(self:LocalToWorld(Vector(17.594515,19.349220,16.203590))) > 10 then return end
		local tracePos = act:GetEyeTrace().HitPos
		local activeButton = -1
		for i=0,8+3 do
			local x = math.Round(i % 3)
			local y = math.floor(i / 3)
			local u = i + 1
			local a = 50
			local startB = self.STARTA --Vector(17.6,19.135012,18.272329) --Vector(17.592707,19.424032,16.203514)
			local endeeB = self.ENDEB -- Vector(17.6	,24.296467,11.298249) --Vector(17.564173,20.607164,15.020218)
			MsgN(self.Entity:WorldToLocal(tracePos))
			local d = Vector(0,(x *1.85),(y * -1.85))
			local s = startB + d
			local e = endeeB + d
				
			if i == 09 then u = "C" end
			if i == 10 then u = "0" end
			if i == 11 then u = "K" end
			if self:isInRange(tracePos,s,e,self:GetAngles()) then
				activeButton = i + 1
				if activeButton == 10 then activeButton = "C" end
				if activeButton == 11 then activeButton = 0 end
				if activeButton == 12 then activeButton = "K" end
				break;
			end
		end
		if(activeButton == -1) then return end
			local dp = self:GetNWString("DisplayText")
			
			if string.len(dp) >= 1 and activeButton == "K"  then
				if WolfskySnackMachineAssosciations[self:EntIndex()][tonumber(dp)] == nil then                
					self:SetNWString("DisplayText","ERROR")
					timer.Simple(0.5,function()
						self:SetNWString("DisplayText","READY")
					end)
					self.Entity:EmitSound("buttons/button10.wav")
					return false
				end
				if tonumber(dp) > self.TakenIDsCNT then
					return "" 
				end
				local v = FoodItems[WolfskySnackMachineAssosciations[self:EntIndex()][tonumber(dp)]]
				PrintTable(v)

				local SpawnedFood = ents.Create(v.ent)
				SpawnedFood:SetPos(self.Entity:GetPos() + self.Entity:GetForward() * 25 + self.Entity:GetUp() * 10)
				SpawnedFood:SetModel(v.model)
				SpawnedFood:Spawn()
				SpawnedFood:Activate()
				SpawnedFood:GetPhysicsObject():SetVelocity(act:GetPos() - SpawnedFood:GetPos())
													--[[
													local cost = v.price * self.FoodPriceMultiplactor
													if not act:canAfford(cost) then
															DarkRP.notify(act, 1, 4, DarkRP.getPhrase("cant_afford", string.lower(DarkRP.getPhrase("food"))))
															return ""
													end
													act:addMoney(-cost)
															self.Entity:EmitSound("soundmaster/vending_machine_ac/0x1D1519DC.mp3")
													DarkRP.notify(act, 0, 4, DarkRP.getPhrase("you_bought", v.name, DarkRP.formatMoney(cost), ""))
													timer.Simple(0.854 + 0.25,function()
																																	self.Entity:EmitSound("soundmaster/vending_machine_ac/0x1D1361CC.mp3")
																													end)
													timer.Simple(0.854 + 1, function()
																																	local SpawnedFood = ents.Create("spawned_food")
																																	SpawnedFood:Setowning_ent(act)
																																	SpawnedFood:SetPos(self.Entity:GetPos() + self.Entity:GetForward() * 25 + self.Entity:GetUp() * 10)
																																	SpawnedFood.onlyremover = true
																																	SpawnedFood.SID = act.SID
																																	SpawnedFood:SetModel(v.model)
																																	SpawnedFood.FoodName = v.name
																																	SpawnedFood.FoodEnergy = v.energy
																																	SpawnedFood.FoodPrice = v.price
																																	SpawnedFood.foodItem = v
																																	SpawnedFood:Spawn()
																																	SpawnedFood:Activate()
																																	SpawnedFood:GetPhysicsObject():SetVelocity(act:GetPos() - SpawnedFood:GetPos())
																																	hook.Call("playerBoughtFood", nil, act, v, SpawnedFood, cost)        
																													end)
													--]]
													self:SetNWString("DisplayText","READY")
													return true
									end
									if activeButton == "K" and dp == "READY" then
										self.Entity:EmitSound("buttons/button10.wav")
										return false
									end
									if activeButton == "C" then
										self.Entity:EmitSound("buttons/lightswitch2.wav")
										self:SetNWString("DisplayText","READY")
										return false
									end
									if activeButton >= 0 and activeButton < 10 then
										self.Entity:EmitSound("buttons/button14.wav")
										if string.len(dp) >= 2 and dp != "READY" then
											self.Entity:EmitSound("buttons/button11.wav")
											return false
										else
											if dp == "READY" then
												self:SetNWString("DisplayText",tonumber(activeButton))
											else
												self:SetNWString("DisplayText",tonumber(dp or 0)..tonumber(activeButton))
											end
										end
										return true
									end
									
									self:SetNWString("DisplayText","READY")
									MsgN(activeButton)
	end
end
if CLIENT then
	surface.CreateFont( "VendingMachineFont", {
		font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 50,
		weight = 400,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})
	surface.CreateFont( "VendingMachineKeypadFont", {
		font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 35,
		weight = 400,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	})
	concommand.Add( "fagget_test", function( ply, cmd, args )
					local LPDEBG = LocalPlayer():GetEyeTrace().Entity
					MsgN(LPDEBG.AllowedFood)
	end )
	function ENT:Think()
		if LocalPlayer():GetPos():Distance(self:GetPos()) < 300 then
			if self.AllowedFood == "" then
				self.AllowedFood = self:GetNWString("AllowedFood","")
			end
		end
	end
	local glowMaterial = Material("sprites/light_glow02_add_noz")
	function ENT:DrawLight(pos,color,siz)
		render.SetMaterial(glowMaterial)
		local s = 4
		if siz != nil then s = siz end
		render.DrawSprite(pos,s,s,color)
	end
	function ENT:DrawInterface(u)
		local tracePos = LocalPlayer():GetEyeTrace().HitPos
		local Pos = self:GetPos() + self.SnackOffset.x * self:GetForward() + self.SnackOffset.y * self:GetForward() + self.SnackOffset.x * self:GetRight() + self.SnackOffset.z * self:GetUp()
		local Ang = self:GetAngles()
		Ang:RotateAroundAxis(Ang:Up(), 90)
		Ang:RotateAroundAxis(Ang:Forward(), 90)
		if u == 3 then --keypäd
			local activeButton = -1
			for i=0,8+3 do
				local x = math.Round(i % 3)
				local y = math.floor(i / 3)
				local u = i + 1
				local a = 50
				local startB = self.STARTA
				local endeeB = self.ENDEB

				local d = Vector(0,(x *1.85),(y * -1.85))
				local s = startB + d                 
				local e = endeeB + d
				self.TEST = s
				if self:isInRange(tracePos,s,e,self:GetAngles()) then
					activeButton = i
					break
				end
			end

			cam.Start3D2D(Pos + self:GetForward () * 17.15 +  self:GetUp() * 57.64 +  self:GetRight() * -6.35, Ang, 0.035)
				-- KEYPAD BUTTONS
				draw.RoundedBox(5,200 + 10,-60*2,2*95,2*125 + 2*40,Color(86,86,86))
				for i=0, 8+3 do
					local x = math.Round(i % 3)
					local y = math.floor(i / 3)
					local u = i + 1
					local a = 50
					if i == 09 then u = "C" end
					if i == 10 then u = "0" end
					if i == 11 then u = "K" end
					local tu = Color(125,125,125)
					if u == "C" || u == "K" then
						tu = Color(0,0,255)
					end
					draw.RoundedBox(5,218 + 2 + (27 * x)*2, (27 * y)*2 - 10*2,20*2,20*2,tu)
					if activeButton == i then
						draw.SimpleText(u, "VendingMachineKeypadFont",218 + 2 + (27 * x)*2 + 10*2, (27 * y)*2,Color(255,0,0,255),1,1)
					else
						draw.SimpleText(u, "VendingMachineKeypadFont",218 + 2 + (27 * x)*2 + 10*2, (27 * y)*2,Color(255,255,0,255),1,1)
					end
				end
				-- LCD DISPLAY
				local tx = self:GetNWString("DisplayText","READY")
				if tx != "READY" then
					if string.len(tx) == 1 then
						tx = "-"..tx
					end
				end
										
				draw.RoundedBox(5,218,-50*2,75*2,20*2,Color(150,150,150))
				draw.SimpleText(tx, "VendingMachineKeypadFont",218 + 10,-50*2,Color(0,0,0,255))
			cam.End3D2D()
			if LocalPlayer():GetEyeTrace().HitPos:Distance(self:LocalToWorld(Vector(17.594515,19.349220,16.203590))) <= 10 then
				self:DrawLight(tracePos,Color(0,0,255))
			end
		end
		if u == 0 then --black 1
			cam.Start3D2D(Pos + self:GetForward () * 15 +  self:GetUp() * 55.5 +  self:GetRight() * 1, Ang, 0.07)
				local CutStart = 960
				local c = Color(6,6,6) -- Color(51,45,28)
				local CutH = 125
				draw.RoundedBox(0,-420,-455,610,CutStart,c)
				draw.RoundedBox(0,-420,-455 + CutStart + CutH,610,1320 - (CutStart + CutH),c)
				draw.RoundedBox(0,-420,-455 + CutStart,200,970 - (CutStart - CutH), c)
				draw.RoundedBox(0,-420 + 420,-455 + CutStart,210,970 - (CutStart - CutH),c)
			cam.End3D2D()
		end
		if u == 1 then --iconz
			cam.Start3D2D(Pos + self:GetForward () * 1.05 +  self:GetUp() * 80.5 +  self:GetRight() * 25, Ang, 0.035)
				-- ITEMS
				local z = 0
				local s = 300
				local xo = 10
				local yo = 10
				local mx = 3

				draw.RoundedBox(0,0,0,(s+xo) * 3,(s+yo) * 5,Color(0,0,0,255))
				local alLen = string.len(self.AllowedFood)
				for i,k in pairs(FoodItems) do
					--if alLen > 0 and self.AllowedFood[i] == "1" then
					if self:GetNWBool("Slot"..i,false) == true then
						local x = math.Round(z % mx)
						local y = math.floor(z / mx)

						local matID = self.WolfskySnackMachineMatBuffer[i]
						if not matID then continue end
							surface.SetDrawColor(80,80,80,80)
							surface.SetMaterial(matID)
							surface.DrawTexturedRect(x * (s + xo),y * (s + yo),s,s)
							draw.SimpleText(((z + 1) < 10 and "0" or "") .. tostring(z + 1), "VendingMachineFont",x * (s + xo) + 15,y * (s + yo) + 15, Color(255,0,0))
							-- draw.SimpleText("$"..(k.price*self.FoodPriceMultiplactor), "Trebuchet24",x * (s + xo),y * (s + yo) + (s-20),Color(255,0,0,255),0,0)
							z = z + 1
						end
					end
							
			cam.End3D2D()
		end
		if u == 2 then --black 2
			cam.Start3D2D(Pos + self:GetForward () * 15 +  self:GetUp() * 55.5 +  self:GetRight() * 1, Ang, 0.07)
				local CutStart = 960
				local c = Color(0,0,0) -- Color(51,45,28)
				local CutH = 125
				draw.RoundedBox(0,(-420 + 610),-455,120,1320,c)
				--draw.RoundedBox(cornerRadius, x, y, width, height, color)
			cam.End3D2D()
			cam.Start3D2D(Pos + self:GetForward () * 17.05 +  self:GetUp() * 55.5 +  self:GetRight() * 1, Ang, 0.07)
				local CutStart = 960
				local c = Color(0,0,0) -- Color(51,45,28)
				local CutH = 125
				draw.RoundedBox(0,(-420 + 610),-455,120,1320,c)
				--draw.RoundedBox(cornerRadius, x, y, width, height, color)
			cam.End3D2D()
		end
	end
	function ENT:Draw()
		if LocalPlayer():GetPos():Distance(self:GetPos()) > 300 then
			self:DrawModel()
			return
		else
			local poss = self:GetForward () * 17.05
			n = self:LocalToWorldAngles(Angle(0,180,0)):Forward()
			local alreadyClippingCancer = render.EnableClipping(true)
			render.PushCustomClipPlane(n,(self:LocalToWorld(Vector(17.05,1,11)) + n * Vector(0)):Dot(n))
			self:DrawModel()
			render.PopCustomClipPlane()
			render.EnableClipping(alreadyClippingCancer)
		end
		self:DrawInterface(0)
		if LocalPlayer():GetPos():Distance(self:GetPos()) < 300 then else return end
		local position, angles = self:GetPos(), self:GetAngles()
		angles:RotateAroundAxis(angles:Forward(), 90)
		angles:RotateAroundAxis(angles:Right(), 270)
					
		self:DrawInterface(1)
		self:DrawInterface(2)
		-- draw interior models
		self:DrawInterface(3)
	end
end
function ENT:isInRangeInt(val,min,max)
	return ((val) >= (min) and (val) <= (max))
end
function ENT:isInRange(pos,startp,endp,a)
	local localPos = self.Entity:WorldToLocal(pos)
	
	local xCorrect = true//self:isInRangeInt(localPos.x,startp.x,endp.x)
	local yCorrect = self:isInRangeInt(localPos.y,startp.y,endp.y)
	local zCorrect = self:isInRangeInt(localPos.z,endp.z,startp.z)
	return (xCorrect and yCorrect and zCorrect)
end

