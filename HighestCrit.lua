HighestCrit = LibStub("AceAddon-3.0"):NewAddon("HighestCrit", "AceEvent-3.0")

HighestCrit:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local t = HighestCrit:CreateFontString(nil, "OVERLAY", "GameTooltipText")

local defaults = {
  profile = {
    setting = true,
    critAmt = 0,
    displayFont = "fonts/2002.ttf",
    displayFontSize = 20,
    displayFontStyle = "OUTLINE",
  },
}

local playerName, _ = UnitName("player")

function HighestCrit:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("HighestCritDB", defaults, true)
  self.db:SetProfile(playerName)
  t:SetPoint("CENTER", 0, 0)
  t:SetFont(self.db.profile.displayFont, self.db.profile.displayFontSize, self.db.profile.displayFontStyle)
  t:SetText("Highest Crit: ".. self.db.profile.critAmt)
end

function HighestCrit:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
  local _, subevent, _, _, sourceName = CombatLogGetCurrentEventInfo()
  if sourceName == playerName and string.find(subevent, "DAMAGE") then
    local amount, _, _, _, _, _, critical = select(15, CombatLogGetCurrentEventInfo())
    if critical == true and amount > self.db.profile.critAmt then
      self.db.profile.critAmt = amount
      t:SetText("Highest Crit: ".. self.db.profile.critAmt)
    end
  end
end