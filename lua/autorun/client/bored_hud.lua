
CreateClientConVar("boredhud_enable",				1, true, false, "Draw the HUD?")
CreateClientConVar("boredhud_enable_health",		1, true, false, "Draw HUD health?")
CreateClientConVar("boredhud_enable_ammo",			1, true, false, "Draw HUD ammo")
CreateClientConVar("boredhud_enable_suit",			1, true, false, "Draw HUD suit functions")
CreateClientConVar("boredhud_enable_rangefinder",	0, true, false, "Draw HUD rangefinder?")
CreateClientConVar("boredhud_enable_squads",		0, true, false, "Draw HUD citizen squads?")
CreateClientConVar("boredhud_enable_ammo_trivia",	0, true, false, "Use ArcCW ammo trivia for the ammotype?")
CreateClientConVar("boredhud_enable_killfeed",	0, true, false, "Draw HUD Killfeed?")
CreateClientConVar("boredhud_killfeed_invert",	0, true, false, "Killfeed on other side of HUD??????? will conflict with rangefindre")
CreateClientConVar("boredhud_3dementia",	0, true, false, "owo")

CreateClientConVar("boredhud_scale",			1, true, false, "HUD scale")
CreateClientConVar("boredhud_deadx",			1, true, false, "Deadzone x")
CreateClientConVar("boredhud_deady",			1, true, false, "Deadzone y")
CreateClientConVar("boredhud_font",				"", true, false, "HUD font")
CreateClientConVar("boredhud_font_scanlines",	0, true, false, "HUD font scanlines")
CreateClientConVar("boredhud_font_weight",		0, true, false, "HUD font weight")

-- not reinstalling jmod to debug it abdumiliah
-- CreateClientConVar("boredhud_jmod",				1, true, false, "Show JMOD equipment")
-- CreateClientConVar("boredhud_jmod_intensity",	0.8, true, false, "JMOD armor intensity")
-- CreateClientConVar("boredhud_jmod_scale",		1, true, false, "JMOD armor scale")

CreateClientConVar("boredhud_main_r",	"255", true, false, "Main color, Red",		0, 255)
CreateClientConVar("boredhud_main_g",	"255", true, false, "Main color, Green",	0, 255)
CreateClientConVar("boredhud_main_b",	"255", true, false, "Main color, Blue",		0, 255)
-------------
CreateClientConVar("boredhud_main_a",	"255", true, false, "Main color, Alpha",	0, 255)

CreateClientConVar("boredhud_shadow_r",	"0", true, false, "Shadow color, Red",		0, 255)
CreateClientConVar("boredhud_shadow_g",	"0", true, false, "Shadow color, Green",	0, 255)
CreateClientConVar("boredhud_shadow_b",	"0", true, false, "Shadow color, Blue",		0, 255)
-------------
CreateClientConVar("boredhud_shadow_a",	"127", true, false, "Shadow color, Alpha",	0, 255)


concommand.Add("boredhud_reset", function()
	GetConVar("boredhud_enable"):Revert()
	GetConVar("boredhud_enable_health"):Revert()
	GetConVar("boredhud_enable_ammo"):Revert()
	GetConVar("boredhud_enable_suit"):Revert()
	GetConVar("boredhud_enable_rangefinder"):Revert()
	GetConVar("boredhud_enable_squads"):Revert()
	GetConVar("boredhud_enable_ammo_trivia"):Revert()
	GetConVar("boredhud_enable_killfeed"):Revert()
	GetConVar("boredhud_killfeed_invert"):Revert()
	GetConVar("boredhud_3dementia"):Revert()

	GetConVar("boredhud_scale"):Revert()
	GetConVar("boredhud_deadx"):Revert()
	GetConVar("boredhud_deady"):Revert()

	GetConVar("boredhud_font"):Revert()
	GetConVar("boredhud_font_scanlines"):Revert()
	GetConVar("boredhud_font_weight"):Revert()

	-- GetConVar("boredhud_jmod"):Revert()
	-- GetConVar("boredhud_jmod_intensity"):Revert()
	-- GetConVar("boredhud_jmod_scale"):Revert()

	GetConVar("boredhud_main_r"):Revert()
	GetConVar("boredhud_main_g"):Revert()
	GetConVar("boredhud_main_b"):Revert()
	GetConVar("boredhud_main_a"):Revert()

	GetConVar("boredhud_shadow_r"):Revert()
	GetConVar("boredhud_shadow_g"):Revert()
	GetConVar("boredhud_shadow_b"):Revert()
	GetConVar("boredhud_shadow_a"):Revert()
end, nil, "Reset all Bored HUD options to pure default.")

local function sm(v)
	return v * ( ScrW() / 640.0 ) * GetConVar("boredhud_scale"):GetFloat()
end
-- local function sm_j(v)
-- 	return v * ( ScrW() / 640.0 ) * GetConVar("boredhud_scale"):GetFloat() * GetConVar("boredhud_jmod_scale"):GetFloat()
-- end

-- stolen from arccw
local sizes_to_make = {
	5,
	6,
	8,
	10,
	12,
	16,
	20,
	26
}

local function GetFont()
	local font = "Bahnschrift"

	if GetConVar("boredhud_font"):GetString() != "" then
		font = GetConVar("boredhud_font"):GetString()
	end

	return font
end

local function generatefonts()
	for _, i in pairs(sizes_to_make) do
		surface.CreateFont( "BoHU_" .. tostring(i), {
			font = GetFont(),
			size = ScreenScale(i) * GetConVar("boredhud_scale"):GetFloat() * 0.8,  -- fuck i made this at 80% scale in arccw
			weight = GetConVar("boredhud_font_weight"):GetFloat(),
			scanlines = GetConVar("boredhud_font_scanlines"):GetFloat(),
			antialias = true,
			extended = true,
		} )
	end

	surface.CreateFont( "BoHU_kf_cssfont", { -- blehhh
		font = "csd",
		size = ScreenScale(16) * GetConVar("boredhud_scale"):GetFloat() * 0.8,
		weight = 0,
		scanlines = GetConVar("boredhud_font_scanlines"):GetFloat(),
		antialiasing = true,
	} )
end
generatefonts()
hook.Add("OnScreenSizeChanged", "RebuildBoHUFonts", generatefonts)
cvars.AddChangeCallback("boredhud_scale", function()
	generatefonts()
end)
cvars.AddChangeCallback("boredhud_font", function()
	generatefonts()
end)
cvars.AddChangeCallback("boredhud_font_scanlines", function()
	generatefonts()
end)
cvars.AddChangeCallback("boredhud_font_weight", function()
	generatefonts()
end)

local bohuPanel = {
	{ type = "h", text = "Bored HUD options. Change the size, the font, the colours, whatever." },
	{ type = "b", text = "Enable HUD", var = "boredhud_enable", },
	{ type = "b", text = "Enable 3 D (real)", var = "boredhud_3dementia", },
	{ type = "b", text = "Health", var = "boredhud_enable_health", },
	{ type = "b", text = "Ammo", var = "boredhud_enable_ammo", },
	{ type = "b", text = "Suit", var = "boredhud_enable_suit", },
	{ type = "b", text = "Rangefinder", var = "boredhud_enable_rangefinder", },
	{ type = "b", text = "HL2 Squads", var = "boredhud_enable_squads", },
	{ type = "b", text = "Use Trivia for Ammotype (for Tasky)", var = "boredhud_enable_ammo_trivia", },
	{ type = "b", text = "Enable killfeed", var = "boredhud_enable_killfeed", },
	{ type = "b", text = "Killfeed on right", var = "boredhud_killfeed_invert", },
	{ type = "f", text = "HUD Scale", var = "boredhud_scale", min = 0.5, max = 2.5 },
	{ type = "f", text = "Deadzone X", var = "boredhud_deadx", min = 0.5, max = 1 },
	{ type = "f", text = "Deadzone Y", var = "boredhud_deady", min = -0.75, max = 1 },
	{ type = "t", text = "HUD Font", var = "boredhud_font"  },
	{ type = "i", text = "HUD Font Scanlines", var = "boredhud_font_scanlines", min = 0, max = 10 },
	{ type = "i", text = "HUD Font Weight", var = "boredhud_font_weight", min = 0, max = 1000 },
	-- { type = "b", text = "Show JMod Equipment", var = "boredhud_jmod", },
	-- { type = "f", text = "JMod Armor Intensity", var = "boredhud_jmod_intensity", min = 0, max = 1 },
	-- { type = "f", text = "JMod Armor Scale", var = "boredhud_jmod_scale", min = 1, max = 2 },

	{ type = "m", text = "Main HUD Color", r = "boredhud_main_r", g = "boredhud_main_g", b = "boredhud_main_b", a = "boredhud_main_a"},
	{ type = "m", text = "Shadow HUD Color", r = "boredhud_shadow_r", g = "boredhud_shadow_g", b = "boredhud_shadow_b", a = "boredhud_shadow_a"},
	{ type = "p", text = "Reset all options to default", func = function() RunConsoleCommand("boredhud_reset") end },
}

hook.Add("PopulateToolMenu", "ArcCW_bohu_Options", function()
	spawnmenu.AddToolMenuOption("Options", "Bored HUD", "ArcCW_Options_bohu", "Options", "", "", function(panel)
		BoHU_yoinkthisshitfromArcCW(panel, bohuPanel)
	end)
end)

