--get the addon namespace
local addon, ns = ...
--get the config values
local cfg = ns.cfg

if (FocusFrame ~= nil) then
	FocusFrame:SetScale(cfg.focus_frame_scale)
	FocusFrameToTTextureFrameTexture:SetVertexColor(.05, .05, .05)
	FocusFrameSpellBar.Border:SetVertexColor(.05, .05, .05)
	FocusFrameTextureFramePvPIcon:SetAlpha(0.35)
end
