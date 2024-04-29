-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDS
-----------------------------------------------------------------------------------------------------------------------------------------
Discords = {
	["Connect"] = "https://discord.com/awebhooks/1094742297343709224/-CFSEHgVNRhJxvSipRVqaxV7LIVvLuPB2kwfW8LSe9MCjijPCHazdpTNYst_q1gN3SGa",
	["Disconnect"] = "https://discord.capi/webhooks/1094742379078098964/9-AJKi7ukS1oRkui1gQi4bEHYJ9cw2WcCIhyOFa-bqKcLn5-_0Co5fcjcishxd2xBBoZ",
	["Airport"] = "https://discord.comi/webhooks/1094742453711540274/-SEZRUWW6U8oHmddAXhK2L0P7gdwFCkSf2zNwdj0o5PwBjgavWycIyz1wTOdVV5vYSjb",
	["Deaths"] = "https://discord.com//webhooks/1094742535609532486/peO-VDPJ39p5te5sn-YrAtMu20L-qtxBPYmBdgwkqaW-sbfzXBmbySA3za-vlaZIysmr",
	["Police"] = "https://discord.comi/webhooks/1094742625396986017/O3m752d-UABqLOWOg0-9jvEp4Pmiot7PMPp_EYX-RxI9haKeo1xsz_sRT2Os6VZJLptS",
	["Paramedic"] = "https://discord.capi/webhooks/1094742718976114698/7O4ExS0tlMp9H-UxT6Xho5r3L34mJwCywhMx_mq7dCDPbxFOpetXvht8BK16DWKi9U6E",
	["Gemstone"] = "https://discord.copi/webhooks/1094742811779289178/-C56hgr7oNUXjX5MjZqiHk7WhNixImHVLVBwOHZAHjJ1b2GiZVbiWGhWczyEYNv9CHWf",
	["Login"] = "https://discord.com/aoks/1094742888602161222/ds2h0-viRM5NRAj_tuS94wSlcEYU5ILhUG5Yc1zxDY11CpcxUlYPqtQbCJRueVghTACU"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Discord",function(Hook,Message,Color)
	PerformHttpRequest(Discords[Hook],function(err,text,headers) end,"POST",json.encode({
		username = ServerName,
		embeds = { { color = Color, description = Message } }
	}),{ ["Content-Type"] = "application/json" })
end)