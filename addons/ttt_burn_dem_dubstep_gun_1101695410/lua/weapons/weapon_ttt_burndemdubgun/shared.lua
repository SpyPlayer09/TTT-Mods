AddCSLuaFile()

if SERVER then
resource.AddWorkshop ("1101695410") -- Automatic Download
end

if CLIENT then

	SWEP.Slot = 6
	SWEP.Icon = "vgui/ttt/icon_dubstgun.png"
	SWEP.PrintName = "Burn Dem Dubstep Gun"
	SWEP.ViewModelFlip = false

end

SWEP.Base = "weapon_tttbase"
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 58
SWEP.UseHands = true
SWEP.HoldType = "smg"
SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = { ROLE_DETECTIVE, ROLE_TRAITOR }

SWEP.EquipMenuData = {
    name = "Burn dem Gun",
    type = "Sound Guns",
    desc = "MAKE THEM BURN"
};

SWEP.Primary.ClipSize = 1
SWEP.Primary.Delay = 0.1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.Delay = 0.5
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

-- function SWEP:Initialize()
	-- self:SetWeaponHoldType( self.HoldType )
-- end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	if (self.Owner:IsNPC()) then
		self:EmitSound( "weapons/dubstgun/dub" .. math.random( 1, 2 ) .. ".wav", 100, math.random( 60, 80 ) )
	else
		if ( self.LoopSound ) then
			self.LoopSound:ChangeVolume( 1, 0.1 )
		else
			self.LoopSound = CreateSound( self.Owner, Sound( "weapons/dubstgun/dub_loop.wav" ) )
			if ( self.LoopSound ) then self.LoopSound:Play() end
		end
		if ( self.BeatSound ) then self.BeatSound:ChangeVolume( 0, 0.1 ) end
	end

	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( 0.01, 0.01, 0 )
	bullet.Tracer = 1
	bullet.Force = 5
	bullet.Damage = 25
	bullet.TracerName = "dubstgun_tracer"
	self.Owner:FireBullets( bullet )

	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end

function SWEP:SecondaryAttack()
	if ( !self:CanSecondaryAttack() ) then return end
	self:EmitSound( "weapons/dubstgun/dub" .. math.random( 1, 2 ) .. ".wav", 100, math.random( 85, 100 ) )

	local bullet = {}
	bullet.Num = 6
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( 0.10, 0.1, 0 )
	bullet.Tracer = 1
	bullet.Force = 10
	bullet.Damage = 15
	bullet.TracerName = "dubstgun_tracer"
	self.Owner:FireBullets( bullet )

	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self:SetNextPrimaryFire( CurTime() + self.Secondary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 
end

function SWEP:Reload()
	if ( !self.Owner:KeyPressed( IN_RELOAD ) ) then return end
	if ( self:GetNextPrimaryFire() > CurTime() ) then return end

	if ( SERVER ) then
		local ang = self.Owner:EyeAngles()
		local ent = ents.Create( "ent_dubstgun_bomb" )
		if ( IsValid( ent ) ) then
			ent:SetPos( self.Owner:GetShootPos() + ang:Forward() * 28 + ang:Right() * 24 - ang:Up() * 8 )
			ent:SetAngles( ang )
			ent:SetOwner( self.Owner )
			ent:Spawn()
			ent:Activate()
			
			local phys = ent:GetPhysicsObject()
			if ( IsValid( phys ) ) then phys:Wake() phys:AddVelocity( ent:GetForward() * 1337 ) end
		end
	end
	
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self:EmitSound( "weapons/dubstgun/dub" .. math.random( 1, 2 ) .. ".wav", 100, math.random( 60, 80 ) )
	
	self:SetNextPrimaryFire( CurTime() + 1 )
	self:SetNextSecondaryFire( CurTime() + 1 ) 
end

function SWEP:DoImpactEffect( trace, damageType )
	local effectdata = EffectData()
	effectdata:SetStart( trace.HitPos )
	effectdata:SetOrigin( trace.HitNormal + Vector( math.Rand( -0.5, 0.5 ), math.Rand( -0.5, 0.5 ), math.Rand( -0.5, 0.5 ) ) )
	util.Effect( "dubstgun_bounce", effectdata )

	return true
end

function SWEP:FireAnimationEvent( pos, ang, event )
	return true
end

function SWEP:KillSounds()
	if ( self.BeatSound ) then self.BeatSound:Stop() self.BeatSound = nil end
	if ( self.LoopSound ) then self.LoopSound:Stop() self.LoopSound = nil end
end

function SWEP:OnRemove()
	self:KillSounds()
end

function SWEP:OnDrop()
	self:KillSounds()
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )

	if ( CLIENT ) then return true end

	self.BeatSound = CreateSound( self.Owner, Sound( "weapons/dubstgun/dub_drop.wav" ) )
	if ( self.BeatSound ) then self.BeatSound:Play() end

	return true
end

function SWEP:Holster()
	self:KillSounds()
	return true
end

function SWEP:Think()
	if ( self.Owner:IsPlayer() && self.Owner:KeyReleased( IN_ATTACK ) ) then
		if ( self.LoopSound ) then self.LoopSound:ChangeVolume( 0, 0.1 ) end
		if ( self.BeatSound ) then self.BeatSound:ChangeVolume( 1, 0.1 ) end
	end
end
