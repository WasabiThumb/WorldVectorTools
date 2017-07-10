AddCSLuaFile("lua/autorun/client/wvt/ss.lua")

local spawnerCount = 0;

local function addSpawner( ent, interval, pos )
  local iden = ( "ss_itval" .. tostring(spawnerCount) )
  spawnerCount = spawnerCount + 1
  timer.Create( iden, interval, 0, function()
  local ent = ents.Create(ent)
  ent:SetPos(pos)
  ent:Spawn()
  end )
end

local function clearSpawners()
  for i=0,spawnerCount,1
  do
    timer.Remove( "ss_itval" .. tostring(i) )
  end
end


util.AddNetworkString( "ss_add" )
util.AddNetworkString( "ss_clear" )

net.Receive( "ss_add", function( len, ply )
if !ply:IsSuperAdmin() then return end
addSpawner( net.ReadString(), net.ReadInt(), net.ReadVector() )
end )

net.Receive( "ss_clear", function( len, ply )
if !ply:IsSuperAdmin() then return end
clearSpawners()
end )
