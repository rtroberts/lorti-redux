--get the addon namespace
local addon, ns = ...
--get the config values
local cfg = ns.cfg

---------------------------------------
-- LOCALS
---------------------------------------

--rewrite the oneletter shortcuts
if cfg.adjustOneletterAbbrev then
  HOUR_ONELETTER_ABBR = "%dh"
  DAY_ONELETTER_ABBR = "%dd"
  MINUTE_ONELETTER_ABBR = "%dm"
  SECOND_ONELETTER_ABBR = "%ds"
end

--backdrop debuff
local backdropDebuff = {
  bgFile = nil,
  edgeFile = cfg.debuffFrame.background.edgeFile,
  tile = false,
  tileSize = 32,
  edgeSize = cfg.debuffFrame.background.inset,
  insets = {
    left = cfg.debuffFrame.background.inset,
    right = cfg.debuffFrame.background.inset,
    top = cfg.debuffFrame.background.inset,
    bottom = cfg.debuffFrame.background.inset
  }
}

--backdrop buff
local backdropBuff = {
  bgFile = nil,
  edgeFile = cfg.buffFrame.background.edgeFile,
  tile = false,
  tileSize = 32,
  edgeSize = cfg.buffFrame.background.inset,
  insets = {
    left = cfg.buffFrame.background.inset,
    right = cfg.buffFrame.background.inset,
    top = cfg.buffFrame.background.inset,
    bottom = cfg.buffFrame.background.inset
  }
}

local ceil, min, max = ceil, min, max

---------------------------------------
-- FUNCTIONS
---------------------------------------

--apply aura frame texture func
local function applySkin(b)
  if not b or (b and b.styled) then
    return
  end
  --button name
  local name = b:GetName()
  --check the button type
  local tempenchant, debuff, buff = false, false, false
  if (name:match("TempEnchant")) then
    tempenchant = true
  elseif (name:match("Debuff")) then
    debuff = true
  else
    buff = true
  end
  --get cfg and backdrop
  local cfg, backdrop1
  if debuff then
    cfg = ns.cfg.debuffFrame
    backdrop1 = backdropDebuff
  else
    cfg = ns.cfg.buffFrame
    backdrop1 = backdropBuff
  end

  --button
  if tempenchant then
    local tempenchantsize = cfg.button.size * cfg.tempEnchantScalar
    b:SetSize(tempenchantsize, tempenchantsize)
  else
    b:SetSize(cfg.button.size, cfg.button.size)
  end

  --icon
  local icon = _G[name .. "Icon"]
  -- something about a banner?
  -- if select(1, UnitFactionGroup("player")) == "Alliance" then
  --   icon:SetTexture(select(3, GetSpellInfo(61573)))
  -- elseif select(1, UnitFactionGroup("player")) == "Horde" then
  --   icon:SetTexture(select(3, GetSpellInfo(61574)))
  -- end
  icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
  icon:ClearAllPoints()
  icon:SetPoint("TOPLEFT", b, "TOPLEFT", -cfg.icon.padding, cfg.icon.padding)
  icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", cfg.icon.padding, -cfg.icon.padding)
  icon:SetDrawLayer("BACKGROUND", -8)
  b.icon = icon

  --border
  local border = _G[name .. "Border"] or b:CreateTexture(name .. "Border", "BACKGROUND", nil, -7)
  border:SetTexture(cfg.border.texture)
  border:SetTexCoord(0, 1, 0, 1)
  border:SetDrawLayer("BACKGROUND", -7)
  if tempenchant then
    border:SetVertexColor(0.7, 0, 1)
  elseif not debuff then
    border:SetVertexColor(cfg.border.color.r, cfg.border.color.g, cfg.border.color.b)
  end
  border:ClearAllPoints()
  border:SetAllPoints(b)
  b.border = border

  --duration
  b.duration:SetFont(cfg.duration.font, cfg.duration.size, "THINOUTLINE")
  b.duration:ClearAllPoints()
  b.duration:SetPoint(cfg.duration.pos.a1, cfg.duration.pos.x, -12)

  --count
  b.count:SetFont(cfg.count.font, cfg.count.size, "THINOUTLINE")
  b.count:ClearAllPoints()
  b.count:SetPoint(cfg.count.pos.a1, cfg.count.pos.x, cfg.count.pos.y)

  --shadow
  if cfg.background.show then
    local back = CreateFrame("Frame", nil, b, BackdropTemplateMixin and "BackdropTemplate")
    back:SetPoint("TOPLEFT", b, "TOPLEFT", -cfg.background.padding, cfg.background.padding)
    back:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", cfg.background.padding, -cfg.background.padding)
    back:SetFrameLevel(b:GetFrameLevel() - 1)
    back:SetBackdrop(backdrop1)
    back:SetBackdropBorderColor(cfg.background.color.r, cfg.background.color.g, cfg.background.color.b)
    b.bg = back
  end

  --set button styled variable
  b.styled = true
end

--update debuff anchors
local function updateDebuffAnchors(buttonName, index)
  local button = _G[buttonName .. index]
  if not button then
    return
  end
  --apply skin
  if not button.styled then
    applySkin(button)
  end
end

--update buff anchors
local function updateAllBuffAnchors()
  --loop on all active buff buttons
  for i = 1, BUFF_ACTUAL_DISPLAY do
    local button = _G["BuffButton" .. i]
    if not button then
      return
    end
    --apply skin
    if not button.styled then
      print(button:GetName())
      applySkin(button)
    end
  end
end

---------------------------------------
-- INIT
---------------------------------------

--temp enchant stuff
applySkin(TempEnchant1)
applySkin(TempEnchant2)
applySkin(TempEnchant3)

--hook Blizzard functions
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", updateAllBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", updateDebuffAnchors)
