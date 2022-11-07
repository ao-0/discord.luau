local httpService = game :GetService "HttpService"
local request = syn and syn.request or http_request
    or http and http.request or request

local Discord: table = {
    webhook = {color={}};
}

function Discord:focusApp()
    local Response = request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = httpService :JSONEncode {
            cmd = "BROWSER_HANDOFF", args = {},
            nonce = httpService :GenerateGUID(false)
        }
    }

    return Response
end

function Discord:invite(invCode: string)
    local Response = request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = httpService :JSONEncode {
            cmd = "INVITE_BROWSER", args = {code = invCode},
            nonce = httpService :GenerateGUID(false)
        }
    }

    return Response
end

function Discord:deepLink(type: string, guildId: string?, channelId: string?, messageId: string?, search: string?)
    local Response = request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = httpService :JSONEncode {
            cmd = "DEEP_LINK", args = {
                type = string.upper(type),
                params = {
                    guildId = guildId or "@me",
                    channelId = channelId or "",
                    messageId = messageId or "",
                    search = search or "",
                    fingerprint = httpService :GenerateGUID(false)
                }
            }, nonce = httpService :GenerateGUID(false)
        }
    }

    return Response 
end

function Discord:focus(guildId: string?, channelId: string?, messageId: string?)
    return self :deepLink("Channel", guildId, channelId, messageId)
end

function Discord.webhook.color:fromHex(hex: string)
    local r, g, b = hex :match "(%x%x)(%x%x)(%x%x)"
    return tonumber(r, 16) * 65536 + tonumber(g, 16) * 256 + tonumber(b, 16) 
end

function Discord.webhook.color:fromRGB(r: number, g: number, b: number)
    return r * 65536 + g * 256 + b
end

return Discord
