local httpService = game:GetService "HttpService"
local request = syn and syn.request or http_request
    or http and http.request or request

local library = {}
function library:focusApp()
    return request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = httpService :JSONEncode {
            cmd = "BROWSER_HANDOFF", args = {},
            nonce = httpService :GenerateGUID(false)
        }
    }
    
    return response
end

function library:invite(invCode)
    return request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = httpService :JSONEncode {
            cmd = "INVITE_BROWSER", args = {code = invCode},
            nonce = httpService :GenerateGUID(false)
        }
    }

    return response
end

function library:deepLink(type, guildId, channelId, messageId, search)
    return request {
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
end

function library:getAttachment(messageLink)
    return request {
        Url = messageLink,
        Method = "GET", Headers = {
            ["Content-Type"] = "application/json",
        }
    }.Body
end

function library:widgetInfo(guildId)
    return httpService:JSONDecode(request {
        Url = "https://discord.com/api/v8/guilds/" .. guildId .. "/widget.json",
        Method = "GET", Headers = {
            ["Content-Type"] = "application/json",
        }
    }.Body)
end

function library:focus(guildId, channelId, messageId)
    return self :deepLink("Channel", guildId, channelId, messageId)
end

function library:openGift(giftId)
    return request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = httpService :JSONEncode {
            cmd = "GIFT_CODE_BROWSER", args = {code = giftId},
            nonce = httpService :GenerateGUID(false)
        }
    }
end

return library
