-- Variables that are used on both client and server
SWEP.CanBuy = { }
SWEP.AutoSpawnable      = false
SWEP.Gun = ("m9k_minigun") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "M9K Machine Guns"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.Icon = "turtleicons/minigun1.vmt"
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "M134 Minigun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false	-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "crossbow"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_minigunvulcan.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_m134_minigun.mdl"	-- Weapon world model
SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.IsSilent = false
SWEP.Kind = WEAPON_EQUIP1

SWEP.Primary.Delay = 0.06
SWEP.Primary.Sound			= Sound("BlackVulcan.Single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 3500			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize		= 150		-- Size of a clip
SWEP.Primary.DefaultClip		= 150		-- Bullets you start with
SWEP.Primary.ClipMax               = 150
SWEP.Primary.KickUp				= 0.7		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.6		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.6		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "AirboatGun"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 0		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 10	-- Base damage per bullet
SWEP.Primary.Spread		= .035	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .035 -- Ironsight accuracy, should be the same for shotguns

SWEP.HeadshotMultiplier = 2.2

-- Enter iron sight info and bone mod info below
SWEP.RunSightsPos = Vector(0, -11.148, -8.033)
SWEP.RunSightsAng = Vector(55.082, 0, 0)

if ((gmod.GetGamemode().Name) == "Murderthon 9000") or ((gmod.GetGamemode().Name) == "Murderthon 9000 beta") then
	SWEP.Primary.ClipSize			= 100		-- Size of a clip
	SWEP.Primary.DefaultClip		= 200		-- Bullets you start with
else
	SWEP.Primary.ClipSize		= 150		-- Size of a clip
	SWEP.Primary.DefaultClip		= 150		-- Bullets you start with
       SWEP.Primary.ClipMax               = 150
end

function SWEP:Reload()

	self.Weapon:DefaultReload(ACT_VM_RELOAD) 
	if !self.Owner:IsNPC() then
		self.ResetSights = CurTime() + self.Owner:GetViewModel():SequenceDuration() end
	if ( self.Weapon:Clip1() < self.Primary.ClipSize ) and !self.Owner:IsNPC() then
	-- When the current clip < full clip and the rest of your ammo > 0, then
		self.Owner:SetFOV( 0, 0.3 )
		-- Zoom = 0
		self:SetIronsights(false)
		-- Set the ironsight to false
		self.Weapon:SetNetworkedBool("Reloading", true)
	end
	local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
	self:MiniGunIdle(waitdammit)
end

function SWEP:MiniGunIdle(wait)
	timer.Simple(wait + .05, function()
	if self.Weapon != nil then
	self.Weapon:SetNetworkedBool("Reloading", false)
	if SERVER then 
		self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
	else return end end
	end)
end

function SWEP:IronSight()

	if self.Owner:KeyDown(IN_SPEED) and not (self.Weapon:GetNWBool("Reloading")) then					// If you run then
	self.Weapon:SetNextPrimaryFire(CurTime()+0.5)				// Make it so you can't shoot for another quarter second
	self.IronSightsPos = self.RunSightsPos					// Hold it down
	self.IronSightsAng = self.RunSightsAng					// Hold it down
	self:SetIronsights(true, self.Owner)					// Set the ironsight true
	self.Owner:SetFOV( 0, 0.3 )						// Reset FOV
	end								

	if self.Owner:KeyReleased(IN_SPEED) then				// If you stop running then
	self:SetIronsights(false, self.Owner)					// Set the ironsight true
	self.Owner:SetFOV( 0, 0.3 )						// Reset FOV
	end

end