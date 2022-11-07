local httpService = game :GetService "HttpService"
local request = syn and syn.request or http_request
    or http and http.request or request

local Discord: table = {
    Webhook = {};
}

function Discord:FocusApp()
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

function Discord:Invite(invCode: string)
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

function Discord:Focus(guildId: string?, channelId: string?, messageId: string?)
    return self :deepLink("Channel", guildId, channelId, messageId)
end

return Discord
