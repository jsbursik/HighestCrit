HighestCrit = LibStub("AceAddon-3.0"):NewAddon("HighestCrit", "AceEvent-3.0")

CritFrame = CreateFrame("Frame", nil, UIParent)
CritText = CritFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
CritText:SetPoint("CENTER", 0, 0)

local defaults = {
  profile = {
    setting = true,
    critAmt = 0,
    displayFont = "fonts/2002.ttf",
    displayFontSize = 20,
    displayFontStyle = "OUTLINE",
    XPos = 0,
    YPos = 0,
  },
}

local playerName, _ = UnitName("player")

function HighestCrit:OnInitialize()
  LibStub("AceConfig-3.0"):RegisterOptionsTable("HighestCrit", HCOptions)
  self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HighestCrit", "HighestCrit")
  self.db = LibStub("AceDB-3.0"):New("HighestCritDB", defaults, true)
  self.db:SetProfile(playerName)
  self.XPos = self.db.profile.XPos
  self.YPos = self.db.profile.YPos
  CritFrame:SetPoint("CENTER", self.db.profile.XPos, self.db.profile.YPos)
  self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  CritText:SetFont(self.db.profile.displayFont, self.db.profile.displayFontSize, self.db.profile.displayFontStyle)
  CritText:SetText("Highest Crit: ".. self.db.profile.critAmt)
  CritFrame:SetSize(CritText:GetStringWidth(), CritText:GetStringHeight())
end

function HighestCrit:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
  local _, subevent, _, _, sourceName = CombatLogGetCurrentEventInfo()
  if sourceName == playerName and string.find(subevent, "DAMAGE") then
    local amount, _, _, _, _, _, critical = select(15, CombatLogGetCurrentEventInfo())
    if critical == true and amount > self.db.profile.critAmt then
      self.db.profile.critAmt = amount
      CritText:SetText("Highest Crit: ".. self.db.profile.critAmt)
      CritFrame:SetSize(CritText:GetStringWidth(), CritText:GetStringHeight())
    end
  end
end