function BoHU_yoinkthisshitfromArcCW(panel, table)
	local AddControl = {
		["h"] = function(p, d) return p:Help(d.text) end,
		["c"] = function(p, d) return p:ControlHelp(d.text) end,
		["b"] = function(p, d) return p:CheckBox(d.text, d.var) end,
		["i"] = function(p, d) return p:NumSlider(d.text, d.var, d.min, d.max, 0) end,
		["f"] = function(p, d) return p:NumSlider(d.text, d.var, d.min, d.max, 2) end,
		["m"] = function(p, d) return p:AddControl("color", { Label = d.text, Red = d.r, Green = d.g, Blue = d.b, Alpha = d.a }) end, -- change this someday
		["p"] = function(p, d) local b = p:Button(d.text) b.DoClick = d.func return b end,
		["t"] = function(p, d) return p:TextEntry(d.text, d.var) end
	}

	local concommands = {
		["b"] = true,
		["i"] = true,
		["f"] = true,
		["m"] = true,
		["t"] = true,
	}

	for _, data in SortedPairs(table) do
		local p = AddControl[data.type](panel, data)
	end
end

BoHU = {}
BoHU_ColorWhite = Color(255, 255, 255, 255)
BoHU_ColorShadow = Color(0, 0, 0, 127)
local NA = "-"

function BoHU.OutlinedRect( x, y, w, h )
	local prev = surface.GetDrawColor()
	local x, y = math.ceil(x), math.ceil(y)
	if w == 0 or h == 0 then return end

	------ Draw shadow
		surface.SetDrawColor(BoHU_ColorShadow)
		surface.DrawOutlinedRect(x+2, y+2, w, h)
		surface.DrawOutlinedRect(x+1, y+1, w, h)

	surface.SetDrawColor(prev)
	surface.DrawOutlinedRect(x, y, w, h)


	surface.DrawOutlinedRect(x-1, y-1, w+2, h+2)
end

function BoHU.Rect( x, y, w, h )
	local prev = surface.GetDrawColor()
	local x, y = math.ceil(x), math.ceil(y)
	if w == 0 or h == 0 then return end

	------ Draw shadow
		surface.SetDrawColor(BoHU_ColorShadow)
		surface.DrawOutlinedRect(x+2, y+2, w, h)
		surface.DrawOutlinedRect(x+1, y+1, w, h)

	surface.SetDrawColor(prev)
	surface.DrawRect(x, y, w, h)
end

function BoHU.ProgressBar( p, po, x, y, w, h )
	local prev = surface.GetDrawColor()
	local x, y = math.ceil(x), math.ceil(y)
	if w == 0 or h == 0 then return end
	p = math.Clamp(p, 0, 1)

	------ Draw shadow
		surface.SetDrawColor(BoHU_ColorShadow)
		surface.DrawOutlinedRect(x+2, y+2, w, h)
		surface.DrawOutlinedRect(x+1, y+1, w, h)

	surface.SetDrawColor(prev)
	-- Outline
	surface.DrawOutlinedRect(x, y, w, h)
	surface.DrawOutlinedRect(x-1, y-1, w+2, h+2)

	if w*p == 0 or h*p == 0 then return end

	if po == 1 then
		x = x + (w*(1-p))
	end

	------ Draw shadow, again
		surface.SetDrawColor(BoHU_ColorShadow)
		surface.DrawOutlinedRect(x+2, y+2, w*p, h)
		surface.DrawOutlinedRect(x+1, y+1, w*p, h)

	surface.SetDrawColor(prev)
	-- Filled
	surface.DrawRect(x, y, w*p, h)
end

function BoHU.Text( textinfo, alignments, x, y )
	local prev = surface.GetTextColor()
	local text = tostring(textinfo)
	local distw, disth = surface.GetTextSize(textinfo)

	if alignments[1] == 1 then
		x = x - distw
	elseif alignments[1] == 2 then
		x = x - (distw / 2)
	end
	if alignments[2] == 1 then
		y = y - disth
	elseif alignments[2] == 2 then
		y = y - disth / 2
	end
		-- Draw shadow
		surface.SetTextColor(BoHU_ColorShadow)
		surface.SetTextPos(x+2, y+2)
		surface.DrawText(text)
		surface.SetTextPos(x+1, y+1)
		surface.DrawText(text)

	surface.SetTextColor(prev)
	surface.SetTextPos(x, y)
	surface.DrawText(text)
end

local arc9lookup = {
	[-1] = "AUTOMATIC",
	[0] = "NOTHING",
	[1] = "SEMI-AUTOMATIC",
}

