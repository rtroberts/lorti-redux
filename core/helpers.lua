Helpers = CreateFrame('Frame', nil, UIParent)

--get the addon namespace
local addon, ns = ...
--get the config values
local cfg = ns.cfg

function Helpers.bool_to_num(value)
    return value == true and 1 or value == false and 0
end

function Helpers.ColorRaid()
    print("Helpers.colorraid called", time())
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