<div align="center">

# discord.luau

discord.luau is library that uses websockets to control a discord client.

</div>

## Documentation
### library:focusApp()
Focuses application.
```lua
library:focusApp()
```

### library:invite(invCode)
Joins a server using an invite code.
```lua
library:invite("cats")
```

### library:deepLink(type: string, guildId: string?, channelId: string?, messageId: string?, search: string?)

Opens app on a specific page.
```lua
library:deepLink("channel", "@me")
```

### library:getAttachment(messageLink)
Gets the attachment from a message link.
```lua
library:getAttachment("https://discord.com/channels/1234567890/1234567890/1234567890.lua")
```

### library:widgetInfo(guildId)
Gets the widget info for a server.
```lua
library:widgetInfo("1234567890")
```

### library:openGift(giftId)
Opens a gift.
```lua
library:openGift("1234567890")
```