function BoHU.GetHUDInfo()
	local P = LocalPlayer()
	local info = {}

	info.scrw	=	ScrW() * GetConVar("boredhud_deadx"):GetFloat()
	info.scrh	=	ScrH() * GetConVar("boredhud_deady"):GetFloat()

	info.scrw_g	=	(ScrW() - info.scrw) * 0.5
	info.scrh_g	=	(ScrH() - info.scrh) * 0.5


	info.hp_per	=	P:Health()/P:GetMaxHealth()
	info.hp_am	=	P:Health()
	info.ar_per	=	P:Armor()/P:GetMaxArmor()
	info.ar_am	=	P:Armor()

	BoHU_ColorWhite = Color(GetConVar("boredhud_main_r"):GetInt(),
		GetConVar("boredhud_main_g"):GetInt(),
		GetConVar("boredhud_main_b"):GetInt(),
		GetConVar("boredhud_main_a"):GetInt())
	BoHU_ColorShadow = Color(GetConVar("boredhud_shadow_r"):GetInt(),
		GetConVar("boredhud_shadow_g"):GetInt(),
		GetConVar("boredhud_shadow_b"):GetInt(),
		GetConVar("boredhud_shadow_a"):GetInt())

	info.wp_clip1 = NA
	info.wp_maxclip1 = NA
	info.wp_clipextra1 = NA
	info.wp_clip2 = NA
	info.wp_maxclip2 = NA
	info.wp_clipextra2 = NA
	info.wep_name = "None"
	info.wp_ammo1 = NA
	info.wp_ammo2 = NA
	info.wp_ammoname = NA
	info.wp_ammoname2 = NA
	info.wp_firemode = NA
	info.wp_firemode2 = NA
	info.wp_ubgl = false
	info.wp_alttext = "ALT" -- altfire title

	if P:GetActiveWeapon() and P:GetActiveWeapon():IsValid() then
		local PW = P:GetActiveWeapon() or NULL
		info.pw = PW
		if PW:Clip1() then
			info.wp_clip1 = PW:Clip1()
		end
		if PW:GetMaxClip1() > 0 then
			info.wp_maxclip1 = PW:GetMaxClip1()
		end
		if info.wp_clip1 != NA and info.wp_maxclip1 != NA and info.wp_clip1 > info.wp_maxclip1 then
			info.wp_clipextra1 = info.wp_clip1 - info.wp_maxclip1
		end
		if PW:Clip2() then
			info.wp_clip2 = PW:Clip2()
		end
		if PW:GetMaxClip2() > 0 then
			info.wp_maxclip2 = PW:GetMaxClip2()
		end
		if info.wp_clip2 != NA and info.wp_maxclip2 != NA and info.wp_clip2 > info.wp_maxclip2 then
			info.wp_clipextra2 = info.wp_clip2 - info.wp_maxclip2
		end
		if PW:GetPrintName() then
			info.wep_name = language.GetPhrase(PW:GetPrintName())
		end
		local ammotype = PW:GetPrimaryAmmoType()
		local ammotyp2 = PW:GetSecondaryAmmoType()

		if ammotype > -1 then
			info.wp_ammo1 = P:GetAmmoCount(ammotype) or 0
			info.wp_ammoname = language.GetPhrase((game.GetAmmoName(ammotype) or "") .. "_ammo")
		end
		if ammotyp2 > -1 then
			info.wp_ammo2 = P:GetAmmoCount(ammotyp2) or 0
			info.wp_ammoname2 = language.GetPhrase((game.GetAmmoName(ammotyp2) or "") .. "_ammo")
		end
		if info.wp_clip1 == -1 and info.wp_ammo1 != NA and info.wp_ammo1 > 0 then
			info.wp_clip1 = info.wp_ammo1
			info.wp_ammo1 = NA
		end
		if (PW.IsFAS2Weapon or PW.CW20Weapon) and (PW.FireModeDisplay ~= nil) then
			info.wp_firemode = PW.FireModeDisplay
		elseif PW.IsTFAWeapon then
			info.wp_firemode = PW:GetFireModeName()
		elseif PW.Suburb then
			info.wp_firemode = PW:GetFiremodeName()
		elseif PW.ArcCW then
			local HD = PW:GetHUDData()
			info.wp_firemode	= HD.mode
			info.wp_clip1		= HD.clip
			info.wp_ammo1		= P:GetAmmoCount(ammotype)
			if PW:HasInfiniteAmmo() then
				info.wp_ammo1		= "∞"
				if PW:HasBottomlessClip() then
					info.wp_ammo1		= NA
				end
			end
			if PW:HasBottomlessClip() then
				info.wp_ammo1		= NA
			end
			info.wp_maxclip1	= PW:GetCapacity()
			info.wp_clipextra1	= HD.plus
			--info.wp_clip2		= HD.ubgl
			if GetConVar("boredhud_enable_ammo_trivia"):GetBool() and (PW:GetBuff_Override("Override_Trivia_Calibre") or PW.Trivia_Calibre) then info.wp_ammoname = (PW:GetBuff_Override("Override_Trivia_Calibre") or PW.Trivia_Calibre) end
			do
				info.wp_ubgl		= PW:GetBuff_Override("UBGL")
				info.wp_clip2		= HD.clip2
				info.wp_ammo2		= HD.ammo2
				info.wp_firemode2	= PW:GetBuff_Override("UBGL_Automatic") and "Automatic" or "Semi-auto"
				--info.wp_ammoname = language.GetPhrase((game.GetAmmoName(ammotyp2) or "") .. "_ammo")
				--info.wp_maxclip1 = PW:GetBuff_Override("UBGL_Capacity") or 1
			end
		elseif PW.ARC9 then
			--info.wp_firemode	= "fuCk"
			local ubglamoo = PW:GetProcessedValue("UBGLAmmo", true)
			info.wp_clip1		= PW:Clip1()
			info.wp_ammo1		= P:GetAmmoCount(PW:GetPrimaryAmmoType())
			info.wp_maxclip1	= PW:GetValue("ClipSize")
			info.wp_clip2       = PW:Clip2()
			info.wp_ammo2		= P:GetAmmoCount(ubglamoo)
			info.wp_ubgl		= PW:GetProcessedValue("UBGL")
			info.wp_maxclip2	= PW:GetCapacity(true)

			-- wtf arctic
				-- what's your fuckin problem

			if GetConVar("boredhud_enable_ammo_trivia"):GetBool() then
				if PW:GetValue("EFTRoundName") then info.wp_ammoname = string.Replace(string.upper(PW:GetValue("EFTRoundName")), " GZH", "")
				elseif PW.Trivia.Calibre then info.wp_ammoname = PW.Trivia.Calibre
				elseif PW.Trivia.Caliber then info.wp_ammoname = PW.Trivia.Caliber
				elseif PW.Trivia.Calibre2 then info.wp_ammoname = PW.Trivia.Calibre2
				elseif PW.Trivia.Caliber3 then info.wp_ammoname = PW.Trivia.Caliber3
				end
			end
			
			if PW:GetUBGL() then info.wp_ammoname = language.GetPhrase((game.GetAmmoName(game.GetAmmoID(ubglamoo)) or "") .. "_ammo") end

			do
				local arc9_mode = PW:GetCurrentFiremodeTable()
				local firemode_text = NA

				--if PW:GetUBGL() then
				--	firemode_text = PW:GetProcessedValue("UBGLFiremodeName")
				--else
				if arc9_mode.PrintName then
					firemode_text = arc9_mode.PrintName
				elseif PW:GetSafe() then
					firemode_text = "SAFETY"
				else
					if arc9_mode.Mode == 1 then
						firemode_text = "SEMI-AUTO"
					elseif arc9_mode.Mode == 0 then
						firemode_text = "SAFETY"
					elseif arc9_mode.Mode < 0 then
						firemode_text = "AUTOMATIC"
					elseif arc9_mode.Mode > 1 then
						firemode_text = tostring(arc9_mode.Mode) .. "-ROUND BURST"
					end
				end
				if PW:GetUBGL() then firemode_text = PW:GetProcessedValue("UBGLFiremodeName", true) end
				info.wp_firemode		= firemode_text

				local firemode_text = NA
				arc9_mode = PW:GetProcessedValue("UBGLFiremode", true)
				if arc9_mode == 1 then
					firemode_text = "SEMI-AUTO"
				elseif arc9_mode == 0 then
					firemode_text = "SAFETY"
				elseif arc9_mode < 0 then
					firemode_text = "AUTOMATIC"
				elseif arc9_mode > 1 then
					firemode_text = tostring(arc9_mode.Mode) .. "-ROUND BURST"
				end
				info.wp_firemode2	= firemode_text or NA
			end

			if PW:GetInfiniteAmmo() then
				info.wp_ammo1		= "∞"
				info.wp_ammo2		= "∞"
			end
		elseif PW.GH3 then
			info.wp_ammo1		= PW:GetAmmo()
			info.wp_maxclip1	= PW.Stats["Magazines"]["Rounds Loaded Maximum"]
			if PW.Stats["Age"] then
				info.wp_clip2		= 100-math.Round(PW:GetAge()*100)
			end
		elseif PW.Primary and PW.Primary.RPM then
			local m9ksucks
			if PW.Primary.Burst then
				m9ksucks = "BURST"
			elseif PW.Primary.Automatic then
				m9ksucks = "AUTOMATIC"
			else
				m9ksucks = "SEMI-AUTO"
			end
			info.wp_firemode = m9ksucks
		elseif PW.ArcticTacRP then
			local mode = PW:GetCurrentFiremode()
			if PW:GetSafe() then
				info.wp_firemode = "SAFETY"
			elseif PW.FiremodeName and ((istable(PW.FiremodeName) and PW.FiremodeName[mode]) or isstring(PW.FiremodeName)) then
				info.wp_firemode = istable(PW.FiremodeName) and PW.FiremodeName[mode] or PW.FiremodeName
			elseif mode == 1 then
				info.wp_firemode = "SEMI-AUTO"
			elseif mode == 2 then
				info.wp_firemode = "AUTOMATIC"
			elseif mode < 1 then
				info.wp_firemode = tostring(math.abs(mode)) .. "-ROUND BURST"
			end

			if PW:GetInfiniteAmmo() then
				info.wp_ammo1 = "∞"
			end

			if PW:GetValue("CanQuickNade") then
				info.wp_ubgl		= false
				info.wp_ammo2		= NA
				info.wp_maxclip2	= 1

				local nade = PW:GetGrenade()

				info.wp_alttext		= nade.PrintName or "NADE"
				if nade.Ammo and !GetConVar("tacrp_infinitegrenades"):GetBool() then
					info.wp_clip2		= tostring(P:GetAmmoCount(nade.Ammo))
				else
					info.wp_clip2		= "∞"
				end

			end
		end

		-- i am hack
		if P:GetActiveWeapon():GetClass() == "weapon_physcannon" then
			info.wp_clip1 = NA
		--[[elseif P:GetActiveWeapon():GetClass() == "weapon_frag" then
			info.wp_clip1 = info.wp_ammo1
			info.wp_ammo1 = NA]]
		elseif P:GetActiveWeapon():GetClass() == "weapon_slam" then
			info.wp_clip1 = NA
			info.wp_ammo1 = NA
		elseif P:GetActiveWeapon():GetClass() == "weapon_bugbait" then
			info.wp_clip1 = NA
			info.wp_ammo1 = NA
		elseif P:GetActiveWeapon():GetClass() == "wep_jack_gmod_hands" then
			info.wp_clip1 = NA
			info.wp_ammo1 = NA
		elseif P:GetActiveWeapon():GetClass() == "weapon_empty_hands" then
			info.wp_clip1 = NA
			info.wp_ammo1 = NA
		end
	end

	local t = hook.Run("BoHU_GetHUDInfo", self, info)
	info = t and t.info or info

	return info
end

-- local function BoHU_JMOD_GetItemInSlot( armorTable, slot )
-- 	if !( armorTable and armorTable.items )then return nil end
-- 	for id, armorData in pairs( armorTable.items )do
-- 		local ArmorInfo = JMod.ArmorTable[armorData.name]
-- 		if ( ArmorInfo.slots[slot] )then
-- 			return id, armorData, ArmorInfo
-- 		end
-- 	end
-- 	return nil
-- end

local sinfo = sinfo or {}
if game.SinglePlayer() then
	net.Start("BoHU_SquadInfo")
	net.SendToServer()

	net.Receive("BoHU_SquadInfo", function()
		sinfo = net.ReadTable()
	end)
end

local ArmorResourceNiceNames = {
	chemicals = "Chemicals",
	power = "Electricity",
}

local pf = "hud/boredhud/murvivi/Pieces/"

-- local BoHU_JMOD_ArmorList = {
-- 	[241] = {
-- 		slot = "head",
-- 		tex = Material(pf.."Helmet"..".png", "mips smooth"),
-- 		x = 0,
-- 		y = -68,
-- 		weight = 1000,
-- 	},
-- 	[341] = {
-- 		slot = "eyes",
-- 		tex = Material(pf.."Eyes"..".png", "mips smooth"),
-- 		x = 0,
-- 		y = -57,
-- 		weight = 100,
-- 	},
-- 	[73] = {
-- 		slot = "mouthnose",
-- 		tex = Material(pf.."Mouth"..".png", "mips smooth"),
-- 		x = 0,
-- 		y = -52,
-- 		weight = 10,
-- 	},
-- 	[500] = {
-- 		slot = "ears",
-- 		x = 16,
-- 		y = -59,
-- 	},
-- 	[41] = {
-- 		slot = "leftshoulder",
-- 		tex = Material(pf.."Left Shoulder"..".png", "mips smooth"),
-- 		x = -20,
-- 		y = -34,
-- 	},
-- 	[31] = {
-- 		slot = "leftforearm",
-- 		tex = Material(pf.."Left Arm"..".png", "mips smooth"),
-- 		x = -28,
-- 		y = 0,
-- 	},
-- 	[21] = {
-- 		slot = "leftthigh",
-- 		tex = Material(pf.."Left Thigh"..".png", "mips smooth"),
-- 		x = -24,
-- 		y = 29,
-- 	},
-- 	[11] = {
-- 		slot = "leftcalf",
-- 		tex = Material(pf.."Left Leg"..".png", "mips smooth"),
-- 		x = -14,
-- 		y = 54,
-- 	},
-- 	--
-- 	[42] = {
-- 		slot = "rightshoulder",
-- 		tex = Material(pf.."Right Shoulder"..".png", "mips smooth"),
-- 		x = 20,
-- 		y = -34,
-- 	},
-- 	[32] = {
-- 		slot = "rightforearm",
-- 		tex = Material(pf.."Right Arm"..".png", "mips smooth"),
-- 		x = 28,
-- 		y = 0,
-- 	},
-- 	[22] = {
-- 		slot = "rightthigh",
-- 		tex = Material(pf.."Right Thigh"..".png", "mips smooth"),
-- 		x = 24,
-- 		y = 29,
-- 	},
-- 	[12] = {
-- 		slot = "rightcalf",
-- 		tex = Material(pf.."Right Leg"..".png", "mips smooth"),
-- 		x = 14,
-- 		y = 54,
-- 	},
-- 	[123] = {
-- 		slot = "chest",
-- 		tex = Material(pf.."Chest"..".png", "mips smooth"),
-- 		x = 0,
-- 		y = -17,
-- 	},
-- 	[2] = {
-- 		slot = "back",
-- 		x = 32,
-- 		y = -20,
-- 	},
-- 	[3] = {
-- 		slot = "pelvis",
-- 		tex = Material(pf.."Pelvis"..".png", "mips smooth"),
-- 		x = 2,
-- 		y = 14,
-- 	},
-- }

