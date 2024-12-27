local f = CreateFrame("Frame", nil, UIParent)
local t = f:CreateFontString(nil, "OVERLAY", "GameTooltipText")
f:SetSize(100, 50)
f:SetPoint("TOP", 0, -100)
t:SetPoint("CENTER", 0, 0)
t:SetFont("fonts/2002.ttf", 20, "OUTLINE")

function f:OnEvent(event, ...)
  self[event](self, event, ...)
end

-- Handle any initialization here
function f:ADDON_LOADED(event, addOnName)
  if addOnName == "HighestCrit" then
    HighestCritDB = HighestCritDB or {}
    HighestCritDB.amt = HighestCritDB.amt or 0
    t:SetText("Highest Crit: ".. tostring(HighestCritDB.amt))
  end
end

-- Any subevent that includes "DAMAGE" done by the player gets checked if it's a crit
function f:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
  local _, subevent, _, _, sourceName = CombatLogGetCurrentEventInfo()
  local playerName, _ = UnitName("player")
  if sourceName == playerName and string.find(subevent, "DAMAGE") ~= nil then
    local amount, _, _, _, _, _, critical = select(15, CombatLogGetCurrentEventInfo())
    if critical == true and amount > HighestCritDB.amt then
      HighestCritDB.amt = amount
      t:SetText("Highest Crit: ".. HighestCritDB.amt)
    end
  end
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", f.OnEvent)


