HCBounceAnim = CritFrame:CreateAnimationGroup()

local b1 = HCBounceAnim:CreateAnimation("Translation")
b1:SetOffset(0, -32)
b1:SetDuration(0.1)
b1:SetOrder(1)
b1:SetSmoothing("IN")

local b2 = HCBounceAnim:CreateAnimation("Translation")
b2:SetOffset(0, 64)
b2:SetDuration(0.1)
b2:SetOrder(2)
b2:SetSmoothing("IN")

local b3 = HCBounceAnim:CreateAnimation("Translation")
b3:SetOffset(0, -48)
b3:SetDuration(0.1)
b3:SetOrder(3)
b3:SetSmoothing("IN")

local b4 = HCBounceAnim:CreateAnimation("Translation")
b4:SetOffset(0, 16)
b4:SetDuration(0.1)
b4:SetOrder(4)
b4:SetSmoothing("OUT")

function ColorFade(fSpeed, eTime, fDir)
  local fadeSpeed, elapsedTime, fadeDirection = fSpeed, eTime, fDir
  CritFrame:SetScript("OnUpdate", function(self, delta)
    elapsedTime = elapsedTime + delta * fadeSpeed

    local r = 1
    local g = 1 - elapsedTime * fadeDirection
    local b = 1 - elapsedTime * fadeDirection

    CritText:SetTextColor(r, math.max(0, math.min(g, 1)), math.max(0, math.min(b, 1)))
    
    if elapsedTime >= 1 then
      fadeDirection = -1
      elapsedTime = 0
    elseif elapsedTime >= 1 and fadeDirection == -1 then
      CritFrame:SetScript("OnUpdate", nil)
    end

  end)
end