local bhkillfeed = {}

hook.Add( "HUDPaint", "BoHU_HUDShouldDraw", function()
	if !GetConVar("boredhud_enable"):GetBool() or !GetConVar("cl_drawhud"):GetBool() then return end
	local hi = BoHU.GetHUDInfo()
	local P = LocalPlayer()
	if !P:Alive() then return end
	local threedementia = GetConVar("boredhud_3dementia"):GetBool()
	-- Draw health
	if !threedementia and GetConVar("boredhud_enable_health"):GetBool() and hi.hp_per > 0 then
		surface.SetDrawColor(BoHU_ColorWhite)
		BoHU.ProgressBar(hi.hp_per, 0, hi.scrw_g + sm(16), hi.scrh_g + hi.scrh - sm(18), sm(100), sm(4))
		local s2remove = 0
		local s2extra = hi.hp_am - P:GetMaxHealth()
		if P:GetMaxHealth() < hi.hp_am then
			s2remove = s2extra
			surface.SetFont("BoHU_26")
			local FUCKYOU = surface.GetTextSize(hi.hp_am-s2remove)/2
			surface.SetFont("BoHU_10")
			surface.SetTextColor(BoHU_ColorWhite)
			BoHU.Text( s2extra, {0, 0}, hi.scrw_g + sm(28+1) + FUCKYOU, hi.scrh_g + hi.scrh - sm(29) )
			BoHU.Text( "+", {0, 0},     hi.scrw_g + sm(28+1) + FUCKYOU, hi.scrh_g + hi.scrh - sm(34) )
		end
		surface.SetTextColor(BoHU_ColorWhite)
		surface.SetFont("BoHU_26")
		BoHU.Text( hi.hp_am-s2remove, {2, 1}, hi.scrw_g + sm(28), hi.scrh_g + hi.scrh - sm(18) )

		surface.SetTextColor(BoHU_ColorWhite)
		surface.SetFont("BoHU_8")
		BoHU.Text("HEALTH", {2, 1}, hi.scrw_g + sm(28), hi.scrh_g + hi.scrh - sm(34) )

		local power = P:GetSuitPower()/100
		if GetConVar("boredhud_enable_suit"):GetBool() and power != 1 then
			surface.SetDrawColor(255, 255, 0, 255)
			BoHU.Rect(hi.scrw_g + sm(16) + 1, hi.scrh_g + hi.scrh - sm(18) + 1, sm(100*power) - 2, sm(1))
			local elements = ""
			if P:FlashlightIsOn() then
				elements = elements .. "FLASHLIGHT "
			end
			if P:IsSprinting() then
				elements = elements .. "SPRINTING "
			end
			if P:WaterLevel() == 3 then
				elements = elements .. "OXYGEN "
			end
			BoHU.Text(elements, {0, 1}, hi.scrw_g + sm(118), hi.scrh_g + hi.scrh - sm(13))
		end
	end

	-- Draw armor
	if !threedementia and GetConVar("boredhud_enable_health"):GetBool() and hi.ar_per > 0 then
		surface.SetDrawColor(BoHU_ColorWhite)
		BoHU.ProgressBar(hi.ar_per, 0, hi.scrw_g + sm(16), hi.scrh_g + hi.scrh - sm(12), sm(100), sm(3))

		local s2remove = 0
		local s2extra = hi.ar_am - P:GetMaxArmor()
		local as = sm(36)
		if P:GetMaxArmor() < hi.ar_am then
			s2remove = s2extra
			surface.SetFont("BoHU_20")
			local FUCKYOU = surface.GetTextSize(hi.ar_am-s2remove)/2
			surface.SetFont("BoHU_8")
			surface.SetTextColor(BoHU_ColorWhite)
			BoHU.Text( s2extra, {0, 0}, hi.scrw_g + sm(28) + as + FUCKYOU, hi.scrh_g + hi.scrh - sm(29) )
			BoHU.Text( "+", {0, 0},     hi.scrw_g + sm(28) + as + FUCKYOU, hi.scrh_g + hi.scrh - sm(34) )
		end
		surface.SetTextColor(BoHU_ColorWhite)
		surface.SetFont("BoHU_20")
		BoHU.Text( hi.ar_am-s2remove, {2, 1}, hi.scrw_g + sm(28) + as, hi.scrh_g + hi.scrh - sm(20) )

		surface.SetTextColor(BoHU_ColorWhite)
		surface.SetFont("BoHU_8")
		BoHU.Text("ARMOR", {2, 1}, hi.scrw_g + sm(28) + as, hi.scrh_g + hi.scrh - sm(32) )
	end

	local altgap = 1

	-- Draw ammo
	if !threedementia and GetConVar("boredhud_enable_ammo"):GetBool() and hi.wp_clip1 and hi.wp_clip1 != NA and ( !tonumber(hi.wp_clip1) and true or hi.wp_clip1 > -1 ) then
		surface.SetDrawColor(BoHU_ColorWhite)
		surface.SetTextColor(BoHU_ColorWhite)

		local cut
		if tonumber(hi.wp_clip1) and hi.wp_maxclip1 and hi.wp_maxclip1 != NA then
			cut = math.min(hi.wp_clip1/hi.wp_maxclip1,1)
		else
			cut = 1
		end
		BoHU.ProgressBar(cut, 1, hi.scrw_g + hi.scrw - sm(16+100), hi.scrh_g + hi.scrh - sm(18), sm(100), sm(4))
		if hi.wep_name and hi.wep_name != NA then
			surface.SetFont("BoHU_12")
			BoHU.Text(hi.wep_name, {2, 0}, hi.scrw_g + hi.scrw - sm(16+(100*0.5)), hi.scrh_g + hi.scrh - sm(13))
		end

		local HD
		if hi.pw then
			local PW = hi.pw
			if PW.ArcCW then
				HD = PW:GetHUDData()
			elseif PW.ARC9 then
				HD = {}
				HD.heat_enabled = PW:GetProcessedValue("Overheat")
				HD.heat_level = PW:GetHeatAmount()
				HD.heat_maxlevel = PW:GetProcessedValue("HeatCapacity")
			elseif PW.GH3 and PW.Stats["Heat"] then
				HD = {}
				HD.heat_enabled = PW.Stats["Heat"]
				HD.heat_level = PW:GetAccelHeat()
				HD.heat_maxlevel = PW.Stats["Heat"]["Overheated Threshold"]
			end

			if HD and HD.heat_enabled then
				local heat = math.Clamp( HD.heat_level/HD.heat_maxlevel, 0, 1 )

				surface.SetDrawColor(255, 0, 0, 255)
				BoHU.Rect(hi.scrw_g + hi.scrw - sm(100+16) + 1, hi.scrh_g + hi.scrh - sm(18) + 1, sm(100*heat) - 2, sm(1))
			end
		end

		if hi.wp_clip1 and hi.wp_clip1 != NA then
			if tonumber(hi.wp_clip1) then
				local s2remove = 0
				if hi.wp_clipextra1 and hi.wp_clipextra1 != NA then
					s2remove = (!hi.pw.ArcCW and hi.wp_clipextra1 or 0)
					surface.SetFont("BoHU_26")
					local FUCKYOU = surface.GetTextSize(hi.wp_clip1-s2remove)/2
					surface.SetFont("BoHU_10")
					BoHU.Text( hi.wp_clipextra1, {0, 0}, hi.scrw_g + hi.scrw - sm(28-1) + FUCKYOU, hi.scrh_g + hi.scrh - sm(29) )
					BoHU.Text( "+", {0, 0},              hi.scrw_g + hi.scrw - sm(28-1) + FUCKYOU, hi.scrh_g + hi.scrh - sm(34) )
				end
				surface.SetFont("BoHU_26")
				if hi.pw.isDualwield then
					BoHU.Text( hi.wp_clip1 .. "|" .. hi.wp_clip2, {2, 1}, hi.scrw_g + hi.scrw - sm(28), hi.scrh_g + hi.scrh - sm(18) )
				else
				BoHU.Text( hi.wp_clip1-s2remove, {2, 1}, hi.scrw_g + hi.scrw - sm(28), hi.scrh_g + hi.scrh - sm(18) )
				end

				surface.SetFont("BoHU_8")
				BoHU.Text("AMMO", {2, 1}, hi.scrw_g + hi.scrw - sm(28), hi.scrh_g + hi.scrh - sm(34) )
			else
				surface.SetFont("BoHU_26")
				BoHU.Text( hi.wp_clip1, {2, 1}, hi.scrw_g + hi.scrw - sm(28), hi.scrh_g + hi.scrh - sm(18) )

				surface.SetFont("BoHU_8")
				BoHU.Text("AMMO", {2, 1}, hi.scrw_g + hi.scrw - sm(28), hi.scrh_g + hi.scrh - sm(34) )
			end
		end

		if hi.wp_ammo1 and hi.wp_ammo1 != NA then
			local as = sm(36)
			surface.SetFont("BoHU_20")
			BoHU.Text( hi.wp_ammo1, {2, 1}, hi.scrw_g + hi.scrw - sm(28) - as, hi.scrh_g + hi.scrh - sm(20) )

			surface.SetFont("BoHU_8")
			BoHU.Text("RESERVE", {2, 1}, hi.scrw_g + hi.scrw - sm(28) - as, hi.scrh_g + hi.scrh - sm(32) )
		end

		local jump = 0
		if hi.wp_ammoname and hi.wp_ammoname != NA then
			local ammoname = hi.wp_ammoname
			if string.len(ammoname) > 14 then
				ammoname = string.Left(ammoname, 14 )..".."
			end
			surface.SetFont("BoHU_8")
			BoHU.Text(string.upper(ammoname), {2, 1}, hi.scrw_g + hi.scrw - sm(96), hi.scrh_g + hi.scrh - sm(22) )
			jump = jump + 6
		end
		if hi.wp_firemode and hi.wp_firemode != NA then
			surface.SetFont("BoHU_8")
			BoHU.Text(string.upper(hi.wp_firemode), {2, 1}, hi.scrw_g + hi.scrw - sm(96), hi.scrh_g + hi.scrh - sm(22 + jump) )
		end
		altgap = 4.75
	end

	-- Draw alt ammo
	if !threedementia and GetConVar("boredhud_enable_ammo"):GetBool() then
		if hi.pw and hi.wp_ubgl then
			local gaaaw = 0--sm(100+8)
			local gaaah = sm(38)
			local gaasc = 0.9

			surface.SetDrawColor(BoHU_ColorWhite)
			surface.SetTextColor(BoHU_ColorWhite)

			local cut
			if tonumber(hi.wp_clip2) and hi.wp_maxclip2 and hi.wp_maxclip2 != NA then
				cut = math.min(hi.wp_clip2 / hi.wp_maxclip2, 1)
			else
				cut = 1
			end
			BoHU.ProgressBar(cut, 1, hi.scrw_g + hi.scrw - sm(16+100) + sm(100*(1-gaasc)) - gaaaw, hi.scrh_g + hi.scrh - sm(18 - 6) - gaaah, sm(100*gaasc), sm(4))
			--do
			--	surface.SetFont("BoHU_12")
			--	BoHU.Text("Underbarrel", {2, 0}, hi.scrw_g + hi.scrw - sm(16+(100*0.5)*gaasc) - gaaaw, hi.scrh_g + hi.scrh - sm(13) - gaaah)
			--end

			if hi.wp_clip2 and hi.wp_clip2 != NA then
				if tonumber(hi.wp_clip2) then
					local s2remove = 0
					if hi.wp_clipextra2 and hi.wp_clipextra2 != NA then
						s2remove = (!hi.pw.ArcCW and hi.wp_clipextra2 or 0)
						surface.SetFont("BoHU_20")
						local FUCKYOU = surface.GetTextSize(hi.wp_clip2-s2remove)/2
						surface.SetFont("BoHU_8")
						BoHU.Text( hi.wp_clipextra2, {0, 0}, hi.scrw_g + hi.scrw - sm(28*gaasc) + FUCKYOU - gaaaw, hi.scrh_g + hi.scrh - sm(29 - 6) - gaaah )
						BoHU.Text( "+", {0, 0},              hi.scrw_g + hi.scrw - sm(28*gaasc) + FUCKYOU - gaaaw, hi.scrh_g + hi.scrh - sm(34 - 6) - gaaah )
					end
					surface.SetFont("BoHU_20")
					BoHU.Text( hi.wp_clip2-s2remove, {2, 1}, hi.scrw_g + hi.scrw - sm(28) - gaaaw, hi.scrh_g + hi.scrh - sm(20 - 6) - gaaah )

					surface.SetFont("BoHU_8")
					BoHU.Text("AMMO", {2, 1}, hi.scrw_g + hi.scrw - sm(28) - gaaaw, hi.scrh_g + hi.scrh - sm(32 - 6) - gaaah )
				else
					surface.SetFont("BoHU_20")
					BoHU.Text( hi.wp_clip2, {2, 1}, hi.scrw_g + hi.scrw - sm(28) - gaaaw, hi.scrh_g + hi.scrh - sm(20 - 6) - gaaah )

					surface.SetFont("BoHU_8")
					BoHU.Text("AMMO", {2, 1}, hi.scrw_g + hi.scrw - sm(28) - gaaaw, hi.scrh_g + hi.scrh - sm(32 - 6) - gaaah )
				end
			end

			if hi.wp_ammo2 and hi.wp_ammo2 != NA then
				local as = 36*(0.9)
				surface.SetFont("BoHU_16")
				BoHU.Text( hi.wp_ammo2, {2, 1}, hi.scrw_g + hi.scrw - sm((28+as)*gaasc) - gaaaw, hi.scrh_g + hi.scrh - sm(20+1 - 6) - gaaah )

				surface.SetFont("BoHU_8")
				BoHU.Text("RESERVE", {2, 1}, hi.scrw_g + hi.scrw - sm((28+as)*gaasc) - gaaaw, hi.scrh_g + hi.scrh - sm(32-1 - 6) - gaaah )
			end

			local jump = 0
			local ammoname = hi.wp_ammoname2
			if ammoname != NA then
				if string.len(ammoname) > 14 then
					ammoname = string.Left(ammoname, 14 )..".."
				end
				surface.SetFont("BoHU_8")
				BoHU.Text(string.upper(ammoname), {2, 1}, hi.scrw_g + hi.scrw - sm(96*gaasc) - gaaaw, hi.scrh_g + hi.scrh - sm(22 - 6) - gaaah )
				jump = jump + 6
			end
			if hi.wp_firemode2 and hi.wp_firemode2 != NA then
				surface.SetFont("BoHU_8")
				BoHU.Text(string.upper(hi.wp_firemode2), {2, 1}, hi.scrw_g + hi.scrw - sm(96*gaasc) - gaaaw, hi.scrh_g + hi.scrh - sm(22 - 6 + jump) - gaaah )
			end
		elseif hi.pw and !hi.pw.isDualwield then
			local hm = hi.wp_ammo2
			if hi.pw and hi.pw:IsValid() and hi.pw:IsScripted() then hm = hi.wp_clip2 end
			if hm and hm != NA and (!tonumber(hm) or tonumber(hm) >= 0) then
				surface.SetDrawColor(BoHU_ColorWhite)
				surface.SetTextColor(BoHU_ColorWhite)
				local perc = 0
				if tonumber(hm) != nil and isnumber(hi.wp_maxclip2) then
					perc = math.Clamp(tonumber(hm) / hi.wp_maxclip2, 0, 1)
				elseif !isnumber(hm) or tonumber(hm) > 0 then
					perc = 1
				end

				local gap = 20 + 20
				if altgap != 1 then
					gap = 20 + 125
				end
				BoHU.OutlinedRect(hi.scrw_g + hi.scrw - sm(gap), hi.scrh_g + hi.scrh - sm(18), sm(25), sm(4))
				BoHU.Rect(hi.scrw_g + hi.scrw - sm(gap) + sm(25*(1-perc)), hi.scrh_g + hi.scrh - sm(18), sm(25*perc), sm(4))


				surface.SetFont("BoHU_26")
				BoHU.Text(hm, {2, 1}, hi.scrw_g + hi.scrw - sm(gap - 25 / 2), hi.scrh_g + hi.scrh - sm(18) )

				surface.SetFont("BoHU_8")
				BoHU.Text(hi.wp_alttext, {2, 1}, hi.scrw_g + hi.scrw - sm(gap - 25 / 2), hi.scrh_g + hi.scrh - sm(34) )
			end
		end
	end

	-- Citizen panel
	if GetConVar("boredhud_enable_squads"):GetBool() and game.SinglePlayer() and sinfo then
		local xd = 13
		for i, v in ipairs(sinfo) do
			if !v:IsValid() then return end
			local durability = math.Round((v:Health()/v:GetMaxHealth()*100), 0) .. "%"
			local item = "#" .. v:GetClass()

			surface.SetDrawColor(BoHU_ColorWhite)
			surface.SetTextColor(BoHU_ColorWhite)

			surface.SetFont("BoHU_8")
			BoHU.Text(item, {0, 1}, hi.scrw_g + sm(16), hi.scrh_g + sm(6) + sm(xd))

			surface.SetFont("BoHU_8")
			BoHU.Text(durability, {0, 1}, hi.scrw_g + sm(64 + 16 + 2), hi.scrh_g + sm(11) + sm(xd))

			BoHU.ProgressBar(v:Health()/v:GetMaxHealth(), 0, hi.scrw_g + sm(16), hi.scrh_g + sm(7) + sm(xd), sm(64), sm(2))
			xd = xd + 13
		end
	end

	-- ArcCW info panel
	if false and hi.pw and hi.pw.ArcCW then
		surface.SetDrawColor(BoHU_ColorWhite)
		surface.SetTextColor(BoHU_ColorWhite)

		surface.SetFont("BoHU_12")
		BoHU.Text(hi.pw:GetPrintName(), {0, 1}, hi.scrw_g + sm(16), hi.scrh_g + sm(12))

		local xd = 0
		for i, v in ipairs(hi.pw.Attachments) do
			if !v.Installed then continue end
			surface.SetFont("BoHU_8")
			BoHU.Text(" - " .. v.PrintName, {0, 1}, hi.scrw_g + sm(16), hi.scrh_g + sm(18) + sm(xd*14))
			surface.SetFont("BoHU_10")
			BoHU.Text(ArcCW.AttachmentTable[v.Installed].PrintName, {0, 1}, hi.scrw_g + sm(24), hi.scrh_g + sm(25) + sm(xd*14))
			xd = xd + 1
		end

	end

	-- Rangefinder
	if GetConVar("boredhud_enable_rangefinder"):GetBool() then
		surface.SetDrawColor(BoHU_ColorWhite)
		surface.SetTextColor(BoHU_ColorWhite)

		if hi.pw then--and hi.pw.ArcCW then
			surface.SetFont("BoHU_8")

			local dir = LocalPlayer():GetAimVector()
			local trace = {}
			trace.start = LocalPlayer():EyePos()
			trace.endpos = trace.start + ( dir * ( 4096 * 8 * 8 ) )
			trace.filter = LocalPlayer()

			local HOLYSHIT = 1
			local fug = 0
			local reay = util.TraceLine(trace)
			local supea = reay.StartPos:Distance(reay.HitPos)
			if hi.pw.ArcCW then
				BoHU.Text("Weapon effectiveness", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6))
				local wo1, wo2 = hi.pw:GetMinMaxRange()
				HOLYSHIT = math.Clamp(1-math.TimeFraction( wo1, wo2, supea * ArcCW.HUToM ), 0, 1)

				BoHU.Text( "Effective from " .. math.Round(wo1) .. " to " .. math.Round(wo2) .. " meters", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10))
				BoHU.Text( math.Round( hi.pw:GetDamage(supea*ArcCW.HUToM) ) .. " damage", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10+7))
				BoHU.Text(math.Round(HOLYSHIT*100) .. "%", {1, 1}, hi.scrw_g + hi.scrw - sm(64 + 16 + 2), hi.scrh_g + sm(11) + sm(13))
			elseif hi.pw.Suburb then
				BoHU.Text("Weapon effectiveness", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6))
				local wo1, wo2 = hi.pw.RangeNear, hi.pw.RangeFar
				HOLYSHIT = math.Clamp(1-math.TimeFraction( wo1, wo2, supea * Suburb.HUToM ), 0, 1)

				BoHU.Text( "Effective from " .. math.Round(wo1) .. " to " .. math.Round(wo2) .. " meters", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10))
				BoHU.Text( math.Round( Suburb.getdamagefromrange( hi.pw.DamageNear, hi.pw.DamageFar, hi.pw.RangeNear / Suburb.HUToM, hi.pw.RangeFar / Suburb.HUToM, supea ) ) .. " damage", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10+7))
				BoHU.Text(math.Round(HOLYSHIT*100) .. "%", {1, 1}, hi.scrw_g + hi.scrw - sm(64 + 16 + 2), hi.scrh_g + sm(11) + sm(13))
			elseif hi.pw.ARC9 then
				BoHU.Text("Weapon effectiveness", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6))
				local wo1, wo2 = hi.pw:GetProcessedValue("RangeMin"), hi.pw:GetProcessedValue("RangeMax")
				HOLYSHIT = math.Clamp(1-math.TimeFraction( wo1, wo2, supea * ARC9.HUToM ), 0, 1)

				BoHU.Text( "Effective from " .. math.Round(wo1*ARC9.HUToM) .. " to " .. math.Round(wo2*ARC9.HUToM) .. " meters", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10))
				BoHU.Text( math.Round( hi.pw:GetDamageAtRange(supea*ARC9.HUToM) ) .. " damage", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10+7))
				BoHU.Text(math.Round(HOLYSHIT*100) .. "%", {1, 1}, hi.scrw_g + hi.scrw - sm(64 + 16 + 2), hi.scrh_g + sm(11) + sm(13))
			elseif hi.pw.ArcticTacRP then
				BoHU.Text("Weapon effectiveness", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6))
				local wo1, wo2 = hi.pw:GetValue("Range_Min"), hi.pw:GetValue("Range_Max")
				HOLYSHIT = math.Clamp(1-math.TimeFraction( wo1, wo2, supea ), 0, 1)

				BoHU.Text( "Effective from " .. math.Round(wo1) .. " to " .. math.Round(wo2) .. " hU", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10))
				BoHU.Text( math.Round( hi.pw:GetDamageAtRange(supea, true) * hi.pw:GetValue("Num") ) .. " damage", {1, 1}, hi.scrw_g + hi.scrw - sm(0 + 16), hi.scrh_g + sm(13+7+10+7))
				BoHU.Text(math.Round(HOLYSHIT*100) .. "%", {1, 1}, hi.scrw_g + hi.scrw - sm(64 + 16 + 2), hi.scrh_g + sm(11) + sm(13))
			else
				BoHU.Text("Rangefinder", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6))
				fug = -14
			end

			BoHU.Text( "METERS", {2, 1}, hi.scrw_g + hi.scrw - sm(12 + 16), hi.scrh_g + sm(13+7+10+14+fug))
			surface.SetFont("BoHU_26")
			BoHU.Text( math.Round(supea * 0.0254), {2, 1}, hi.scrw_g + hi.scrw - sm(12 + 16), hi.scrh_g + sm(13+7+10+14+fug+16))

			surface.SetFont("BoHU_8")
			
			BoHU.Text( math.Round(supea) .. " hU", {2, 1}, hi.scrw_g + hi.scrw - sm(16 + 12), hi.scrh_g + sm(fug + 65))
			BoHU.Text( math.Round(supea * 0.0254 * 3.28084) .. " feet", {2, 1}, hi.scrw_g + hi.scrw - sm(16 + 12), hi.scrh_g + sm(fug + 65 + 6))

			BoHU.ProgressBar(HOLYSHIT, 1, hi.scrw_g + hi.scrw - sm(64+16), hi.scrh_g + sm(13+7), sm(64), sm(2))

			if false then--hi.pw.ArcCW then
					BoHU.Text("Speed", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6+64))
				BoHU.Text(math.Round(hi.pw:GetBuff("SpeedMult")*100) .. "%", {1, 1}, hi.scrw_g + hi.scrw - sm(48 + 16 + 2), hi.scrh_g + sm(11+64) + sm(13))
				BoHU.ProgressBar(hi.pw:GetBuff("SpeedMult"), 1, hi.scrw_g + hi.scrw - sm(48+16), hi.scrh_g + sm(13+7+64), sm(48), sm(2))

					BoHU.Text("Sighted speed", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6+64+12))
				BoHU.Text(math.Round(hi.pw:GetBuff("SightedSpeedMult")*100) .. "%", {1, 1}, hi.scrw_g + hi.scrw - sm(48 + 16 + 2), hi.scrh_g + sm(11+64+12) + sm(13))
				BoHU.ProgressBar(hi.pw:GetBuff("SightedSpeedMult"), 1, hi.scrw_g + hi.scrw - sm(48+16), hi.scrh_g + sm(13+7+64+12), sm(48), sm(2))

					BoHU.Text("Shooting speed", {1, 1}, hi.scrw_g + hi.scrw - sm(16), hi.scrh_g + sm(13+6+64+24))
				BoHU.Text(math.Round(hi.pw:GetBuff("ShootSpeedMult")*100) .. "%", {1, 1}, hi.scrw_g + hi.scrw - sm(48 + 16 + 2), hi.scrh_g + sm(11+64+24) + sm(13))
				BoHU.ProgressBar(hi.pw:GetBuff("ShootSpeedMult"), 1, hi.scrw_g + hi.scrw - sm(48+16), hi.scrh_g + sm(13+7+64+24), sm(48), sm(2))
			end

		end
	end

	-- Draw JMOD topleft tab
	if false then--if GetConVar("boredhud_jmod"):GetBool() and P.EZarmor and !table.IsEmpty(P.EZarmor.items) then
		surface.SetDrawColor(BoHU_ColorWhite)
		surface.SetTextColor(BoHU_ColorWhite)

		local loc = {
			x = sm_j(16-48),
			y = sm_j(12),
			w = sm_j(160),
			h = sm_j(160),
		}

		local texture = Material("hud/boredhud/murvivi/Blackman.png", "mips smooth")
		surface.SetMaterial(texture)

		surface.SetDrawColor(GetConVar("boredhud_shadow_r"):GetInt(),
		GetConVar("boredhud_shadow_g"):GetInt(),
		GetConVar("boredhud_shadow_b"):GetInt(),
		GetConVar("boredhud_shadow_a"):GetInt()*0.5)
		surface.DrawTexturedRect(loc.x, loc.y, loc.w, loc.h)

		local whatwearedrawing = {}
		local wwindex = 0

		--local xd = 8
		if false then--for i, v in SortedPairs(BoHU_JMOD_ArmorList, true) do
			local slot = v.slot
			local ItemID, ItemData, ItemInfo = BoHU_JMOD_GetItemInSlot( P.EZarmor, slot )
			if ItemID then
				-- Draw graphics, shadow
				local shit = math.Clamp(ItemData.dur/ItemInfo.dur, 0.5, 1)
				local fuck = math.Clamp(ItemData.dur/ItemInfo.dur, 0.25, 1)

				if v.tex then
					surface.SetMaterial(v.tex)
					surface.SetDrawColor(BoHU_ColorShadow)
					surface.DrawTexturedRect(loc.x+2, loc.y+2, loc.w, loc.h)

					-- Draw graphics, coloured
					local inten = GetConVar("boredhud_jmod_intensity"):GetFloat()

					surface.SetDrawColor(GetConVar("boredhud_main_r"):GetInt() *inten,
					GetConVar("boredhud_main_g"):GetInt() * shit *inten,
					GetConVar("boredhud_main_b"):GetInt() * shit *inten,
					GetConVar("boredhud_main_a"):GetInt() * fuck)
					surface.DrawTexturedRect(loc.x, loc.y, loc.w, loc.h)
				end
				
				-- Draw durability and contents of shit
				if !table.HasValue(whatwearedrawing, ItemID) then
					local durability = math.Round((ItemData.dur/ItemInfo.dur * 100), 0) .. "%"
					if (ItemData.tgl and ItemInfo.tgl.slots[slot]==0) then durability = "D,"..durability end
					local of = { x = v.x or 0, y = v.y or 0 }

					surface.SetTextColor(GetConVar("boredhud_main_r"):GetInt(),
					GetConVar("boredhud_main_g"):GetInt() * shit,
					GetConVar("boredhud_main_b"):GetInt() * shit,
					GetConVar("boredhud_main_a"):GetInt())

					surface.SetFont("BoHU_6")				
					BoHU.Text(ItemData.name, {2, 1}, loc.x+loc.w/2 + sm_j(of.x), loc.y+loc.h/2 + sm_j(of.y) - sm_j(4))

					surface.SetFont("BoHU_8")				
					BoHU.Text(durability, {2, 1}, loc.x+loc.w/2 + sm_j(of.x), loc.y+loc.h/2 + sm_j(of.y))
					local distan = 5

					if ( ItemInfo.chrg ) then
						for resource, maxAmt in pairs( ItemInfo.chrg ) do
							local dasfa = math.Round((ItemData.chrg[resource]/maxAmt * 100), 0) .. "%" 

							surface.SetFont("BoHU_5")				
							BoHU.Text(ArmorResourceNiceNames[resource], {2, 1}, loc.x+loc.w/2 + sm_j(of.x), loc.y+loc.h/2 + sm_j(of.y) + sm_j(distan-3))
							surface.SetFont("BoHU_6")				
							BoHU.Text(dasfa, {2, 1}, loc.x+loc.w/2 + sm_j(of.x), loc.y+loc.h/2 + sm_j(of.y) + sm_j(distan))
						end
					end
				end
				table.insert(whatwearedrawing, wwindex, ItemID)
				wwindex = wwindex + 1
				--PrintTable(whatwearedrawing)
			end
		end
		--[[local dontcomenear = 0
		for i, v in pairs(whatwearedrawing) do
			surface.SetTextColor(BoHU_ColorWhite)
			surface.SetFont("BoHU_12")
			BoHU.Text( i..") "..v, {0, 1}, sm(96), sm(24 - dontcomenear) )
			dontcomenear = dontcomenear - 8
		end]]
	end



	-- KIll    feed!!!!!!!!!

	if !GetConVar("boredhud_enable_killfeed"):GetBool() then return end

	local invertedhud = GetConVar("boredhud_deady"):GetFloat() < 0

	for k, v in pairs(bhkillfeed) do
		local decay = math.max(0, (v.time - CurTime())) * 750

		if v.time - CurTime() >= 5.8 then -- fade in
			decay = (1-(v.time - CurTime()-5.8)*5)*255
		end

		if decay <= 0 then -- removing old
			table.remove(bhkillfeed, k)
		end

		if #bhkillfeed > 5 and !v.overflowed then -- overflow
			if invertedhud and k == #bhkillfeed or !invertedhud and k == 1 then -- if inverted hud then delete last one else first one
				v.time = math.min(v.time, CurTime() + 0.1)
				v.overflowed = true
			end
		end

		surface.SetFont("BoHU_8")
		local texxt1 = v.killer
		local ww1 = surface.GetTextSize(texxt1)
		local texxt2 = " [" .. language.GetPhrase(v.gun) .."] "
		local ww2 = surface.GetTextSize(texxt2)
		local texxt3 = v.hesdead
		local ww3 = surface.GetTextSize(texxt3)
		local texxt4 = v.headshot and "D" or ""
		local ww4 = surface.GetTextSize(texxt4) * 3

		if !GetConVar("boredhud_killfeed_invert"):GetBool() then
			surface.SetTextColor(v.killercolor.r, v.killercolor.g, v.killercolor.b, decay)
			BoHU.Text(texxt1, {0, 0}, hi.scrw_g + sm(19), hi.scrh_g + sm(12.25) + k * sm(8.95))
			surface.SetTextColor(255, 255, 255, decay)
			BoHU.Text(texxt2, {0, 0}, hi.scrw_g + sm(19) + ww1, hi.scrh_g + sm(12.25) + k * sm(8.95))
			surface.SetFont("BoHU_kf_cssfont")
			BoHU.Text(texxt4, {0, 0}, hi.scrw_g + sm(16) + ww1 + ww2, hi.scrh_g + sm(12.5) + k * sm(8.95))
			surface.SetFont("BoHU_8")
			surface.SetTextColor(v.enemycolor.r, v.enemycolor.g, v.enemycolor.b, decay)
			BoHU.Text(texxt3, {0, 0}, hi.scrw_g + sm(19) + ww1 + ww2 + ww4, hi.scrh_g + sm(12.25) + k * sm(8.95))

			if v.wekilledhim or v.wearedead then
				surface.SetDrawColor(BoHU_ColorWhite.r * 0.75, BoHU_ColorWhite.g * 0.75, BoHU_ColorWhite.b * 0.75, math.min(60, decay))
				if v.wearedead then surface.SetDrawColor(255, 0, 0, math.min(60, decay)) end
				surface.DrawRect(hi.scrw_g + sm(16.5), hi.scrh_g + sm(11) + k * sm(8.95), ww1+ww2+ww3+ww4+sm(5), sm(9))
			end

			surface.SetDrawColor(BoHU_ColorWhite.r, BoHU_ColorWhite.g, BoHU_ColorWhite.b, decay)
			BoHU.ProgressBar(0, 0, hi.scrw_g + sm(16.5), hi.scrh_g + sm(11) + k * sm(8.95), ww1+ww2+ww3+ww4+sm(5), sm(9))
		else
			surface.SetTextColor(v.killercolor.r, v.killercolor.g, v.killercolor.b, decay)
			BoHU.Text(texxt1, {1, 0}, hi.scrw_g + hi.scrw - sm(19) - ww3 - ww2 - ww4, hi.scrh_g + sm(12.25) + k * sm(8.95))
			surface.SetTextColor(255, 255, 255, decay)
			BoHU.Text(texxt2, {1, 0}, hi.scrw_g + hi.scrw - sm(19) - ww3 - ww4, hi.scrh_g + sm(12.25) + k * sm(8.95))
			surface.SetFont("BoHU_kf_cssfont")
			BoHU.Text(texxt4, {1, 0}, hi.scrw_g + hi.scrw - sm(20) - ww3, hi.scrh_g + sm(12.5) + k * sm(8.95))
			surface.SetFont("BoHU_8")
			surface.SetTextColor(v.enemycolor.r, v.enemycolor.g, v.enemycolor.b, decay)
			BoHU.Text(texxt3, {1, 0}, hi.scrw_g + hi.scrw - sm(19), hi.scrh_g + sm(12.25) + k * sm(8.95))
	
			if v.wekilledhim or v.wearedead then
				surface.SetDrawColor(BoHU_ColorWhite.r * 0.75, BoHU_ColorWhite.g * 0.75, BoHU_ColorWhite.b * 0.75, math.min(60, decay))
				if v.wearedead then surface.SetDrawColor(255, 0, 0, math.min(60, decay)) end
				surface.DrawRect(hi.scrw_g + hi.scrw - sm(16)-ww1-ww2-ww3-ww4-sm(5.75), hi.scrh_g + sm(11) + k * sm(8.95), ww1+ww2+ww3+ww4+sm(5), sm(9))
			end

			surface.SetDrawColor(BoHU_ColorWhite.r, BoHU_ColorWhite.g, BoHU_ColorWhite.b, decay)
			BoHU.ProgressBar(0, 0, hi.scrw_g + hi.scrw - sm(16)-ww1-ww2-ww3-ww4-sm(5.75), hi.scrh_g + sm(11) + k * sm(8.95), ww1+ww2+ww3+ww4+sm(5), sm(9))
		end
	end
