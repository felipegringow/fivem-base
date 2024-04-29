-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Carry")
AddEventHandler("inventory:Carry", function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Carry[Passport] then
			local OtherSource = vRPC.ClosestPed(source, 2)
			local OtherPassport = vRP.Passport(OtherSource)
			if OtherSource and not Carry[OtherPassport] then
				Carry[Passport] = OtherSource
				Player(source)["state"]["Carry"] = true
				Player(OtherSource)["state"]["Carry"] = true
				TriggerClientEvent("inventory:Carry", OtherSource, source, "Attach")
			end
		else
			TriggerClientEvent("inventory:Carry", Carry[Passport], source, "Detach")
			Player(Carry[Passport])["state"]["Carry"] = false

			Player(source)["state"]["Carry"] = false
			Carry[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SERVERCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:ServerCarry")
AddEventHandler("inventory:ServerCarry", function(source, Passport, OtherSource, Handcuff)
	if not Carry[Passport] then
		local OtherPassport = vRP.Passport(OtherSource)
		if OtherPassport then
			if not Carry[OtherPassport] then
				Carry[Passport] = OtherSource
				Player(source)["state"]["Carry"] = true
				Player(OtherSource)["state"]["Carry"] = true
				TriggerClientEvent("inventory:Carry", OtherSource, source, "Attach", Handcuff)
			end
		end
	else
		TriggerClientEvent("inventory:Carry", Carry[Passport], source, "Detach")
		Player(Carry[Passport])["state"]["Carry"] = false

		Player(source)["state"]["Carry"] = false
		Carry[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:CarryDetach")
AddEventHandler("inventory:CarryDetach", function(source, Passport)
	if Carry[Passport] then
		TriggerClientEvent("inventory:Carry", Carry[Passport], source, "Detach")
		Player(Carry[Passport])["state"]["Carry"] = false

		Player(source)["state"]["Carry"] = false
		Carry[Passport] = nil
	end
end)

function Creative.startCarry(target, animationLib, animationLib2, animation, animation2, distans, distans2, height,
						  targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget)
	local source = source
	if source and targetSrc then
		vCLIENT.syncTarget(targetSrc, source, animationLib2, animation2, distans, distans2, height, length, spin,
			controlFlagTarget, animFlagTarget)
		vCLIENT.syncSource(source, animationLib, animation, length, controlFlagSrc, animFlagTarget)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.stopCarry(targetSrc)
	if targetSrc then
		vCLIENT.stopCarry(targetSrc)
	end
end
