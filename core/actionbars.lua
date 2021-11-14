---------------------------------------
-- VARIABLES
---------------------------------------

--get the addon namespace
local addon, ns = ...

--get the config values
local cfg = ns.cfg

local dominos = IsAddOnLoaded("Dominos")
local bartender4 = IsAddOnLoaded("Bartender4")

--backdrop settings
local bgfile, edgefile = "", ""
if cfg.background.showshadow then
  edgefile = cfg.textures.outer_shadow
end
if cfg.background.useflatbackground and cfg.background.showbg then
  bgfile = cfg.textures.buttonbackflat
end

--backdrop
local backdrop1 = {
  bgFile = bgfile,
  edgeFile = edgefile,
  tile = false,
  tileSize = 32,
  edgeSize = cfg.background.inset,
  insets = {
    left = cfg.background.inset,
    right = cfg.background.inset,
    top = cfg.background.inset,
    bottom = cfg.background.inset
  }
}

---------------------------------------
-- FUNCTIONS
---------------------------------------

if IsAddOnLoaded("Masque") and (dominos or bartender4) then
  return
end

local function ApplyBackground(bu)
  if not bu or (bu and bu.bg) then
    return
  end
  -- shadows+background
  if bu:GetFrameLevel() < 1 then
    bu:SetFrameLevel(1)
  end
  if cfg.background.showbg or cfg.background.showshadow then
    bu.bg = CreateFrame("Frame", nil, bu)
    -- bu.bg:SetAllPoints(bu)
    bu.bg:SetPoint("TOPLEFT", bu, "TOPLEFT", -4, 4)
    bu.bg:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", 4, -4)
    bu.bg:SetFrameLevel(bu:GetFrameLevel() - 1)

    if cfg.background.showbg and not cfg.background.useflatbackground then
      local t = bu.bg:CreateTexture(nil, "BACKGROUND", -8)
      t:SetTexture(cfg.textures.buttonback)
      --t:SetAllPoints(bu)
      t:SetVertexColor(
        cfg.background.backgroundcolor.r,
        cfg.background.backgroundcolor.g,
        cfg.background.backgroundcolor.b,
        cfg.background.backgroundcolor.a
      )
    end

    bu.bg.Backdrop = CreateFrame("Frame", "Backdrop", bu.bg, BackdropTemplateMixin and "BackdropTemplate")
    bu.bg.Backdrop:SetAllPoints()
    bu.bg.Backdrop:SetBackdrop(backdrop1)

    if cfg.background.useflatbackground then
      bu.bg:SetBackdropColor(
        cfg.background.backgroundcolor.r,
        cfg.background.backgroundcolor.g,
        cfg.background.backgroundcolor.b,
        cfg.background.backgroundcolor.a
      )
    end
    if cfg.background.showshadow then
      bu.bg.Backdrop:SetBackdropBorderColor(
        cfg.background.shadowcolor.r,
        cfg.background.shadowcolor.g,
        cfg.background.shadowcolor.b,
        cfg.background.shadowcolor.a
      )
    end
  end
end

-- style leave button
local function StyleLeaveButton(bu)
  if not bu or (bu and bu.rabs_styled) then
    return
  end
  local name = bu:GetName()
  local nt = bu:GetNormalTexture()
  local bo = bu:CreateTexture(name .. "Border", "BACKGROUND", nil, -7)
  nt:SetTexCoord(0.2, 0.8, 0.2, 0.8)
  nt:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
  nt:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
  bo:SetTexture(cfg.textures.normal)
  bo:SetTexCoord(0, 1, 0, 1)
  bo:SetDrawLayer("BACKGROUND", -7)
  bo:SetVertexColor(0.4, 0.35, 0.35)
  bo:ClearAllPoints()
  bo:SetAllPoints(bu)
  --shadows+background
  if not bu.bg then
    ApplyBackground(bu)
  end
  bu.rabs_styled = true
end

-- style bags
local function StyleBag(bu)
  if not bu or (bu and bu.rabs_styled) then
    return
  end
  local name = bu:GetName()
  local ic = _G[name .. "IconTexture"]
  local nt = _G[name .. "NormalTexture"]
  nt:SetTexCoord(0, 1, 0, 1)
  nt:SetDrawLayer("BACKGROUND", -7)
  nt:SetVertexColor(0.4, 0.35, 0.35)
  nt:SetAllPoints(bu)
  local bo = bu.IconBorder
  bo:Hide()
  bo.Show = function()
  end
  ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
  ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
  ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)
  bu:SetNormalTexture(cfg.textures.normal)
  --bu:SetHighlightTexture(cfg.textures.hover)
  bu:SetPushedTexture(cfg.textures.pushed)
  --bu:SetCheckedTexture(cfg.textures.checked)

  --make sure the normaltexture stays the way we want it
  hooksecurefunc(
    bu,
    "SetNormalTexture",
    function(self, texture)
      if texture and texture ~= cfg.textures.normal then
        self:SetNormalTexture(cfg.textures.normal)
      end
    end
  )
  bu.Back = CreateFrame("Frame", nil, bu)
  bu.Back:SetPoint("TOPLEFT", bu, "TOPLEFT", -4, 4)
  bu.Back:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", 4, -4)
  bu.Back:SetFrameLevel(bu:GetFrameLevel() - 1)

  bu.Back.Backdrop = CreateFrame("Frame", "Backdrop", bu.Back, BackdropTemplateMixin and "BackdropTemplate")
  bu.Back.Backdrop:SetAllPoints()
  bu.Back.Backdrop:SetBackdrop(backdrop1)
  bu.Back.Backdrop:SetBackdropBorderColor(0, 0, 0, 0.9)
