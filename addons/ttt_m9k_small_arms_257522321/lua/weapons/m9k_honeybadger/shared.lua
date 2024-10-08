SWEP.AutoSpawnable      = false-- Variables that are used on both client and server
SWEP.CanBuy = { }
SWEP.Gun = ("m9k_honeybadger") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "M9K Submachine Guns"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.Icon = "vgui/ttt/m9k/icon_m9k_honeybadger.vmt"
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "AAC Honey Badger"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 50			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair					= true		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.IsSilent = true
SWEP.Kind = WEAPON_EQUIP1

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_aacbadger.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_aac_honeybadger.mdl"	-- Weapon world model
SWEP.Base 				= "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("Weapon_HoneyB.single")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 791		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.DefaultClip			= 30	-- Bullets you start with
SWEP.Primary.ClipMax                      = 60
SWEP.Primary.KickUp			= .5				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .3			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= .5		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "smg1"
SWEP.AmmoEnt = "item_ammo_smg1_ttt"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.SelectiveFire		= true

SWEP.Secondary.ScopeZoom			= 3.5	
SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= false	-- I mean it, only one	
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false
SWEP.Secondary.UseAimpoint		= true

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.7

SWEP.Primary.NumShots	= 1		--how many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 24	--base damage per bullet
SWEP.Primary.Spread		= .023	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .014 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector(-3.096, -3.695, 0.815)
SWEP.IronSightsAng = Vector(0.039, 0, 0)
SWEP.SightsPos = Vector(-3.096, -3.695, 0.815)
SWEP.SightsAng = Vector(0.039, 0, 0)
SWEP.RunSightsPos = Vector(4.094, -2.454, -0.618)
SWEP.RunSightsAng = Vector(-8.957, 53.188, -9.195)

SWEP.WElements = {
	["lense"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.671, 0.832, -8.141), angle = Angle(0, 0, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/wystan/attachments/aimpoint/lense", skin = 0, bodygroup = {} },
	["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.415, 0.518, 2.072), angle = Angle(-180, 90.197, 0), size = Vector(1.503, 1.503, 1.503), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["lense+"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.041, 0.832, -8.141), angle = Angle(0, 0, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/wystan/attachments/aimpoint/lense", skin = 0, bodygroup = {} }
}

SWEP.VElements = {
	["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Gun", rel = "", pos = Vector(0.228, 7.487, -4.416), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["lense"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "Gun", rel = "aimpoint", pos = Vector(0.298, 4.546, 6.756), angle = Angle(0, 90, 38.293), size = Vector(0.024, 0.024, 0.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/wystan/attachments/aimpoint/lense", skin = 0, bodygroup = {} }
}
