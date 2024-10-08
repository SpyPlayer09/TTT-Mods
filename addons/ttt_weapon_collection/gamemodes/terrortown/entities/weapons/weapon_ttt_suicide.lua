AddCSLuaFile()

SWEP.CanBuy = {} --Removed
if CLIENT then
    SWEP.PrintName = "Suicide Bomb"
    SWEP.Slot = 6
    SWEP.Icon = "vgui/ttt/icon_c4"
    SWEP.IconLetter = "I"
end

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "slam"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 5
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = Model("models/weapons/cstrike/c_c4.mdl")
SWEP.WorldModel = Model("models/weapons/w_c4.mdl")

SWEP.Kind = WEAPON_EQUIP1
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "none"
SWEP.InLoadoutFor = {nil}
SWEP.LimitedStock = true
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = true

function SWEP:Precache()
    util.PrecacheSound("siege/big_explosion.wav")
    util.PrecacheSound("siege/suicide.wav")
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 2)
    
    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetOwner():GetPos())
    effectdata:SetNormal(self:GetOwner():GetPos())
    effectdata:SetMagnitude(8)
    effectdata:SetScale(1)
    effectdata:SetRadius(78)
    util.Effect("Sparks", effectdata)
    self.BaseClass.ShootEffects(self)
    
    if (SERVER) then
        timer.Simple(2, function() self:Explode() end)
        self:GetOwner():EmitSound("siege/suicide.wav")
    end
end

function SWEP:Explode()
    local k, v
    
    local ent = ents.Create("env_explosion")
    ent:SetPos(self:GetOwner():GetPos())
    ent:SetOwner(self:GetOwner())
    ent:SetKeyValue("iMagnitude", "200")
    ent:Spawn()
    ent:Fire("Explode", 0, 0)
    ent:EmitSound("siege/big_explosion.wav", 140)
    self:Remove()
end

if CLIENT then
    SWEP.EquipMenuData = {
        type = "Weapon",
        desc = "Go out in a screaming frenzy!\n\nKills user and surrounding terrorists."
    }
end
