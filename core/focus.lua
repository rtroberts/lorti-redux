--get the addon namespace
local addon, ns = ...
--get the config values
local cfg = ns.cfg
local dragFrameList = ns.dragFrameList

if (FocusFrame ~= nil) then
	FocusFrame:SetScale(1.3)
	FocusFrameToTTextureFrameTexture:SetVertexColor(.05, .05, .05)
	FocusFrameSpellBar.Border:SetVertexColor(.05, .05, .05)	 
	FocusFrameTextureFramePvPIcon:SetAlpha(0.35)
end
