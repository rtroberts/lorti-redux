-- REMOVING UGLY PARTS OF UI
local addon, ns = ...
local cfg = ns.cfg

local event_frame = CreateFrame('Frame')

local capturedMessages = {}
capturedMessages['Способность пока недоступна'] = true
capturedMessages['Выполняется другое действие'] = true 
capturedMessages['Невозможно дел это на ходу'] = true 
capturedMessages['Предмет пока недоступен'] = true 
capturedMessages['Недостаточно'] = true 
capturedMessages['Некого атаковать'] = true 
capturedMessages['Заклинание пока недоступно'] = true 
capturedMessages['У вас нет цели'] = true
capturedMessages['Вы пока не можете этого сделать'] = true 

capturedMessages['Ability is not ready yet'] = true 
capturedMessages['Another action is in progress'] = true
capturedMessages['Can\'t attack while mounted'] = true 
capturedMessages['Can\'t do that while moving'] = true 
capturedMessages['Item is not ready yet'] = true
capturedMessages['Not enough'] = true
capturedMessages['Nothing to attack'] = true
capturedMessages['Spell is not ready yet.'] = true
capturedMessages['You have no target'] = true
capturedMessages['You can\'t do that yet'] = true

local OriginalAddMessageFunc
local function enable (frame, event, ...)
        OriginalAddMessageFunc = UIErrorsFrame.AddMessage
        UIErrorsFrame.AddMessage = FilterErrors
end

function FilterErrors (frame, errorText, red, green, blue, id)
    if not (capturedMessages[errorText]) then
        OriginalAddMessageFunc(frame, errorText, red, green, blue, id)
    end
    --TODO: Consider a fallback like the below here
    -- for a function that's called every time you press a button, this should have minimal perf impact
    -- So, i think it's worth having a constant time lookup here and not always running match functions against N messages
    -- else
    --     print("fallback")
    --     for k,_ in pairs(capturedMessages) do
    --         if text and text:match(k) then
    --                 return
    --         end
    --     end 
    -- end
end

if cfg.hide_error_text then
    event_frame:SetScript('OnEvent', enable)
    event_frame:RegisterEvent('PLAYER_LOGIN')
end
