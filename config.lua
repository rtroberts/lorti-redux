-- // Lorti UI Classic
-- // Lorti - 2016

-----------------------------
-- INIT
-----------------------------

--get the addon namespace
local addon, ns = ...

--generate a holder for the config data
local cfg = CreateFrame("Frame")

-----------------------------
-- CONFIG
-----------------------------

-- frame sizes
cfg.player_frame_scale = 1.0
cfg.target_frame_scale = 1.0
cfg.focus_frame_scale = 1.0
cfg.party_frame_scale = 1.0

-- show/hide endcap gryphon art
cfg.show_gryphons = false

-- swallow error messages? ("not enough mana", "out of range", etc.)
cfg.hide_error_text = true

cfg.textures = {
  normal = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\gloss",
  flash = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\flash",
  hover = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\hover",
  pushed = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\pushed",
  checked = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\checked",
  equipped = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\gloss_grey",
  buttonback = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\button_background",
  buttonbackflat = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\button_background_flat",
  outer_shadow = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\outer_shadow"
}

cfg.background = {
  showbg = true, --show an background image?
  showshadow = true, --show an outer shadow?
  useflatbackground = false, --true uses plain flat color instead
  backgroundcolor = {r = 0.2, g = 0.2, b = 0.2, a = 0.3},
  shadowcolor = {r = 0, g = 0, b = 0, a = 0.9},
  inset = 5
}

cfg.actionbar_colors = {
  normal = {r = 0.37, g = 0.3, b = 0.3},
  equipped = {r = 0.1, g = 0.5, b = 0.1}
}

cfg.hotkeys = {
  show = true,
  fontsize = 12,
  pos1 = {a1 = "TOPRIGHT", x = 0, y = 0},
  pos2 = {a1 = "TOPLEFT", x = 0, y = 0} --important! two points are needed to make the hotkeyname be inside of the button
}

cfg.macroname = {
  show = false,
  fontsize = 12,
  pos1 = {a1 = "BOTTOMLEFT", x = 0, y = 0},
  pos2 = {a1 = "BOTTOMRIGHT", x = 0, y = 0} --important! two points are needed to make the macroname be inside of the button
}

cfg.itemcount = {
  show = true,
  fontsize = 12,
  pos1 = {a1 = "BOTTOMRIGHT", x = 0, y = 0}
}

cfg.cooldown = {
  spacing = 0
}

cfg.font = STANDARD_TEXT_FONT

--adjust the oneletter abbrev?
cfg.adjustOneletterAbbrev = true

--scale of the consolidated tooltip
cfg.consolidatedTooltipScale = 1.2

--combine buff and debuff frame - should buffs and debuffs be displayed in one single frame?
--if you disable this it is intended that you unlock the buff and debuffs and move them apart!
cfg.combineBuffsAndDebuffs = false

-- buff frame settings

cfg.buffFrame = {
  tempEnchantScalar = 0.8, -- reduce the size of temp enchant buffs (wf, poisons, etc)
  pos = {a1 = "TOPRIGHT", af = "Minimap", a2 = "TOPLEFT", x = -35, y = 0},
  gap = 30, --gap between buff and debuff rows
  rowSpacing = 10,
  colSpacing = 7,
  buttonsPerRow = 10,
  button = {
    size = 28
  },
  icon = {
    padding = -2
  },
  border = {
    texture = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\gloss",
    color = {r = 0.4, g = 0.35, b = 0.35}
  },
  background = {
    show = true, --show backdrop
    edgeFile = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\outer_shadow",
    color = {r = 0, g = 0, b = 0, a = 0.9},
    inset = 6,
    padding = 4
  },
  duration = {
    font = STANDARD_TEXT_FONT,
    size = 11,
    pos = {a1 = "BOTTOM", x = 0, y = 0}
  },
  count = {
    font = STANDARD_TEXT_FONT,
    size = 11,
    pos = {a1 = "TOPRIGHT", x = 0, y = 0}
  }
}

-- debuff frame settings

cfg.debuffFrame = {
  pos = {a1 = "TOPRIGHT", af = "Minimap", a2 = "TOPLEFT", x = -35, y = -85},
  gap = 10, --gap between buff and debuff rows
  rowSpacing = 10,
  colSpacing = 7,
  buttonsPerRow = 10,
  button = {
    size = 28
  },
  icon = {
    padding = -2
  },
  border = {
    texture = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\gloss2",
    color = {r = 0.4, g = 0.35, b = 0.35}
  },
  background = {
    show = true, --show backdrop
    edgeFile = "Interface\\AddOns\\Lorti-UI-Classic\\textures\\outer_shadow",
    color = {r = 0, g = 0, b = 0, a = 0.9},
    inset = 6,
    padding = 4
  },
  duration = {
    font = STANDARD_TEXT_FONT,
    size = 11,
    pos = {a1 = "BOTTOM", x = 0, y = 0}
  },
  count = {
    font = STANDARD_TEXT_FONT,
    size = 11,
    pos = {a1 = "TOPRIGHT", x = 0, y = 0}
  }
}

-----------------------------
-- HANDOVER
-----------------------------

--hand the config to the namespace for usage in other lua files (remember: those lua files must be called after the cfg.lua)
ns.cfg = cfg
