-- This addon is based on  -  https://github.com/FrostShock/myDPS

local KCFrame = CreateFrame("Frame", "KCFrame", UIParent)

KCFrame:SetWidth(180)
KCFrame:SetHeight(60)
KCFrame:SetPoint("CENTER", UIParent)
KCFrame:EnableMouse(true)
KCFrame:SetMovable(true)

KCFrame:SetScript("OnMouseDown", function()
  if arg1 == "LeftButton" then
    this:StartMoving()
  else
--    DEFAULT_CHAT_FRAME:AddMessage("The mobs you killed: "..KCMobs.." - "..string.len(KCMobs))
    DEFAULT_CHAT_FRAME:AddMessage("The mobs you killed: "..KCMobs)
  end
end)

KCFrame:SetScript("OnMouseUp", function()
  if arg1 == "LeftButton" then
    this:StopMovingOrSizing()
  end
end)

KCFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 0, right = 0, top = 0, bottom = 0 }});

local tex = KCFrame:CreateTexture(nil, "BACKGROUND")
tex:SetAllPoints()
tex:SetTexture(1, 1, 1, 0.1)

-----------------------------------------------------

local textFrame = CreateFrame("Frame", nil, UIParent)
textFrame:SetWidth(1)
textFrame:SetHeight(1)
textFrame:SetPoint("CENTER", KCFrame)
-- textFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
textFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")

-----------------------------------------------------

local textFrameText = textFrame:CreateFontString()
textFrameText:SetPoint("CENTER", textFrame)
-- https://wowwiki-archive.fandom.com/wiki/API_FontInstance_SetFont   -   Flags   -   "OUTLINE"   -   "THICKOUTLINE"   -   "MONOCHROME"   -   "OUTLINE, MONOCHROME"
-- https://classic.wowhead.com/guides/changing-wow-text-font   -   skurri.ttf   -   ARIALN.ttf   -   MORPHEUS.ttf   -   FRIZQT__.ttf
textFrameText:SetFont("Fonts\\FRIZQT__.ttf", 17)
textFrameText:SetTextColor(0, 0, 0.4)
-- textFrameText:SetFont("Interface\\AddOns\\myDPS\\Fonts\\Ubuntu-R.ttf", 16, "OUTLINE")
-- textFrameText:SetTextColor(0.1490, 0.5451, 0.8235)

-----------------------------------------------------

textFrame:SetScript("OnEvent", function()
--  DEFAULT_CHAT_FRAME:AddMessage(event.." - "..type(event))
--  DEFAULT_CHAT_FRAME:AddMessage(arg1)
  if event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
    if (string.find(arg1, "You have slain ")) then
      KillCounter = KillCounter + 1
      textFrameText:SetText("Mobs killed: "..KillCounter)
       _,_,KCMob = string.find(arg1, "You have slain (.*)!")
       if KCMobs ~= "" then
         KCMobs = KCMobs..", "..KCMob
         KCpos,_,_ = string.find(KCMobs, ",")
         if string.len(KCMobs) > 500 then
           _,_,KCMobs = string.find(KCMobs, ", (.*)")
         end
       else
         KCMobs = KCMobs..KCMob
       end
--       DEFAULT_CHAT_FRAME:AddMessage("The mobs you killed: "..KCMobs)
    end
  end
end)

KillCounter = 0
KCMobs = ""

--  if you want more details then uncomment the next line
-- KCdetails=1
