GhostBan = GhostBan or {}

--[[-------------------------------------------------------------------------
	DON'T CHANGE CONFIG IN THIS FILE, USE IN-GAME CONFIG MENU
---------------------------------------------------------------------------]]

GhostBan.CanHurt = false -- Ghost can hurt other players / entities ( Amityville is back )
GhostBan.CanSpawnProps = false -- Ghost can spawn props
GhostBan.CanProperty = false -- Ghost can use property, such as 'remove', 'weld' etc...
GhostBan.CanTool = false -- Ghost can use tools ( Builder Ghost )
GhostBan.CanTalkVoice = false -- Ghost can talk with their voice ( spoopy )
GhostBan.CanTalkChat = false -- Ghost can talk with the chat ( when you're behind a screen, nobody knows you're a ghost )
GhostBan.Loadouts = true -- Ghost have their loadouts ( weapons at start )
GhostBan.CanPickupItem = false -- Ghost can pickup items
GhostBan.CanPickupWep = false -- Ghost can pickup weapons ( The GhostFather )
GhostBan.CanEnterVehicle = false -- Ghost can enter vehicles ( Google Car but it's a ghost driving )
GhostBan.CanSuicide = false -- Ghost can suicide ( Ghosts are already dead but don't tell them )
GhostBan.CanCollide = 2 -- Ghost don't collide with players (0), Ghost don't collide with anything (1), Ghost collide with everything (2) ( warning: if not 2, ghost can't be hurt )
GhostBan.DisplayReason = true -- Display text at the bottom of the screen with reason and time left
GhostBan.CanOpenContextMenu = false -- Ghost can open context menu
GhostBan.CanOpenPropsMenu = false -- Ghost can open props menu
GhostBan.CanOpenGameMenu = true -- Ghost can open game menu
GhostBan.DisplayCyanGhost = true -- Display 'GHOST' above the ghost
GhostBan.ReplaceULXBan = false -- ulx ban is replaced with ulx ghostban
GhostBan.CantSeeMe = false -- Ghosts are invisible ( great with CanCollide to 1 )
GhostBan.material = "models/props_combine/portalball001_sheet"
GhostBan.freezeGhost = false -- Ghost is frozen, it can't move - Thanks http://steamcommunity.com/profiles/76561198150594616 for the idea
GhostBan.jailMode = false -- In jail mode, Ghostban is used to jail instead of banning - Thanks http://steamcommunity.com/profiles/76561198022486540 for the idea
GhostBan.canChangeJob = false -- Ghost can change job (DarkRP)
GhostBan.setPos = Vector(0,0,0)
GhostBan.Language = "EN"
--GhostBan.SuperHot = false -- Time move only when ghosts move
GhostBan.percentKick = 0 -- Percent of before kicking ghosts ( in minutes )
GhostBan.Cleanup = false

-- Translations, text can be replaced by {nick}, {steamid}, {steamid64}
-- Special for urban: {reason} which display reason of ban, and {timeleft} which display time left
GhostBan.Translation = {
	["EN"] = {
		["noreason"] = "no reason specified",
		["ghostingS"] = "(GhostBan) {nick} ({steamid}) is a ghost", -- log message
		["ghostText"] = "GHOST", -- text displayed above the ghost, no parsing
		["mute"] = "You're a ghost, nobody can hear you", -- chat text when a ghost try to talk
		["urban1"] = "You're banned for the following reason:", -- hud first line
		["urban2"] = "{reason}", -- hud second line
		["urban3"] = "Time left: {timeleft}", -- hud third line
		["year"] = "years",
		["days"] = "days",
		["hours"] = "hours",
		["minutes"] = "minutes",
		["seconds"] = "seconds",
		["eternity"] = "eternity",
		["ban_usage"] = "Usage: !ban <nick> [time (minutes)] [reason]",
		["ghban_usage"] = "Usage: gh_ban <nick> [time (minutes)] [reason]",
		["unban_usage"] = "Usage: !unban <nick>",
		["ghunban_usage"] = "Usage: gh_unban <nick>",
		["404"] = "(GhostBan) 404: Player not found",
		["notWhatUThink"] = "This player isn't a ghost",
		["TooMuch4U"] = "Too many players, kicking ghost",
		["invalidSteamid"] = "Invalid SteamID",
		["ghbanid_usage"] = "Usage: gh_banid \"<SteamID>\" [time (minutes)] [reason]",
		["unghbanid_usage"] = "Usage: gh_unbanid \"<SteamID>\"",
	},
	["FR"] = {
		["noreason"] = "pas de raison",
		["ghostingS"] = "(GhostBan) {nick} ({steamid}) est un fantome", -- log message
		["ghostText"] = "FANTOME", -- text displayed above the ghost, no parsing
		["mute"] = "Les fantomes ne parlent pas", -- chat text when a ghost try to talk
		["urban1"] = "Vous etes bannis pour la raison suivante:", -- hud first line
		["urban2"] = "{reason}", -- hud second line
		["urban3"] = "Temps restant: {timeleft}", -- hud third line
		["year"] = "années",
		["days"] = "jours",
		["hours"] = "heures",
		["minutes"] = "minutes",
		["seconds"] = "secondes",
		["eternity"] = "l'éternité",
		["ban_usage"] = "Usage: !ban <pseudo> [temps (minutes)] [raison]",
		["ghban_usage"] = "Usage: gh_ban <pseudo> [temps (minutes)] [raison]",
		["unban_usage"] = "Usage: !unban <pseudo>",
		["ghunban_usage"] = "Usage: gh_unban <pseudo>",
		["404"] = "(GhostBan) 404: Joueur introuvable",
		["notWhatUThink"] = "Ce joueur n'est pas un fantome",
		["TooMuch4U"] = "Trop de joueurs, kick des fantomes",
		["invalidSteamid"] = "SteamID invalide",
		["ghbanid_usage"] = "Usage: gh_banid \"<SteamID>\" [temps (minutes)] [raison]",
		["unghbanid_usage"] = "Usage: gh_unbanid \"<SteamID>\"",
	},
	["RU"] = {
		["noreason"] = "причина не указана",
		["ghostingS"] = "(GhostBan) {nick} ({steamid}) - забанен", -- log message
		["ghostText"] = "Забаненный", -- text displayed above the ghost, no parsing
		["mute"] = "Ты забанен, тебя никто не слышит", -- chat text when a ghost try to talk
		["urban1"] = "Вы забанены по следующей причине:", -- hud first line
		["urban2"] = "{reason}", -- hud second line
		["urban3"] = "Времени осталось: {timeleft}", -- hud third line
		["year"] = "лет",
		["days"] = "дней",
		["hours"] = "часов",
		["minutes"] = "минут",
		["seconds"] = "секунд",
		["eternity"] = "вечность",
		["ban_usage"] = "заявка: !ban <прозвище> [время (минут)] [причина]",
		["ghban_usage"] = "заявка: gh_ban <прозвище> [время (минут)] [причина]",
		["unban_usage"] = "заявка: !unban <прозвище>",
		["ghunban_usage"] = "заявка: gh_unban <прозвище>",
		["404"] = "(GhostBan) 404: Игрок не найден",
		["notWhatUThink"] = "Этот игрок не призрак",
		["TooMuch4U"] = "Слишком много игроков, kick призраки",
		["invalidSteamid"] = "недействительный SteamID",
		["ghbanid_usage"] = "заявка: gh_banid \"<SteamID>\" [время (минут)] [причина]",
		["unghbanid_usage"] = "заявка: gh_unbanid \"<SteamID>\"",
	},
}