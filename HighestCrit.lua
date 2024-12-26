-- Just log combat events so I can monitor everything

local function OnEvent(self, event, ...)
  print(event, ...)
end

local f = createFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT")
f:SetScript("OnEvent", OnEvent)