if SERVER then
	AddCSLuaFile ("shared.lua")
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
elseif CLIENT then
	SWEP.PrintName = "SSP Toolgun"
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end
SWEP.Author = "Wasabi_Thumbs"
SWEP.Contact = "wasabithumbs@gmail.com"
SWEP.Purpose = "Releives some of the stress of console commands."
SWEP.Instructions = "Click to set spawn point, reload to clear points."
SWEP.Category = "World Vector Tools"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"

function SWEP:PrimaryAttack()
  if CLIENT then
    LocalPlayer():ConCommand("ssp_add")
  end
end

function SWEP:Reload()
  if CLIENT then
    LocalPlayer():ConCommand("ssp_clear")
  end
end
