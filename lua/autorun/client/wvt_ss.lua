-- ss_add <entity> <interval>
concommand.Add( "ss_add", function(ply, cmd, args)
if !isstring( args[1] ) or !isnumber( args[2] ) then print("Invalid Parameters!") return end
net.Start( "ss_add" )
net.WriteString( args[1] )
net.WriteInt( args[2] )
net.WriteVector( ply:GetPos() + Vector( 0, 20, 0 ) )
net.SendToServer()
end, nil, "ss_add <entity> <interval in seconds> | For an entity list, visit https://developer.valvesoftware.com/wiki/List_of_HL2_entities" )

concommand.Add( "ss_clear", function()
net.Start( "ss_clear" )
net.SendToServer()
end, nil, "ss_clear" )
