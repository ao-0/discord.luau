local httpService = game:GetService "HttpService"
local jsonEncode, generateGuid, jsonDecode = httpService.JSONEncode, httpService.GenerateGUID, httpService.JSONDecode
local request = syn and syn.request or http_request or http and http.request or request

type WidgetInfo = {
    id: string,
    name: string,
    instant_invite: string,
    channels: Array,
    members: Array,
    presence_count: number,
}

type Discord = {
    focusApp = () -> void,
    invite = (string) -> void,
    deepLink = (string) -> void,
    getAttachment = (string) -> string,
    widgetInfo = (string) -> WidgetInfo,
    openGift = (string) -> void
}

local Library: Discord = {};

function Library:focusApp()
    return request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = jsonEncode(httpService, {
            cmd = "BROWSER_HANDOFF", args = {},
            nonce = generateGuid(httpService, false)
        })
    }
end

function Library:invite(code)
    return request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = jsonEncode(httpService, {
            cmd = "INVITE_BROWSER", args = {code = code},
            nonce = generateGuid(httpService, false)
        })
    }
end

function Library:deepLink(type, params)
    return request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = jsonEncode(httpService, {
            cmd = "DEEP_LINK", args = {type = type:upper(), params = params},
            nonce = generateGuid(httpService, false)
        })
    }
end

function library:getAttachment(messageLink)
    return request {
        Url = messageLink,
        Method = "GET", Headers = {
            ["Content-Type"] = "application/json"
        }
    }.Body
end

function Library:widgetInfo(id)
    local info: WidgetInfo = jsonDecode(httpService, request {
        Url = "https://discord.com/api/v8/guilds/" .. id .. "/widget.json",
        Method = "GET", Headers = {
            ["Content-Type"] = "application/json"
        }
    }.Body)

    return info
end

function Library:openGift(code)
    return request {
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST", Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        }, Body = jsonEncode(httpService, {
            cmd = "GIFT_CODE_BROWSER", args = {code = giftId},
            nonce = generateGuid(httpService, false)
        })
    }
end

return Library
