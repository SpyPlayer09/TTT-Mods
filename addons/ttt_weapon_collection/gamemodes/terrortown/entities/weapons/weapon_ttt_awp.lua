AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Silenced AWP"
    SWEP.Slot = 6
    SWEP.Icon = "vgui/ttt/icon_awp"
    SWEP.IconLetter = "r"
end

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 2
SWEP.Primary.Recoil = 10
SWEP.Primary.Cone = 0.001
SWEP.Primary.Damage = 500
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Sound = Sound("Weapon_M4A1.Silenced")
SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.ViewModel = Model("models/weapons/cstrike/c_snip_awp.mdl")
SWEP.WorldModel = Model("models/weapons/w_snip_awp.mdl")

SWEP.IronSightsPos = Vector(5, -15, -2)
SWEP.IronSightsAng = Vector(2.6, 1.37, 3.5)

SWEP.Kind = WEAPON_EQUIP1
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "none"
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.InLoadoutFor = {nil}
SWEP.LimitedStock = true
SWEP.AllowDrop = true
SWEP.IsSilent = true
SWEP.NoSights = false

function SWEP:SetZoom(state)
    if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
        if state then
            self:GetOwner():SetFOV(20, 0.3)
        else
            self:GetOwner():SetFOV(0, 0.2)
        end
    end
end

function SWEP:PrimaryAttack(worldsnd)
    self.BaseClass.PrimaryAttack(self.Weapon, worldsnd)
    self:SetNextSecondaryFire(CurTime() + 0.1)
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
    if not self.IronSightsPos then return end
    if self:GetNextSecondaryFire() > CurTime() then return end
    
    local bIronsights = not self:GetIronsights()
    
    self:SetIronsights(bIronsights)
    
    self:SetZoom(bIronsights)
    
    if (CLIENT) then
        self:EmitSound(self.Secondary.Sound)
    end
    
    self:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:PreDrop()
    self:SetZoom(false)
    self:SetIronsights(false)
    return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
    if (self:Clip1() == self.Primary.ClipSize or self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 0) then return end
    self:DefaultReload(ACT_VM_RELOAD)
    self:SetIronsights(false)
    self:SetZoom(false)
end

function SWEP:Holster()
    self:SetIronsights(false)
    self:SetZoom(false)
    return true
end

if CLIENT then
    local scope = surface.GetTextureID("sprites/scope")
    function SWEP:DrawHUD()
        if self:GetIronsights() then
            surface.SetDrawColor(0, 0, 0, 255)
            
            local scrW = ScrW()
            local scrH = ScrH()
            
            local x = scrW / 2.0
            local y = scrH / 2.0
            local scope_size = scrH
            
            -- Crosshair
            local gap = 80
            local length = scope_size
            surface.DrawLine(x - length, y, x - gap, y)
            surface.DrawLine(x + length, y, x + gap, y)
            surface.DrawLine(x, y - length, x, y - gap)
            surface.DrawLine(x, y + length, x, y + gap)
            
            gap = 0
            length = 50
            surface.DrawLine(x - length, y, x - gap, y)
            surface.DrawLine(x + length, y, x + gap, y)
            surface.DrawLine(x, y - length, x, y - gap)
            surface.DrawLine(x, y + length, x, y + gap)
            
            -- Cover edges
            local sh = scope_size / 2
            local w = (x - sh) + 2
            surface.DrawRect(0, 0, w, scope_size)
            surface.DrawRect(x + sh - 2, 0, w, scope_size)
            
            -- Cover gaps on top and bottom of screen
            surface.DrawLine(0, 0, scrW, 0)
            surface.DrawLine(0, scrH - 1, scrW, scrH - 1)
            
            surface.SetDrawColor(255, 0, 0, 255)
            surface.DrawLine(x, y, x + 1, y + 1)
            
            -- Scope
            surface.SetTexture(scope)
            surface.SetDrawColor(255, 255, 255, 255)
            
            surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)
        else
            return self.BaseClass.DrawHUD(self)
        end
    end
    
    function SWEP:AdjustMouseSensitivity()
        return (self:GetIronsights() and 0.2) or nil
    end
end

if CLIENT then
    SWEP.EquipMenuData = {
        type = "Weapon",
        desc = "Silenced AWP Sniper Rifle.\n\nOnly has one shot.\n\nVictims will not scream when killed."
    }
end
