-- Generated from template

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	
	Convars:RegisterCommand( "testElement", function(name, _element, _bool, _x, _y, _width, _height)
		local cmdPlayer = Convars:GetCommandClient()
		if cmdPlayer then 
			FireGameEvent('testswf_test_element', { _element = _element, _bool = _bool, _x = _x, _y = _y, _width = _width, _height = _height } )
		end
	end, "Test valve element", 0 )

	Convars:RegisterCommand( "testCmd", function(name, _cmd, _type, _value, _splice)
		local cmdPlayer = Convars:GetCommandClient()
		if cmdPlayer then 
			FireGameEvent('testswf_test_cmd', { _cmd = _cmd, _type = _type, _value = _value, _splice = _splice } )
		end
	end, "Test valve element", 0 )
	
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end