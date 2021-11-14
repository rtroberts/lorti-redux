  --get the addon namespace
  local addon, ns = ...
  --get the config values
  local cfg = ns.cfg
  local dragFrameList = ns.dragFrameList

  -- v:SetVertexColor(.35, .35, .35) GREY
  -- v:SetVertexColor(.05, .05, .05) DARKEST

  ---------------------------------------
  -- ACTIONS
  ---------------------------------------


hooksecurefunc('TargetFrame_CheckClassification', function(self, forceNormalTexture)
	local classification = UnitClassification(self.unit);
	if ( classification == "minus" ) then
		self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus");
		self.borderTexture:SetVertexColor(.05, .05, .05)
		self.nameBackground:Hide();
		self.manabar.pauseUpdates = true;
		self.manabar:Hide();
		self.manabar.TextString:Hide();
		self.manabar.LeftText:Hide();
		self.manabar.RightText:Hide();
		forceNormalTexture = true;
	elseif ( classification == "worldboss" or classification == "elite" ) then
		self.borderTexture:SetTexture("Interface\\AddOns\\Lorti-UI-Classic\\textures\\target\\elite")
		self.borderTexture:SetVertexColor(1, 1, 1)
	elseif ( classification == "rareelite" ) then
		self.borderTexture:SetTexture("Interface\\AddOns\\Lorti-UI-Classic\\textures\\target\\rare-elite")
		self.borderTexture:SetVertexColor(1, 1, 1)
	elseif ( classification == "rare" ) then
		self.borderTexture:SetTexture("Interface\\AddOns\\Lorti-UI-Classic\\textures\\target\\rare")
		self.borderTexture:SetVertexColor(1, 1, 1)
	else
		self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
		self.borderTexture:SetVertexColor(.05, .05, .05)
	end
end)


PlayerFrame:SetScale(cfg.player_frame_scale)
TargetFrame:SetScale(cfg.target_frame_scale) 

PartyMemberFrame1:SetScale(cfg.party_frame_scale)
PartyMemberFrame2:SetScale(cfg.party_frame_scale)
PartyMemberFrame3:SetScale(cfg.party_frame_scale)
PartyMemberFrame4:SetScale(cfg.party_frame_scale)

-- COLORING FRAMES
local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_ENTERING_WORLD")
CF:RegisterEvent("GROUP_ROSTER_UPDATE")

-- I could be wrong about this assumption but I think this only ever needs to be called when the group changes;
-- i.e. GROUP_ROSTER_UPDATE
-- and not even on player_entering_world
local function ColorRaid(self, event, ...)
	if event ~= "GROUP_ROSTER_UPDATE" then return end
	Helpers.ColorRaid()
end

CF:SetScript("OnUpdate", ColorRaid);

CF:SetScript("OnEvent", function(self, event)
	if event == "GROUP_ROSTER_UPDATE" then 
		Helpers.ColorRaid()
		return
	end

	if (IsAddOnLoaded("Shadowed Unit Frames") or IsAddOnLoaded("PitBull Unit Frames 4.0") or IsAddOnLoaded("X-Perl UnitFrames")) then return end

	for i,v in pairs({
		PlayerFrameTexture,
		TargetFrameTextureFrameTexture,
		TargetFrameToTTextureFrameTexture,
		PetFrameTexture,
		PartyMemberFrame1Texture,
		PartyMemberFrame2Texture,
		PartyMemberFrame3Texture,
		PartyMemberFrame4Texture,
		PartyMemberFrame1PetFrameTexture,
		PartyMemberFrame2PetFrameTexture,
		PartyMemberFrame3PetFrameTexture,
		PartyMemberFrame4PetFrameTexture,
		CastingBarFrame.Border,
		TargetFrameSpellBar.Border,
		MirrorTimer1Border,
		MirrorTimer2Border,
		MirrorTimer3Border,
		PlayerFrameAlternateManaBarBorder,
		PlayerFrameAlternateManaBarLeftBorder,
		PlayerFrameAlternateManaBarRightBorder,
		PlayerFrameAlternatePowerBarBorder,
		PlayerFrameAlternatePowerBarLeftBorder,
		PlayerFrameAlternatePowerBarRightBorder,
		CastingBarFrameBorder,
	}) do
		v:SetVertexColor(.05, .05, .05)
	end


	for _, region in pairs({CompactRaidFrameManager:GetRegions()}) do
		if region:IsObjectType("Texture") then
			region:SetVertexColor(.05, .05, .05)
		end
	end

	for _, region in pairs({CompactRaidFrameManagerContainerResizeFrame:GetRegions()}) do
		if region:GetName():find("Border") then
			region:SetVertexColor(.05, .05, .05)
		end
	end

	CompactRaidFrameManagerToggleButton:SetNormalTexture("Interface\\AddOns\\Lorti-UI-Classic\\textures\\raid\\RaidPanel-Toggle")

	hooksecurefunc("GameTooltip_ShowCompareItem", function(self, anchorFrame)
		if self then
			local shoppingTooltip1, shoppingTooltip2 = unpack(self.shoppingTooltips)
			shoppingTooltip1:SetBackdropBorderColor(.05, .05, .05)
			shoppingTooltip2:SetBackdropBorderColor(.05, .05, .05)
		end
	end)


	GameTooltip:SetBackdropBorderColor(.05, .05, .05)
	GameTooltip.SetBackdropBorderColor = function() end

	for i,v in pairs({
		PlayerPVPIcon,
		TargetFrameTextureFramePVPIcon,
	}) do
		v:SetAlpha(0.35)
	end

	for i=1,4 do
		_G["PartyMemberFrame"..i.."PVPIcon"]:SetAlpha(0)
		_G["PartyMemberFrame"..i.."NotPresentIcon"]:Hide()
		_G["PartyMemberFrame"..i.."NotPresentIcon"].Show = function() end
	end

	PlayerFrameGroupIndicator:SetAlpha(0)
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = function() end
	PetHitIndicator:SetText(nil)
	PetHitIndicator.SetText = function() end

end)

 -- COLORING THE MAIN BAR
