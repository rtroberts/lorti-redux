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

  -- REMOVING UGLY PARTS OF UI

	local event_frame = CreateFrame('Frame')
	local errormessage_blocks = {
	  'Способность пока недоступна',
	  'Выполняется другое действие',
	  'Невозможно делать это на ходу',
	  'Предмет пока недоступен',
	  'Недостаточно',
	  'Некого атаковать',
	  'Заклинание пока недоступно',
	  'У вас нет цели',
	  'Вы пока не можете этого сделать',

	  'Ability is not ready yet',
 	  'Another action is in progress',
	  'Can\'t attack while mounted',
	  'Can\'t do that while moving',
	  'Item is not ready yet',
	  'Not enough',
	  'Nothing to attack',
	  'Spell is not ready yet',
	  'You have no target',
	  'You can\'t do that yet',
	}
	local enable
	local onevent
	local uierrorsframe_addmessage
	local old_uierrosframe_addmessage
	function enable ()
  		old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
  		UIErrorsFrame.AddMessage = uierrorsframe_addmessage
	end

	function uierrorsframe_addmessage (frame, text, red, green, blue, id)
  		for i,v in ipairs(errormessage_blocks) do
    			if text and text:match(v) then
      				return
    			end
  		end
  		old_uierrosframe_addmessage(frame, text, red, green, blue, id)
	end

	function onevent (frame, event, ...)
  		if event == 'PLAYER_LOGIN' then
    			enable()
  		end
	end
	event_frame:SetScript('OnEvent', onevent)
	event_frame:RegisterEvent('PLAYER_LOGIN')

	
	PlayerFrame:SetScale(1.3) 
	TargetFrame:SetScale(1.3) 
	FocusFrame:SetScale(1.3)
	PartyMemberFrame1:SetScale(1.5)
	PartyMemberFrame2:SetScale(1.5)
	PartyMemberFrame3:SetScale(1.5)
	PartyMemberFrame4:SetScale(1.5)
	
  -- COLORING FRAMES
	local CF=CreateFrame("Frame")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:RegisterEvent("GROUP_ROSTER_UPDATE")

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

	function ColorRaid()
		for g = 1, NUM_RAID_GROUPS do
			local group = _G["CompactRaidGroup"..g.."BorderFrame"]
			if group then
				for _, region in pairs({group:GetRegions()}) do
					if region:IsObjectType("Texture") then
						region:SetVertexColor(.05, .05, .05)
					end
				end
			end

			for m = 1, 5 do
				local frame = _G["CompactRaidGroup"..g.."Member"..m]
				if frame then
					groupcolored = true
					for _, region in pairs({frame:GetRegions()}) do
						if region:GetName():find("Border") then
							region:SetVertexColor(.05, .05, .05)
						end
					end
				end
				local frame = _G["CompactRaidFrame"..m]
				if frame then
					singlecolored = true
					for _, region in pairs({frame:GetRegions()}) do
						if region:GetName():find("Border") then
							region:SetVertexColor(.05, .05, .05)
						end
					end
				end
			end
		end

		for _, region in pairs({CompactRaidFrameContainerBorderFrame:GetRegions()}) do
			if region:IsObjectType("Texture") then
				region:SetVertexColor(.05, .05, .05)
			end
		end
	end

	CF:SetScript("OnEvent", function(self, event)
		ColorRaid()
		CF:SetScript("OnUpdate", function()
			if CompactRaidGroup1 and not groupcolored == true then
				ColorRaid()
			end
			if CompactRaidFrame1 and not singlecolored == true then
				ColorRaid()
			end
		end)
		if event == "GROUP_ROSTER_UPDATE" then return end
		if not (IsAddOnLoaded("Shadowed Unit Frames") or IsAddOnLoaded("PitBull Unit Frames 4.0") or IsAddOnLoaded("X-Perl UnitFrames")) then
											   
											   
				PlayerFrameTexture:SetVertexColor(.05, .05, .05)
				TargetFrameTextureFrameTexture:SetVertexColor(.05, .05, .05)
				TargetFrameToTTextureFrameTexture:SetVertexColor(.05, .05, .05)
				PetFrameTexture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame1Texture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame2Texture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame3Texture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame4Texture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame1PetFrameTexture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame2PetFrameTexture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame3PetFrameTexture:SetVertexColor(.05, .05, .05)
				PartyMemberFrame4PetFrameTexture:SetVertexColor(.05, .05, .05)				 
				CastingBarFrame.Border:SetVertexColor(.05, .05, .05)
				FocusFrameToTTextureFrameTexture:SetVertexColor(.05, .05, .05)
				TargetFrameSpellBar.Border:SetVertexColor(.05, .05, .05)
				FocusFrameSpellBar.Border:SetVertexColor(.05, .05, .05)	  
				MirrorTimer1Border:SetVertexColor(.05, .05, .05)
				MirrorTimer2Border:SetVertexColor(.05, .05, .05)
				MirrorTimer3Border:SetVertexColor(.05, .05, .05)
                
				
					for i,v in pairs({
				PlayerFrameAlternateManaBarBorder,
  				PlayerFrameAlternateManaBarLeftBorder,
				PlayerFrameAlternateManaBarRightBorder,
				PlayerFrameAlternatePowerBarBorder,
				PlayerFrameAlternatePowerBarLeftBorder,
				PlayerFrameAlternatePowerBarRightBorder,


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
				FocusFrameTextureFramePvPIcon
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

		else
			CastingBarFrameBorder:SetVertexColor(.05,.05,.05)
		end
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
for _, v in pairs({a, b, c, d, e

})do
   v:SetVertexColor(.35, .35, .35)

end

--Spellbook
local _, a, b, c, d = SpellBookFrame:GetRegions()
for _, v in pairs({a, b, c, d

}) do
    v:SetVertexColor(.35, .35, .35)
end

-- Skilltab
local a, b, c, d = SkillFrame:GetRegions()
for _, v in pairs({a, b, c ,d

}) do
     v:SetVertexColor(.35, .35, .35)
end
for _, v in pairs({ReputationDetailCorner, ReputationDetailDivider

}) do
     v:SetVertexColor(.35, .35, .35)
end
--Reputation Frame
local a, b, c, d = ReputationFrame:GetRegions()
for _, v in pairs({a, b, c, d

}) do
     v:SetVertexColor(.35, .35, .35)
end



-- HONOR

local a, b, c, d, e = PVPFrame:GetRegions()
for _, v in pairs({a, b, c, d, e 

}) do
   v:SetVertexColor(.35, .35, .35)
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
for _, v in pairs({a, b, c ,d, e, f, g, h, j, k

}) do
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
for _, v in pairs({a, b, c, d, e

})do
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

QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
QuestLogFrame.Material:SetTexture[[Interface\AddOns\Lorti-UI-Classic\textures\quest\QuestBG.tga]]
QuestLogFrame.Material:SetWidth(514)
QuestLogFrame.Material:SetHeight(400)
QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame, 0, 0)
QuestLogFrame.Material:SetVertexColor(.8, .8, .8)

local _, _, a, b, c, d, _, _, _, e, f, g, h, j, k = QuestLogFrame:GetRegions()
for _, v in pairs({a, b, c ,d, e, f, g, h, j, k}) do
	v:SetVertexColor(.35, .35, .35)
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