end )

local hide = {
	["CHudHealth"] = GetConVar("boredhud_enable_health"),
	["CHudBattery"] = GetConVar("boredhud_enable_health"),
	["CHudAmmo"] = GetConVar("boredhud_enable_ammo"),
	["CHudSecondaryAmmo"] = GetConVar("boredhud_enable_ammo"),
	["CHudSuitPower"] = GetConVar("boredhud_enable_suit"),
}

hook.Add( "HUDShouldDraw", "BoHU_HUDShouldDraw", function( name )
	if GetConVar("cl_drawhud"):GetBool() and
	GetConVar("boredhud_enable"):GetBool() and
	( hide[ name ] and hide[ name ]:GetBool() ) then
		return false
	end
end )




local npcenemycolor = Color(216, 83, 83)

local function kfaddkill()
	if !GetConVar("boredhud_enable_killfeed"):GetBool() then return end

	local killer = net.ReadEntity()
	local hesdead = net.ReadString()
	local headshot = net.ReadBool()
	local gun = net.ReadString()
	local histeam = net.ReadUInt(8)
	local suicide = net.ReadBool()
	
	local killtbl = {
		time = CurTime() + 6,
		killer = IsValid(killer) and (killer:IsPlayer() and killer:Name() or language.GetPhrase(killer:GetClass())) or "???",
		hesdead = language.GetPhrase(hesdead),
		wekilledhim = killer == LocalPlayer(),
		killercolor = killer == LocalPlayer() and BoHU_ColorWhite or (killer:IsPlayer() and team.GetColor(killer:Team()) or npcenemycolor),
		enemycolor = histeam == 255 and npcenemycolor or team.GetColor(histeam),
		headshot = headshot,
		gun = gun == "" and (killer.GetActiveWeapon and IsValid(killer:GetActiveWeapon()) and (killer:GetActiveWeapon().PrintName and killer:GetActiveWeapon().PrintName or killer:GetActiveWeapon():GetClass())) or gun
	}

	if suicide then killtbl.gun = "SUICIDE" end
	if killtbl.gun == "" then killtbl.gun = "???" end
	if LocalPlayer():Name() == hesdead then killtbl.wearedead = true end

	if GetConVar("boredhud_deady"):GetFloat() < 0 then -- invert order if inverted hud placement
		table.insert(bhkillfeed, 1, killtbl)
	else
		table.insert(bhkillfeed, killtbl)
	end