for i,v in pairs({
    SlidingActionBarTexture0,
    SlidingActionBarTexture1,
    MainMenuBarTexture0,
    MainMenuBarTexture1,
    MainMenuBarTexture2,
    MainMenuBarTexture3,
    MainMenuMaxLevelBar0,
    MainMenuMaxLevelBar1,
    MainMenuMaxLevelBar2,
    MainMenuMaxLevelBar3,
	MainMenuXPBarTexture0,
    MainMenuXPBarTexture1,
	MainMenuXPBarTexture2,
	MainMenuXPBarTexture3,
	MainMenuXPBarTexture4,
	ReputationWatchBar.StatusBar.WatchBarTexture0,
    ReputationWatchBar.StatusBar.WatchBarTexture1,
    ReputationWatchBar.StatusBar.WatchBarTexture2,
    ReputationWatchBar.StatusBar.WatchBarTexture3,
	ReputationWatchBar.StatusBar.XPBarTexture0,
	ReputationWatchBar.StatusBar.XPBarTexture1,
	ReputationWatchBar.StatusBar.XPBarTexture2,
	ReputationWatchBar.StatusBar.XPBarTexture3,
}) do
   v:SetVertexColor(.2, .2, .2)
end

if IsAddOnLoaded("BattleForAzerothUI") then
    for i,v in pairs({
        ActionBarArtSmallTexture,
        MicroMenuArtTexture,
    }) do
        v:SetVertexColor(.2, .2, .2)
    end
end

local function OnEvent(self, event, addon)

	--RECOLOR CLOCK AND STOPWATCH

    if addon == "Blizzard_TimeManager" then
																		 
		for _, v in pairs({StopwatchFrame:GetRegions()})do
			v:SetVertexColor(.35, .35, .35)
		end
		
		local a, b, c = StopwatchTabFrame:GetRegions()
		for _, v in pairs({a, b, c})do
			v:SetVertexColor(.35, .35, .35)
		end
		
		local a, b, c, d, e, f, g, h, i, j, k, l, n, o, p, q, r =  TimeManagerFrame:GetRegions()
		for _, v in pairs({a, b, c, d, e, f, g, h, i, j, k, l, n, o, p, q, r})do
			v:SetVertexColor(.35, .35, .35)
		end
		
		for _, v in pairs({TimeManagerFrameInset:GetRegions()})do
			v:SetVertexColor(.65, .65, .65)
		end
		
        TimeManagerClockButton:GetRegions():SetVertexColor(.05, .05, .05)
        -- self:UnregisterEvent(event)
		
    end
	
	--RECOLOR TALENTS
	
	if addon == "Blizzard_TalentUI" then
		local _, a, b, c, d, _, _, _, _, _, e, f, g = PlayerTalentFrame:GetRegions()
		
		for _, v in pairs({a, b, c, d, e, f, g})do
			v:SetVertexColor(.35, .35, .35)
		end
		
        -- self:UnregisterEvent(event)
    end
	
	--RECOLOR TRADESKILL
	
	if addon == "Blizzard_TradeSkillUI" then
		local _, a, b, c, d, _, e, f, g, h = TradeSkillFrame:GetRegions()
		
		for _, v in pairs({ a, b, c, d, e, f, g, h})do
			v:SetVertexColor(.35, .35, .35)
		end
		
        -- self:UnregisterEvent(event)
    end
	
	--UNREGISTER WHEN DONE 
	
											
	if (IsAddOnLoaded("Blizzard_TalentUI") and IsAddOnLoaded("Blizzard_TimeManager") and IsAddOnLoaded("Blizzard_TradeSkillUI")) then
		self:UnregisterEvent(event)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", OnEvent)

 -- RECOLOR GRYPHONS
