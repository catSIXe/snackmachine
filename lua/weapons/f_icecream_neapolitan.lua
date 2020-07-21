AddCSLuaFile()
SWEP.Base = "f_base"

SWEP.PrintName = "Ice Cream (Neapolitan)"
SWEP.Category = "catSIXe Food"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "passive"
SWEP.ViewModelFOV = 40.804020100503
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/foodnhouseholditems/icecream1.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Pin"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, -30, -30), angle = Angle(0, 0, 0) },
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, -30, -30), angle = Angle(0, 0, 0) }
}
SWEP.IronSightsPos = Vector(-2.12, -8.443, 3.21)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.VElements = {
	["food"] = { type = "Model", model = "models/foodnhouseholditems/icecream1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.147, 2.414, -2.625), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = ""}
}
SWEP.WElements = {
	["food"] = { type = "Model", model = "models/foodnhouseholditems/icecream1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.72, 2.571, -1.547), angle = Angle(166.132, -180, 10.519), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = ""}
}