end

local function SetFontAndPosition(parent, button, font, fontSize, coords1, coords2)
  if button == nil then
    return
  end
  button:SetFont(font, fontSize, "OUTLINE")
  button:ClearAllPoints()
  button:SetPoint(coords1.a1, parent, coords1.x, coords1.y)
  if (coords2 ~= nil) then
    button:SetPoint(coords2.a1, parent, coords2.x, coords2.y)
  end
end

local function StyleButtons(actionBar, buttonCount)
  if not actionBar then
    return
  end
  if not buttonCount then
    return
  end

  for i = 1, buttonCount do
    local button = _G[actionBar .. i]
    if not button then
      return
    end

    -- hide border stuff
    _G[actionBar .. i .. "Border"]:SetTexture(nil)
    _G[actionBar .. i .. "FlyoutBorder"]:SetTexture(nil)
    _G[actionBar .. i .. "FlyoutBorderShadow"]:SetTexture(nil)
    local fbg = _G[actionBar .. i .. "FloatingBG"]
    if fbg then
      fbg:Hide()
    end

    _G[actionBar .. i .. "Flash"]:SetTexture(cfg.textures.flash)
    _G[actionBar .. i]:SetPushedTexture(cfg.textures.pushed)
    _G[actionBar .. i]:SetNormalTexture(cfg.textures.normal)
    _G[actionBar .. i .. "NormalTexture"]:SetVertexColor(
      cfg.actionbar_colors.normal.r,
      cfg.actionbar_colors.normal.g,
      cfg.actionbar_colors.normal.b,
      1
    )
    _G[actionBar .. i .. "NormalTexture"]:SetAllPoints(button)
    -- stance bar buttons have this additional texture i guess
    local text2 = _G[actionBar .. i .. "NormalTexture2"]
    if text2 then
      text2:SetAllPoints(button)
      text2:SetVertexColor(
        cfg.actionbar_colors.normal.r,
        cfg.actionbar_colors.normal.g,
        cfg.actionbar_colors.normal.b,
        1
      )
    end

    -- item stacks
    SetFontAndPosition(button, _G[actionBar .. i .. "Count"], cfg.font, cfg.itemcount.fontsize, cfg.itemcount.pos1, nil)

    --hotkeys
    if (cfg.hotkeys.show) then
      local k = _G[actionBar .. i .. "HotKey"]
      SetFontAndPosition(button, k, cfg.font, cfg.hotkeys.fontsize, cfg.hotkeys.pos1, cfg.hotkeys.pos2)
    else
      _G[actionBar .. i .. "HotKey"]:SetAlpha(0)
    end

    --macro names
    if (cfg.macroname.show) then
      local k = _G[actionBar .. i .. "Name"]
      SetFontAndPosition(button, k, cfg.font, cfg.macroname.fontsize, cfg.macroname.pos1, cfg.macroname.pos2)
    else
      _G[actionBar .. i .. "Name"]:SetAlpha(0)
    end

    -- background
    if not button.bg then
      ApplyBackground(button)
    end

    --cut the default border of the icons and make them shiny
    local ic = _G[actionBar .. i .. "Icon"]
    ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    ic:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
    ic:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
    -- --adjust the cooldown frame
    local cd = _G[actionBar .. i .. "Cooldown"]
    cd:SetPoint("TOPLEFT", button, "TOPLEFT", cfg.cooldown.spacing, -cfg.cooldown.spacing)
    cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -cfg.cooldown.spacing, cfg.cooldown.spacing)
    -- --apply equipped action colors
    local action = button.action
    if action and IsEquippedAction(action) then
      _G[actionBar .. i .. "NormalTexture"]:SetVertexColor(
        cfg.actionbar_colors.equipped.r,
        cfg.actionbar_colors.equipped.g,
        cfg.actionbar_colors.equipped.b,
        1
      )
    end

    --make sure the normaltexture stays the way we want it
    hooksecurefunc(
      button,
      "SetNormalTexture",
      function(self, texture)
        if texture and texture ~= cfg.textures.normal then
          self:SetNormalTexture(cfg.textures.normal)
        end
      end
    )
  end
end

---------------------------------------
-- INIT
--------------------------------------
local function init()
  StyleButtons("ActionButton", NUM_ACTIONBAR_BUTTONS)
  StyleButtons("MultiBarBottomLeftButton", NUM_ACTIONBAR_BUTTONS)
  StyleButtons("MultiBarBottomRightButton", NUM_ACTIONBAR_BUTTONS)
  StyleButtons("MultiBarLeftButton", NUM_ACTIONBAR_BUTTONS)
  StyleButtons("MultiBarRightButton", NUM_ACTIONBAR_BUTTONS)

  -- possess bar?
  StyleButtons("OverrideActionBarButton", NUM_ACTIONBAR_BUTTONS)

  StyleButtons("PetActionButton", NUM_PET_ACTION_SLOTS)
  StyleButtons("StanceButton", NUM_STANCE_SLOTS)

  --style bags
  StyleBag(MainMenuBarBackpackButton)
  for i = 0, 3 do
    StyleBag(_G["CharacterBag" .. i .. "Slot"])
  end

  --style leave button
  StyleLeaveButton(MainMenuBarVehicleLeaveButton)
  StyleLeaveButton(rABS_LeaveVehicleButton)
end

---------------------------------------
-- CALL
---------------------------------------

local a = CreateFrame("Frame")
a:RegisterEvent("PLAYER_ENTERING_WORLD")
a:SetScript("OnEvent", init)