for i,v in pairs({
      MainMenuBarLeftEndCap,
      MainMenuBarRightEndCap,
      StanceBarLeft,
      StanceBarMiddle,
      StanceBarRight

}) do
   v:SetVertexColor(.35, .35, .35)
end

 -- RECOLOR MINIMAP
for i,v in pairs({
	MinimapBorder,
	MinimapBorderTop,
	MiniMapMailBorder,
	MiniMapTrackingBorder,
	MiniMapBattlefieldBorder
}) do
   v:SetVertexColor(.05, .05, .05)
   end

 for i,v in pairs({
--LOOT FRAME
      LootFrameBg,
	  LootFrameRightBorder,
      LootFrameLeftBorder,
      LootFrameTopBorder,
      LootFrameBottomBorder,
	  LootFrameTopRightCorner,
      LootFrameTopLeftCorner,
      LootFrameBotRightCorner,
      LootFrameBotLeftCorner,
	  LootFrameInsetInsetTopRightCorner,
	  LootFrameInsetInsetTopLeftCorner,
	  LootFrameInsetInsetBotRightCorner,
	  LootFrameInsetInsetBotLeftCorner,
      LootFrameInsetInsetRightBorder,
      LootFrameInsetInsetLeftBorder,
      LootFrameInsetInsetTopBorder,
      LootFrameInsetInsetBottomBorder,
	  LootFramePortraitFrame,
--EACH BAG
	  ContainerFrame1BackgroundTop,
	  ContainerFrame1BackgroundMiddle1,
	  ContainerFrame1BackgroundBottom,

	  ContainerFrame2BackgroundTop,
	  ContainerFrame2BackgroundMiddle1,
	  ContainerFrame2BackgroundBottom,

	  ContainerFrame3BackgroundTop,
	  ContainerFrame3BackgroundMiddle1,
	  ContainerFrame3BackgroundBottom,

	  ContainerFrame4BackgroundTop,
	  ContainerFrame4BackgroundMiddle1,
	  ContainerFrame4BackgroundBottom,

	  ContainerFrame5BackgroundTop,
	  ContainerFrame5BackgroundMiddle1,
	  ContainerFrame5BackgroundBottom,
	
	  ContainerFrame6BackgroundTop,
	  ContainerFrame6BackgroundMiddle1,
	  ContainerFrame6BackgroundBottom,
	  
	  ContainerFrame7BackgroundTop,
	  ContainerFrame7BackgroundMiddle1,
	  ContainerFrame7BackgroundBottom,
	  
	  ContainerFrame8BackgroundTop,
	  ContainerFrame8BackgroundMiddle1,
	  ContainerFrame8BackgroundBottom,
	  
	  ContainerFrame9BackgroundTop,
	  ContainerFrame9BackgroundMiddle1,
	  ContainerFrame9BackgroundBottom,
	  
	  ContainerFrame10BackgroundTop,
	  ContainerFrame10BackgroundMiddle1,
	  ContainerFrame10BackgroundBottom,
	  
	  ContainerFrame11BackgroundTop,
	  ContainerFrame11BackgroundMiddle1,
	  ContainerFrame11BackgroundBottom,

--Frames that's not colored for some reason
	  MerchantFrameTopBorder,
	  MerchantFrameBtnCornerRight,
	  MerchantFrameBtnCornerLeft,
	  MerchantFrameBottomRightBorder,
	  MerchantFrameBottomLeftBorder,
	  MerchantFrameButtonBottomBorder,
	  MerchantFrameBg,


}) do
   v:SetVertexColor(.35, .35, .35)
end

--BANK
local a, b, c, d, _, e = BankFrame:GetRegions()
for _, v in pairs({a, b, c, d, e

})do
   v:SetVertexColor(.35, .35, .35)

