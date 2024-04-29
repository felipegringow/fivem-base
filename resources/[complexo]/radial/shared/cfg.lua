MenuOptions = {
    {
        id = "outfit",
        title = "Roupas",
        icon = "icon linear slider-horizontal-1",
        items = {
            {
                id = "outfit-apply",
                title = "Aplicar",
                icon = "icon linear save-2",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "aplicar" }
            },
            {
                id = "outfit-save",
                title = "Salvar",
                icon = "icon linear add",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "salvar" }
            },
            {
                id = "outfit-remove",
                title = "Remover",
                icon = "icon linear save-remove",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "remover" }
            }
        },
    },
    {
        id = "premiumfit",
        title = "Roupas Premium",
        icon = "icon linear slider-horizontal",
        items = {
            {
                id = "premiumfit-apply1",
                title = "[PRATA] Aplicar",
                icon = "icon linear save-add",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "preaplicar1" }
            },
            {
                id = "premiumfit-save1",
                title = "[PRATA] Salvar",
                icon = "icon linear save-2",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "presalvar1" }
            },
            {
                id = "premiumfit-apply2",
                title = "[OURO] Aplicar",
                icon = "icon linear save-add",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "preaplicar2" }
            },
            {
                id = "premiumfit-save2",
                title = "[OURO] Salvar",
                icon = "icon linear save-2",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "presalvar2" }
            },
            {
                id = "premiumfit-apply3",
                title = "[PLATINA] Aplicar",
                icon = "icon linear save-add",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "preaplicar3" }
            },
            {
                id = "premiumfit-save3",
                title = "[PLATINA] Salvar",
                icon = "icon linear save-2",
                server = true,
                trigger = "player:outfitFunctions",
                triggerArgs = { "presalvar3" }
            }
        }
    },
    {
        id = "animal",
        title = "Domésticos",
        icon = "icon linear pet",
        enableMenu = function()
            return HasAnimal()
        end,
        items = {
            {
                id = "animal-follow",
                title = "Seguir",
                icon = "icon linear pet",
                server = false,
                trigger = "dynamic:animalFunctions",
                triggerArgs = { "seguir" }
            },
            {
                id = "animal-putInVehicle",
                title = "Colocar no Veículo",
                icon = "icon linear car",
                server = false,
                trigger = "dynamic:animalFunctions",
                triggerArgs = { "colocar" }
            },
            {
                id = "animal-removeOfVehicle",
                title = "Remover do Veículo",
                icon = "icon linear car",
                server = false,
                trigger = "dynamic:animalFunctions",
                triggerArgs = { "remover" }
            }
        }
    },
    {
        id = "propertys",
        title = "Propriedades",
        icon = "icon linear home",
        items = {
            {
                id = "propertys-list",
                title = "Propriedades",
                icon = "icon linear home",
                server = false,
                trigger = "homes:togglePropertys"
            },
            {
                id = "propertys-lock",
                title = "Trancar",
                icon = "icon linear lock",
                server = true,
                trigger = "homes:invokeSystem",
                triggerArgs = { "trancar" },
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end
            },
            {
                id = "propertys-garage",
                title = "Garagem",
                server = true,
                icon = "icon linear home-1",
                trigger = "homes:invokeSystem",
                triggerArgs = { "garagem" },
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end
            },
            {
                id = "propertys-permissions",
                title = "Permissões",
                icon = "icon linear home-hashtag",
                server = true,
                trigger = "homes:invokeSystem",
                triggerArgs = { "checar" },
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end
            },
            {
                id = "propertys-tax",
                title = "Taxas",
                server = true,
                icon = "icon linear home-trend-down",
                trigger = "homes:invokeSystem",
                triggerArgs = { "tax" },
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end
            },
            {
                id = "propertys-chest",
                title = "Armário",
                icon = "icon linear box-add",
                server = true,
                trigger = "homes:invokeSystem",
                triggerArgs = { "armario" },
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end
            },
            {
                id = "propertys-fridge",
                title = "Geladeira",
                icon = "icon linear box-add",
                server = true,
                trigger = "homes:invokeSystem",
                triggerArgs = { "geladeira" },
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end
            },
            {
                id = "propertys-sell",
                title = "Vender",
                icon = "icon linear home-2",
                server = true,
                trigger = "homes:invokeSystem",
                triggerArgs = { "vender" },
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end
            }
        }
    },
    {
        id = "vehicle",
        title = "Veículo",
        icon = "icon linear car", -- TODO
        enableMenu = function(playerPed)
            return IsPedInAnyVehicle(playerPed, false)
        end,
        items = {
            {
                id = "vehicle-seat-0",
                title = "Banco Dianteiro Esquerdo",
                server = false,
                trigger = "player:seatPlayer",
                triggerArgs = { "0" }
            },
            {
                id = "vehicle-seat-1",
                title = "Banco Dianteiro Direito",
                server = false,
                trigger = "player:seatPlayer",
                triggerArgs = { "1" }
            },
            {
                id = "vehicle-seat-2",
                title = "Banco Traseiro Esquerdo",
                server = false,
                trigger = "player:seatPlayer",
                triggerArgs = { "2" }
            },
            {
                id = "vehicle-seat-3",
                title = "Banco Traseiro Direito",
                server = false,
                trigger = "player:seatPlayer",
                triggerArgs = { "3" }
            },
            {
                id = "vehicle-wins-up",
                title = "Levantar Vidros",
                server = true,
                trigger = "player:winsFunctions",
                triggerArgs = { "1" }
            },
            {
                id = "vehicle-wins-down",
                title = "Abaixar Vidros",
                server = true,
                trigger = "player:winsFunctions",
                triggerArgs = { "0" }
            },
        }
    },
    {
        id = "others",
        title = "Outros",
        icon = "icon linear more",
        items = {
            {
                id = "others-identity",
                title = "Informações",
                icon = "icon linear information",
                server = true,
                trigger = "player:identityFunctions",
            },
            {
                id = "others-wounds",
                title = "Ferimentos",
                icon = "icon linear health",
                server = false,
                trigger = "paramedic:myInjuries",
            },
            {
                id = "others-experience",
                title = "Experiência",
                icon = "icon linear glass",
                server = true,
                trigger = "vrp:showExperience",
            },
            {
                id = "others-dismantle",
                title = "Desmanche",
                icon = "icon linear information",
                server = true,
                trigger = "inventory:Dismantle",
                enableMenu = function()
                    return not IsPolice() and not IsParamedic()
                end,
            },
            {
                id = "others-vehicle-tow",
                title = "Rebocar",
                icon = "icon linear truck-tick",
                server = false,
                trigger = "towdriver:invokeTow",
                enableMenu = function(playerPed)
                    return not IsPedInAnyVehicle(playerPed, false)
                end,
            },
        }
    },
    {
        id = "others-players",
        title = "Jogador",
        icon = "icon linear user",
        items = {
            {
                id = "others-players-cv",
                title = "Colocar no Veículo",
                icon = "icon linear car",
                server = true,
                trigger = "player:cvFunctions",
                triggerArgs = { "cv" }
            },
            {
                id = "others-players-rv",
                title = "Remover do Veículo",
                icon = "icon linear car",
                server = true,
                trigger = "player:cvFunctions",
                triggerArgs = { "rv" }
            },
            {
                id = "others-players-trunk",
                title = "Checar Porta-Malas",
                icon = "icon linear car",
                server = true,
                trigger = "player:checkTrunk"
            },
        }
    },
    {
        id = "paramedic",
        title = "Paramédico",
        icon = "icon linear user",
        enableMenu = function()
            return IsParamedic()
        end,
        items = {
            {
                id = "paramedic-service",
                title = "Serviço",
                icon = "icon linear car",
                server = true,
                trigger = "player:servicoFunctions",
            },
            {
                id = "paramedic-clothes",
                title = "Fardamento",
                icon = "icon linear user",
                items = {
                    {
                        id = "paramedic-clothes-1",
                        title = "Médico",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "6" }
                    },
                    {
                        id = "paramedic-clothes-2",
                        title = "Interno",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "7" }
                    },
                    {
                        id = "paramedic-clothes-3",
                        title = "Socorrista Preto",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "8" }
                    },
                    {
                        id = "paramedic-clothes-4",
                        title = "Socorrista Vermelho",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "9" }
                    },
                    {
                        id = "paramedic-clothes-5",
                        title = "Mergulho",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "10" }
                    },
                }
            },
        }
    },
    {
        id = "police",
        title = "Policia",
        icon = "icon linear user",
        enableMenu = function()
            return IsPolice()
        end,
        items = {
            {
                id = "police-service",
                title = "Serviço",
                icon = "icon linear reserve",
                server = true,
                trigger = "player:servicoFunctions",
            },
            {
                id = "police-extras",
                title = "Extra",
                icon = "icon linear reserve",
                items = {
                    {
                        id = "police-barrier",
                        title = "Colocar Barreira",
                        icon = "icon linear box-add",
                        server = false,
                        trigger = "police:insertBarrier",
                    },
                    {
                        id = "police-invade-home",
                        title = "Invadir Residência",
                        icon = "icon linear safe-home",
                        server = true,
                        trigger = "homes:invadeSystem",
                    },
                    {
                        id = "police-remove-hat",
                        title = "Remover Chapéu",
                        icon = "icon linear user-remove",
                        server = true,
                        trigger = "skinshop:removeProps",
                        triggerArgs = { "hat" }
                    },
                    {
                        id = "police-remove-mask",
                        title = "Remover Máscara",
                        icon = "icon linear user-remove",
                        server = true,
                        trigger = "skinshop:removeProps",
                        triggerArgs = { "mask" }
                    },
                }
            },
            {
                id = "police-clothes",
                title = "Fardamento",
                icon = "icon linear setting",
                items = {
                    {
                        id = "police-clothes-1",
                        title = "Recruta",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "1" }
                    },
                    {
                        id = "police-clothes-2",
                        title = "Soldado",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "2" }
                    },
                    {
                        id = "police-clothes-3",
                        title = "Cabo",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "3" }
                    },
                    {
                        id = "police-clothes-4",
                        title = "Sargento",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "4" }
                    },
                    {
                        id = "police-clothes-5",
                        title = "Oficial",
                        icon = "icon linear scissor",
                        server = true,
                        trigger = "player:presetFunctions",
                        triggerArgs = { "5" }
                    },
                }
            },
            {
                id = "police-radio",
                title = "Frequências",
                icon = "icon linear radar-1",
                items = {
                    {
                        id = "police-radio-pm",
                        title = "PM",
                        icon = "icon linear shield-security",
                        items = {
                            {
                                id = "police-radio-pm-1",
                                title = "BCRF",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 911 }
                            },
                            {
                                id = "police-radio-pm-2",
                                title = "BCE",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 912 }
                            },
                            {
                                id = "police-radio-pm-3",
                                title = "QG",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 914 }
                            },
                            {
                                id = "police-radio-pm-4",
                                title = "GAR",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 915 }
                            },
                            {
                                id = "police-radio-pm-5",
                                title = "GAEP",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 916 }
                            },
                            {
                                id = "police-radio-pm-6",
                                title = "BOPE",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 917 }
                            },
                        },
                    },
                    {
                        id = "police-radio-pc",
                        title = "PC",
                        icon = "icon linear security",
                        items = {
                            {
                                id = "police-radio-pc-1",
                                title = "DGC",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 921 }
                            },
                            {
                                id = "police-radio-pc-2",
                                title = "DRE",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 922 }
                            },
                            {
                                id = "police-radio-pc-3",
                                title = "DRF",
                                icon = "icon linear microphone-2",
                                server = false,
                                trigger = "radio:changeFrequency",
                                triggerArgs = { 923 }
                            },
                        },
                    },
                    {
                        id = "police-radio-penal",
                        title = "PENAL",
                        icon = "icon linear microphone-2",
                        server = false,
                        trigger = "radio:changeFrequency",
                        triggerArgs = { 910 }
                    },
                }
            },
            
        }
    },
}