end

hook.Add("DrawDeathNotice", "BoHU_DrawDeathNotice", function(x, y)
	if GetConVar("boredhud_enable_killfeed"):GetBool() then return false end
end)

net.Receive("BoHU_KF_Kill", kfaddkill)









local hasthatubglorno = false

function BoHU.Draw3D()
	if !GetConVar("boredhud_3dementia"):GetBool() or !GetConVar("boredhud_enable"):GetBool() or !GetConVar("cl_drawhud"):GetBool() then return end
	local hi = BoHU.GetHUDInfo()
	local P = LocalPlayer()
	if !P:Alive() then return end

	local camcontrol = angle_zero
	if hi.pw.ARC9 then
		camcontrol = hi.pw:GetCameraControl()
		camcontrol.y = math.Clamp(camcontrol.y, -10, 10)
	end

    local anchorwidth = math.min(ScrW() / 2, ScrH() / 2)

    -- cam.Start3D(nil, nil, 55, 0, ScrH() - anchorwidth, anchorwidth, anchorwidth)
    cam.Start3D(nil, EyeAngles() + camcontrol, 55, 0, 0, anchorwidth, anchorwidth)

    local ang = EyeAngles()

    local up, right, forward = ang:Up(), ang:Right(), ang:Forward()

    ang:RotateAroundAxis(up, 240)
    ang:RotateAroundAxis(right, 105)
    ang:RotateAroundAxis(forward, -30)

    local pos = EyePos() + (forward * 4) + (up * 1.75) + (right * -1.75)

    pos, ang = ARC9.HUDBob(pos, ang)
    pos, ang = ARC9.HUDSway(pos, ang)

    cam.Start3D2D(pos, ang, 0.0075) -- left panel
		-- surface.SetDrawColor(ARC9.GetHUDColor("bg_3d", 60))
		-- surface.DrawRect( 0, 0, 254*1.5, 110*1.5 )

		if hi.hp_per > 0 then -- hp
			surface.SetDrawColor(BoHU_ColorWhite)
			BoHU.ProgressBar(hi.hp_per, 0, 15, 80, 352, 15)
			local s2remove = 0
			local s2extra = hi.hp_am - P:GetMaxHealth()
			if P:GetMaxHealth() < hi.hp_am then
				s2remove = s2extra
				surface.SetFont("BoHU_26")
				local FUCKYOU = surface.GetTextSize(hi.hp_am-s2remove)/2
				surface.SetFont("BoHU_10")
				surface.SetTextColor(BoHU_ColorWhite)
				BoHU.Text( s2extra, {0, 0}, 65 + FUCKYOU, 41 )
				BoHU.Text( "+", {0, 0},     65 + FUCKYOU, 22 )
			end
			surface.SetTextColor(BoHU_ColorWhite)
			surface.SetFont("BoHU_26")
			BoHU.Text( hi.hp_am-s2remove, {2, 1}, 60, 80 )
	
			surface.SetTextColor(BoHU_ColorWhite)
			surface.SetFont("BoHU_8")
			BoHU.Text("HEALTH", {2, 1}, 60,  20 )
		end

		if hi.ar_per > 0 then -- armor
			surface.SetDrawColor(BoHU_ColorWhite)
			BoHU.ProgressBar(hi.ar_per, 0, 15, 102, 352, 10)

			local s2remove = 0
			local s2extra = hi.ar_am - P:GetMaxArmor()
			local as = sm(36)
			if P:GetMaxArmor() < hi.ar_am then
				s2remove = s2extra
				surface.SetFont("BoHU_20")
				local FUCKYOU = surface.GetTextSize(hi.ar_am-s2remove)/2
				surface.SetFont("BoHU_8")
				surface.SetTextColor(BoHU_ColorWhite)
				BoHU.Text( s2extra, {0, 0}, 192 + FUCKYOU, 43 )
				BoHU.Text( "+", {0, 0},     192 + FUCKYOU, 26 )
			end
			surface.SetTextColor(BoHU_ColorWhite)
			surface.SetFont("BoHU_20")
			BoHU.Text( hi.ar_am-s2remove, {2, 1}, 185, 72 )

			surface.SetTextColor(BoHU_ColorWhite)
			surface.SetFont("BoHU_8")
			BoHU.Text("ARMOR", {2, 1}, 185,  25 )
		end
    cam.End3D2D()

	cam.End3D()


	
    cam.Start3D(nil, EyeAngles() + camcontrol, 55, ScrW() - anchorwidth, 0, anchorwidth, anchorwidth)
	ang = EyeAngles()

    ang:RotateAroundAxis(up, 155)
    ang:RotateAroundAxis(right, 80)
    ang:RotateAroundAxis(forward, -115)

    pos = EyePos() + (forward * 4.2) + (up * 1.7) + (right * -1.2)

    pos, ang = ARC9.HUDBob(pos, ang)
    pos, ang = ARC9.HUDSway(pos, ang)

    cam.Start3D2D(pos, ang, 0.0075) -- right panel
		-- surface.SetDrawColor(ARC9.GetHUDColor("bg_3d", 60))
		-- surface.DrawRect( 0, 0, 254*1.5, 110*1.5 )

		
		if hi.wp_clip1 and hi.wp_clip1 != NA and ( !tonumber(hi.wp_clip1) and true or hi.wp_clip1 > -1 ) then -- ammo
			surface.SetDrawColor(BoHU_ColorWhite)
			surface.SetTextColor(BoHU_ColorWhite)
	
			local cut
			if tonumber(hi.wp_clip1) and hi.wp_maxclip1 and hi.wp_maxclip1 != NA then
				cut = math.min(hi.wp_clip1/hi.wp_maxclip1,1)
			else
				cut = 1
			end
			BoHU.ProgressBar(cut, 1, 15, 80, 352, 15)
			if hi.wep_name and hi.wep_name != NA then
				surface.SetFont("BoHU_12")
				BoHU.Text(hi.wep_name, {2, 0}, 191, 100)
			end
	
			local HD
			if hi.pw then
				local PW = hi.pw
				if PW.ArcCW then
					HD = PW:GetHUDData()
				elseif PW.ARC9 then
					HD = {}
					HD.heat_enabled = PW:GetProcessedValue("Overheat", true)
					HD.heat_level = PW:GetHeatAmount()
					HD.heat_maxlevel = PW:GetProcessedValue("HeatCapacity", true)
				elseif PW.GH3 and PW.Stats["Heat"] then
					HD = {}
					HD.heat_enabled = PW.Stats["Heat"]
					HD.heat_level = PW:GetAccelHeat()
					HD.heat_maxlevel = PW.Stats["Heat"]["Overheated Threshold"]
				end
	
				if HD and HD.heat_enabled then
					local heat = math.Clamp( HD.heat_level/HD.heat_maxlevel, 0, 1 )
	
					surface.SetDrawColor(255, 0, 0, 255)
					BoHU.Rect(15, 80, 352*heat, 4)
				end
			end
	
			if hi.wp_clip1 and hi.wp_clip1 != NA then
				if tonumber(hi.wp_clip1) then
					local s2remove = 0
					if hi.wp_clipextra1 and hi.wp_clipextra1 != NA then
						s2remove = (!hi.pw.ArcCW and hi.wp_clipextra1 or 0)
						surface.SetFont("BoHU_26")
						local FUCKYOU = surface.GetTextSize(hi.wp_clip1-s2remove)/2
						surface.SetFont("BoHU_10")
						BoHU.Text( hi.wp_clipextra1, {0, 0}, 325 + FUCKYOU, 40 )
						BoHU.Text( "+", {0, 0},              322 + FUCKYOU, 20 )
					end
					surface.SetFont("BoHU_26")
					if hi.pw.isDualwield then
						BoHU.Text( hi.wp_clip1 .. "|" .. hi.wp_clip2, {2, 1}, 320, 82 )
					else
						BoHU.Text( hi.wp_clip1-s2remove, {2, 1}, 320, 82 )
					end
	
					surface.SetFont("BoHU_8")
					BoHU.Text("AMMO", {2, 1}, 320, 22 )
				else
					surface.SetFont("BoHU_26")
					BoHU.Text( hi.wp_clip1, {2, 1}, 0, hi.scrh_g + hi.scrh - sm(18) )
	
					surface.SetFont("BoHU_8")
					BoHU.Text("AMMO", {2, 1}, hi.scrw_g + hi.scrw - sm(28), hi.scrh_g + hi.scrh - sm(34) )
				end
			end
	
			if hi.wp_ammo1 and hi.wp_ammo1 != NA then
				surface.SetFont("BoHU_20")
				BoHU.Text( hi.wp_ammo1, {2, 1}, 220, 74 )
	
				surface.SetFont("BoHU_8")
				BoHU.Text("RESERVE", {2, 1}, 220, 30 )
			end
	
			if hi.wp_ammoname and hi.wp_ammoname != NA then
				local ammoname = hi.wp_ammoname
				if string.len(ammoname) > 14 then
					ammoname = string.Left(ammoname, 14 ) .. ".."
				end
				surface.SetFont("BoHU_8")
				BoHU.Text(string.upper(ammoname), {2, 1}, 88, hasthatubglorno and 50 or 60 )
			end
			if hi.wp_firemode and hi.wp_firemode != NA then
				surface.SetFont("BoHU_8")
				BoHU.Text(string.upper(hi.wp_firemode), {2, 1}, 88, hasthatubglorno and 30 or 40 )
			end
			altgap = 4.75

			if hi.pw and hi.wp_ubgl then -- ubgl
				hasthatubglorno = true
	
				surface.SetDrawColor(BoHU_ColorWhite)
				surface.SetTextColor(BoHU_ColorWhite)
	
				local cut
				if tonumber(hi.wp_clip2) and hi.wp_maxclip2 and hi.wp_maxclip2 != NA then
					cut = math.min(hi.wp_clip2 / hi.wp_maxclip2, 1)
				else
					cut = 1
				end
				BoHU.ProgressBar(cut, 1, 25, 57, 130, 10)
			else hasthatubglorno = false end
		end
    cam.End3D2D()

	cam.End3D()
end

hook.Add("HUDPaint", "Bored_DrawHud3d", BoHU.Draw3D)