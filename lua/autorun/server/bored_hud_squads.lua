
if !game.SinglePlayer() then return end

util.AddNetworkString("BoHU_SquadInfo")

local sinfo = sinfo or {}

local function SendSquadInfo( dnc )
    local csinfo = ai.GetSquadMembers( "player_squad" )
    if !csinfo then return end
    
    if dnc or (table.ToString(csinfo) != table.ToString(sinfo)) then -- LOL
        net.Start("BoHU_SquadInfo")
            net.WriteTable(csinfo)
        net.Broadcast()
        sinfo = csinfo
    end
end
net.Receive("BoHU_SquadInfo", function() SendSquadInfo(true) end)
hook.Add("Think", "BoHU_SquadInfo", function() SendSquadInfo(false) end)