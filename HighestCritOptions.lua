local screenWidth, screenHeight = GetPhysicalScreenSize()

LSM = LibStub("LibSharedMedia-3.0")

HCOptions = {
  name = "HighestCrit",
  handler = HighestCrit,
  type = "group",
  args = {
    posX = {
      name = "X Position",
      desc = "Determine the X position on the screen",
      type = "range",
      min = 0 - screenWidth / 2,
      max = screenWidth / 2,
      step = 1,
      isPercent = false,
      set = "SetXPos",
      get = "GetXPos",
    },
    posY = {
      name = "Y Position",
      desc = "Determine the Y position on the screen",
      type = "range",
      min = 0 - screenHeight / 2,
      max = screenHeight / 2,
      step = 1,
      isPercent = false,
      set = "SetYPos",
      get = "GetYPos",
    },
    font = {
      name = "Font",
      desc = "Set the font you would like to use",
      type = "select",
      dialogControl = "LSM30_Font",
      values = LSM:HashTable("font"),
      get = "getFont",
      set = "setFont",
    }
  }
}

function HighestCrit:SetXPos(info, value)
  self.XPos = value
  self.db.profile.XPos = self.XPos
  CritFrame:SetPoint("CENTER", self.XPos, self.YPos)
end

function HighestCrit:GetXPos(info)
  return self.XPos
end

function HighestCrit:SetYPos(info, value)
  self.YPos = value
  self.db.profile.YPos = self.YPos
  CritFrame:SetPoint("CENTER", self.XPos, self.YPos)
end

function HighestCrit:GetYPos(info)
  return self.YPos
end

function HighestCrit:setFont(info, value)
  self.displayFont = LSM:Fetch("font", value)
  self.db.profile.displayFont = self.displayFont
  CritText:SetFont(self.displayFont, self.db.profile.displayFontSize, self.db.profile.displayFontStyle)
  CritFrame:SetSize(CritText:GetStringWidth(), CritText:GetStringHeight())
end

function HighestCrit:getFont(info)
  return self.displayFont
end