end

--Darker color stuff
for i,v in pairs({
      LootFrameInsetBg,
      LootFrameTitleBg,
	  MerchantFrameTitleBg,

}) do
   v:SetVertexColor(.05, .05, .05)
end

--PAPERDOLL/Characterframe
local a, b, c, d, _, e = PaperDollFrame:GetRegions()
for _, v in pairs({a, b, c, d, e}) do
   v:SetVertexColor(.35, .35, .35)
end

--Spellbook
local _, a, b, c, d = SpellBookFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
    v:SetVertexColor(.35, .35, .35)
end

-- Skilltab
local a, b, c, d = SkillFrame:GetRegions()
for _, v in pairs({a, b, c ,d}) do
     v:SetVertexColor(.35, .35, .35)
end

for _, v in pairs({ReputationDetailCorner, ReputationDetailDivider}) do
     v:SetVertexColor(.35, .35, .35)
end


--Reputation Frame
local a, b, c, d = ReputationFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
     v:SetVertexColor(.35, .35, .35)
end



-- HONOR
if (PVPFrame ~= nil) then
	local a, b, c, d, e = PVPFrame:GetRegions()
	for _, v in pairs({a, b, c, d, e}) do
		v:SetVertexColor(.35, .35, .35)
	end
end

-- Social Frame
local a, b, c, d, e, f, g, _, i, j, k, l, n, o, p, q, r, _, _ = FriendsFrame:GetRegions()
for _, v in pairs({
	a, b, c, d, e, f, g, h, i, j, k, l, n, o, p, q, r,
	FriendsFrameInset:GetRegions(),
	WhoFrameListInset:GetRegions()
}) do
	v:SetVertexColor(.35, .35, .35)
end

-- MERCHANT
local _, a, b, c, d, _, _, _, e, f, g, h, j, k = MerchantFrame:GetRegions()
for _, v in pairs({a, b, c ,d, e, f, g, h, j, k}) do
   v:SetVertexColor(.35, .35, .35)
end

--MerchantPortrait
for i, v in pairs({
    MerchantFramePortrait
}) do
   v:SetVertexColor(1, 1, 1)
end

--PETPAPERDOLL/PET Frame
local a, b, c, d, _, e = PetPaperDollFrame:GetRegions()
for _, v in pairs({a, b, c, d, e})do
   v:SetVertexColor(.35, .35, .35)
end

-- SPELLBOOK
local _, a, b, c, d = SpellBookFrame:GetRegions()
for _, v in pairs({a, b, c, d}) do
     v:SetVertexColor(.35, .35, .35)
end

 SpellBookFrame.Material = SpellBookFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
 SpellBookFrame.Material:SetTexture[[Interface\AddOns\Lorti-UI-Classic\textures\quest\QuestBG.tga]]
 SpellBookFrame.Material:SetWidth(547)
 SpellBookFrame.Material:SetHeight(541)
 SpellBookFrame.Material:SetPoint('TOPLEFT', SpellBookFrame, 22, -74)
 SpellBookFrame.Material:SetVertexColor(.7, .7, .7)

			   





-- Quest Log Frame
if (IsAddOnLoaded("WideQuestLog")) then
QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestLogFrame.Material:SetTexture[[Interface\AddOns\Lorti-UI-Classic\textures\quest\QuestBG.tga]]
QuestLogFrame.Material:SetWidth(524)
QuestLogFrame.Material:SetHeight(553)
QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame, -10, 0)
QuestLogFrame.Material:SetVertexColor(.8, .8, .8)
else

local _, _, a, b, c, d, _, _, _, e, f, g, h, j, k = QuestLogFrame:GetRegions()
for _, v in pairs({a, b, c ,d, e, f, g, h, j, k}) do
	v:SetVertexColor(.35, .35, .35)
end
 
QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestLogFrame.Material:SetTexture[[Interface\AddOns\Lorti-UI-Classic\textures\quest\QuestBG.tga]]
QuestLogFrame.Material:SetWidth(514)
QuestLogFrame.Material:SetHeight(400)
QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame, 0, 0)
QuestLogFrame.Material:SetVertexColor(.8, .8, .8) 
end	

																						  
 --THINGS THAT SHOULD REMAIN THE REGULAR COLOR
for i,v in pairs({
	BankPortraitTexture,
	BankFrameTitleText,
	MerchantFramePortrait,
	WhoFrameTotals																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																 
	
}) do
   v:SetVertexColor(1, 1, 1)
end
