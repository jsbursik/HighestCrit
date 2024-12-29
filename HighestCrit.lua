HighestCrit = LibStub("AceAddon-3.0"):NewAddon("HighestCrit", "AceEvent-3.0", "AceConsole-3.0")

LSM = LibStub("LibSharedMedia-3.0")
LSM:Register("sound", "Wow", "Interface\\Addons\\HighestCrit\\Media\\Sounds\\wow.mp3")

CritFrame = CreateFrame("Frame", nil, UIParent)
CritText = CritFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")

local defaults = {
  profile = {
    font = "fonts/2002.ttf",
    fontName = "2002",
    fontSize = 20,
    fontStyle = "OUTLINE",
    XPos = 0,
    YPos = 0,
    playSound = true,
    sound = LSM:Fetch("sound", "Wow"),
    soundName = "Wow",
  },
  char = {
    critAmt = 0,
  }
}

local playerName, _ = UnitName("player")

function HighestCrit:OnInitialize()
  LibStub("AceConfig-3.0"):RegisterOptionsTable("HighestCrit", HCOptions)
  self.db = LibStub("AceDB-3.0"):New("HighestCritDB", defaults, true)
  self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HighestCrit", "Highest Crit")
  

  for k,v in pairs(self.db.profile) do
    self[k] = v
  end

  self.critAmt = self.db.char.critAmt
  
  HighestCrit:UpdateFrame()

  HighestCrit:RegisterChatCommand("hcrit", function()
    LibStub("AceConfigDialog-3.0"):Open("HighestCrit")
  end)

  self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function HighestCrit:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
  local _, subevent, _, _, sourceName = CombatLogGetCurrentEventInfo()
  if sourceName == playerName and string.find(subevent, "DAMAGE") then
    local amount, _, _, _, _, _, critical = select(15, CombatLogGetCurrentEventInfo())
    if critical == true and amount > self.db.char.critAmt then
      self.critAmt, self.db.char.critAmt = amount, amount
      self:UpdateFrame()
      
      if self.db.profile.playSound == true then
        PlaySoundFile(self.db.profile.sound, "SFX")
      end
      
      HCBounceAnim:Play()
      ColorFade(4, 0, 1)
    end
  end
end

function HighestCrit:UpdateFrame()
  CritFrame:SetPoint("CENTER", self.XPos, self.YPos)
  CritText:SetPoint("CENTER", 0,0)
  CritText:SetFont(self.font, self.fontSize, self.fontStyle)
  CritText:SetText("Highest Crit: ".. self.critAmt)
  CritFrame:SetSize(CritText:GetStringWidth(), CritText:GetStringHeight())
end