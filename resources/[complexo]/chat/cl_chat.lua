-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("chat",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local chatOpen = false
local chatActive = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chatMessage")
AddEventHandler("chatMessage",function(author,color,text)
	--[[ if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then ]]
		if chatActive then
			local args = { text }
			if author ~= "" then
				table.insert(args,1,author)
			end

			SendMessage({ color = color, multiline = true, content = args })
		end
--[[ 	end ]]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chatME")
AddEventHandler("chatME",function(author, text, type)
--[[ 	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then ]]
		if chatActive then
			SendMessage({ author = author, content = text, type = type })
		end
--[[ 	end ]]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATLB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chatLB")
AddEventHandler("chatLB",function(author, text, playerId)
	if chatActive then
		local player = GetPlayerFromServerId(playerId)
		if player ~= -1 then
			if #(GetEntityCoords(GetPlayerPed(player))-GetEntityCoords(PlayerPedId())) <= 20 then
				SendMessage({ author = author, content = text, type = "Libras" })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:addMessage")
AddEventHandler("chat:addMessage",function(message)
	SendMessage(message)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:clear")
AddEventHandler("chat:clear",function(name)
	SendNUIMessage({ type = "ON_CLEAR" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARSUGGESTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:clearSuggestions")
AddEventHandler("chat:clearSuggestions",function()
	SendNUIMessage({ type = "ON_SUGGESTIONS_REMOVE" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATRESULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chatResult",function(data,cb)
	SetNuiFocus(false, false)
	EmitNuiMessage("ON_SCREEN_STATE_CHANGE", true)

	if not data.canceled then
		if data.message:sub(1,1) == "/" then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent("chat:messageEntered", data.message)
		end
	end

	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSUGGESTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:addSuggestion")
AddEventHandler("chat:addSuggestion",function(suggestions)
	for _, suggestion in ipairs(suggestions) do
		EmitNuiMessage("ON_SUGGESTION_ADD", suggestion)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("loaded",function(data, cb)
	for _, suggestion in ipairs(SUGGESTIONS) do
		EmitNuiMessage("ON_SUGGESTION_ADD", suggestion)
	end

	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chat",function(source,args)
--[[ 	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then ]]
		if chatOpen then
			if chatActive then
				chatActive = false
				SendNUIMessage({ type = "ON_CLEAR" })
			else
				chatActive = true
			end
		end
--[[ 	end ]]
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openChat",function(source,args)
--[[ 	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then ]]
		chatOpen = true
		SetNuiFocus(true, false)
		SendNUIMessage({ type = "ON_OPEN" })
--[[ 	end ]]
end, false)

RegisterNetEvent("__cfx_internal:serverPrint")
AddEventHandler("__cfx_internal:serverPrint", function(msg)
	--[[ if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then ]]
		chatOpen = false
	--[[ end ]]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openChat","Abrir chat","keyboard","t")
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.statusChat()
	return chatOpen
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
function statusChat()
	return chatOpen
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMITNUI
-----------------------------------------------------------------------------------------------------------------------------------------
function EmitNuiMessage(type, payload)
    SendNUIMessage({
        type = type,
        payload = { payload } or {}
    })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("statusChat",statusChat)

function SendMessage(message)
	EmitNuiMessage("ON_MESSAGE", message)
end