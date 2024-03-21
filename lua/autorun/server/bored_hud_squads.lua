
if !game.SinglePlayer() then return end

util.AddNetworkString("BoHU_SquadInfo")
util.AddNetworkString("BoHU_KF_Kill")

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

local kf_lastheadshottime = 0

local function kfkill(ent, inflictor, attacker)
	net.Start("BoHU_KF_Kill")
    net.WriteEntity(attacker)
    net.WriteString(ent:IsPlayer() and ent:Name() or ent:GetClass())
    net.WriteBool(kf_lastheadshottime == CurTime())
    net.WriteString((inflictor and inflictor != attacker) and (inflictor.PrintName and inflictor.PrintName or inflictor:GetClass()) or "") -- it wont exist on client when net will arrive
    net.WriteUInt(ent:IsPlayer() and ent:Team() or 255, 8)
    net.WriteBool(ent==inflictor)
    net.Broadcast()
end

hook.Add("PlayerDeath", "BoHUPlayerDeath", function(ent, inflictor, attacker)
	kfkill(ent, inflictor, attacker)
end)
hook.Add("OnNPCKilled", "BoHU_OnNPCKilled", function(ent, attacker, inflictor)
	kfkill(ent, inflictor, attacker)
end)

hook.Add("ScalePlayerDamage", "BoHU_ScalePlayerDamage", function(ply, hitgroup, dmginfo)
	if hitgroup == HITGROUP_HEAD then kf_lastheadshottime = CurTime() end
end)
hook.Add("ScaleNPCDamage", "BoHU_ScaleNPCDamage", function(npc, hitgroup, dmginfo)
	if hitgroup == HITGROUP_HEAD then kf_lastheadshottime = CurTime() end
end)