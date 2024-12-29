local screenWidth, screenHeight = GetPhysicalScreenSize()

HCOptions = {
  name = "HighestCrit",
  handler = HighestCrit,
  type = "group",
  childGroups = "tab",
  args = {
    fontOptions = {
      name = "Font Options",
      type = "group",
      args = {
        font = {
          name = "Font",
          desc = "Set the font you would like to use",
          type = "select",
          dialogControl = "LSM30_Font",
          values = LSM:HashTable("font"),
          get = "getFont",
          set = "setFont",
        },
        fontSize = {
          name = "Font Size",
          desc = "Set the font size you would like to use",
          type = "range",
          min = 10,
          max = 100,
          step = 1,
          isPercent = false,
          set = "SetFontSize",
          get = "GetFontSize",
        }
      }
    },
    posOptions = {
      name = "Position Settings",
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
      }
    },
    soundOptions = {
      name = "Sound Options",
      type = "group",
      args = {
        toggle = {
          name = "Play Sound",
          desc = "Toggle whether sound plays when triggered",
          type = "toggle",
          set = "SetPlaySound",
          get = "GetPlaySound",
        },
        sound = {
          name = "Sound",
          desc = "Sound to play when triggered",
          type = "select",
          dialogControl = "LSM30_Sound",
          values = LSM:HashTable("sound"),
          set = "SetSound",
          get = "GetSound",
        }
      }
    }
  }
}

-- Set & Get for Crit Display Xp position

function HighestCrit:SetXPos(info, value)
  self.XPos = value
  self.db.profile.XPos = self.XPos
  HighestCrit:UpdateFrame()
end

function HighestCrit:GetXPos(info)
  return self.XPos
end

-- Set & Get for Crit Display Y position

function HighestCrit:SetYPos(info, value)
  self.YPos = value
  self.db.profile.YPos = self.YPos
  HighestCrit:UpdateFrame()
end

function HighestCrit:GetYPos(info)
  return self.YPos
end

-- Set & Get for Font choice

function HighestCrit:setFont(info, value)
  self.fontName = value
  self.font = LSM:Fetch("font", value)
  self.db.profile.font = self.font
  HighestCrit:UpdateFrame()
end

function HighestCrit:getFont(info)
  return self.fontName
end

-- Set & Get for Font size

function HighestCrit:SetFontSize(info, value)
  self.fontSize = value
  self.db.profile.fontSize = self.fontSize
  HighestCrit:UpdateFrame()
end

function HighestCrit:GetFontSize(info)
  return self.fontSize
end

-- Set & Get Sound Toggle

function HighestCrit:SetPlaySound(info, value)
  self.playSound = value
  self.db.profile.playSound = self.playSound
end

function HighestCrit:GetPlaySound(info)
  return self.playSound
end

-- Set & Get Sound to play if triggered

function HighestCrit:SetSound(info, value)
  self.soundName = value
  self.sound = LSM:Fetch("sound", value)
  self.db.profile.sound = self.sound
end

function HighestCrit:GetSound(info)
  return self.soundName
end