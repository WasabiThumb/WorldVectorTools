AddCSLuaFile("lua/autorun/client/wvt/ssp.lua")
local fName = ("ssp_data/" .. game.GetMap() .. "_ssp.txt")

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
if file.Exists( fName ) then file.Delete( fName ) end
end

hook.Add( "PlayerSpawn", "ssp_redirector", function()
if file.Exists( fName, "DATA" ) then
local ftable = util.JSONToTable( file.Read( fName ) )
ply:SetPos( table.Random( ftable ) )
end
end )

util.AddNetworkString( "ssp_add" )
util.AddNetworkString( "ssp_clear" )

net.Receive( "ssp_add", function( len, ply )
if !ply:IsSuperAdmin() then return end
addSpawnPoint( net.ReadVector() )
end )

net.Receive( "ssp_clear", function( len, ply )
if !ply:IsSuperAdmin() then return end
clearSpawnPoints()
end )
