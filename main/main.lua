Name = nil

local function OnEventFun(self, event, text, playerName)
    Name = playerName
end

local function FormatText(frame)
    local fontstring = frame.String

    if not frame:IsShown() then
        fontstring.lastText = nil
        return
    end

    local text = fontstring:GetText() or ""
    local weight = fontstring:GetWrappedWidth()

    if (not fontstring.lastText) or (text ~= fontstring.lastText) then
        fontstring.lastText = string.format("%s: %s", Name, text)
        fontstring:SetText(fontstring.lastText)
    end

    fontstring:SetWidth(weight)
end

local function FormatBubbles()
    for _, chatBubbleObj in pairs(C_ChatBubbles.GetAllChatBubbles(false)) do
        local chatBubble = chatBubbleObj:GetChildren()
        if chatBubble and chatBubble.String and chatBubble.String:GetObjectType() == "FontString" then
            FormatText(chatBubble)
        end
    end
end

local function OnUpdateFun(frame, elapsed)
    if frame:IsShown() then
        FormatBubbles()
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_SAY")
f:RegisterEvent("CHAT_MSG_YELL")
f:RegisterEvent("CHAT_MSG_PARTY")
f:RegisterEvent("CHAT_MSG_PARTY_LEADER")
f:RegisterEvent("CHAT_MSG_RAID")
f:RegisterEvent("CHAT_MSG_MONSTER_PARTY")
f:RegisterEvent("CHAT_MSG_MONSTER_SAY")
f:RegisterEvent("CHAT_MSG_MONSTER_YELL")
f:SetScript("OnEvent", OnEventFun)
f:SetScript("OnUpdate", OnUpdateFun)
