-- Variables that are used on both client and server
SWEP.CanBuy = { }
SWEP.AutoSpawnable      = false
SWEP.Gun = ("m9k_m60") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "M9K Machine Guns"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "M60 Machine Gun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_m60machinegun.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_m60_machine_gun.mdl"	-- Weapon world model
SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.IsSilent = false
SWEP.Kind = WEAPON_EQUIP1

SWEP.AutoSpawnable      = false
SWEP.Primary.Sound			= Sound("Weapon_M_60.Single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 575			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize		= 150		-- Size of a clip
SWEP.Primary.DefaultClip		= 150		-- Bullets you start with
SWEP.Primary.ClipMax               = 150
SWEP.Primary.KickUp				= 0.6		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.4		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.5		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "AirboatGun"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Delay = 0.06
SWEP.HeadshotMultiplier = 2.2
SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 10	-- Base damage per bullet
SWEP.Primary.Spread		= .035	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .025 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-5.851, -2.763, 3.141)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-5.851, -2.763, 3.141)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(8.689, -3.444, -0.82)
SWEP.RunSightsAng = Vector(0, 44.18, 0)