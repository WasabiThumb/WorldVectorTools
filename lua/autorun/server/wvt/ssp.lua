AddCSLuaFile("lua/autorun/client/wvt/ssp.lua")
local fName = ("ssp_data/" .. game.GetMap() .. "_ssp.txt")
local cspName = ("ssp_data/" .. game.GetMap() .. "_ssp_type.txt")

local function addSpawnPoint( vec )
local cont = { vec }
if file.Exists( fName, "DATA" ) then
local ftable = util.JSONToTable( file.Read( fName ) )
cont = table.Add(ftable, cont)
else if !file.Exists( "ssp_data", "DATA" ) then
file.CreateDir("ssp_data")
end
local cJSON = util.TableToJSON( cont )
file.Write( fName, cJSON )
end

local function clearSpawnPoints()
if file.Exists( fName, "DATA" ) then file.Delete( fName ) end
end
  
local function customiseSpawn( stype )
   if isValidType( stype ) then
      if !( file.Exists( "ssp_data", "DATA" ) ) then file.CreateDir("ssp_data") end
      file.Write( cspName, stype )
   end
end

local function isValidType( stype )
    if (stype == "ulaunch") then
      return true
    else if (stype == "flaunch") then
      return true
    else
      return false
     end
end

hook.Add( "PlayerSpawn", "ssp_redirector", function()
if file.Exists( fName, "DATA" ) then
local ftable = util.JSONToTable( file.Read( fName ) )
ply:SetPos( table.Random( ftable ) )
end
if file.Exists( cspName, "DATA" ) then
          local csp = file.Read( cspName )
          if ( csp == "ulaunch" ) then ply:SetVelocity( Vector( 0, 0, 200 ) ) 
          else if ( csp == "flaunch" ) then ply:SetVelocity( self.Owner:GetForward() * 200 + Vector( 0, 0, 200 ) )
          end
end
end )

util.AddNetworkString( "ssp_add" )
util.AddNetworkString( "ssp_clear" )
util.AddNetworkString( "ssp_set_type" )

net.Receive( "ssp_add", function( len, ply )
if !ply:IsSuperAdmin() then return end
addSpawnPoint( net.ReadVector() )
end )

net.Receive( "ssp_clear", function( len, ply )
if !ply:IsSuperAdmin() then return end
clearSpawnPoints()
end )
      
net.Receive( "ssp_set_type", function( len, ply )
file.Write( cspName, net.ReadString() )
end )
