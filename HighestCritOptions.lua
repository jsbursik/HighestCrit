local screenWidth, screenHeight = GetPhysicalScreenSize()

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