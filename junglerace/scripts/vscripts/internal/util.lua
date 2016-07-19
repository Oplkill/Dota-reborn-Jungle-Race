function DebugPrint(...)
  local spew = Convars:GetInt('barebones_spew') or -1
  if spew == -1 and BAREBONES_DEBUG_SPEW then
    spew = 1
  end

  if spew == 1 then
    print(...)
  end
end

function DebugPrintTable(...)
  local spew = Convars:GetInt('barebones_spew') or -1
  if spew == -1 and BAREBONES_DEBUG_SPEW then
    spew = 1
  end

  if spew == 1 then
    PrintTable(...)
  end
end

function PrintTable(t, indent, done)
  --print ( string.format ('PrintTable type %s', type(keys)) )
  if type(t) ~= "table" then return end

  done = done or {}
  done[t] = true
  indent = indent or 0

  local l = {}
  for k, v in pairs(t) do
    table.insert(l, k)
  end

  table.sort(l)
  for k, v in ipairs(l) do
    -- Ignore FDesc
    if v ~= 'FDesc' then
      local value = t[v]

      if type(value) == "table" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..":")
        PrintTable (value, indent + 2, done)
      elseif type(value) == "userdata" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
      else
        if t.FDesc and t.FDesc[v] then
          print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
        else
          print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        end
      end
    end
  end
end

-- Colors
COLOR_NONE = '\x06'
COLOR_GRAY = '\x06'
COLOR_GREY = '\x06'
COLOR_GREEN = '\x0C'
COLOR_DPURPLE = '\x0D'
COLOR_SPINK = '\x0E'
COLOR_DYELLOW = '\x10'
COLOR_PINK = '\x11'
COLOR_RED = '\x12'
COLOR_LGREEN = '\x15'
COLOR_BLUE = '\x16'
COLOR_DGREEN = '\x18'
COLOR_SBLUE = '\x19'
COLOR_PURPLE = '\x1A'
COLOR_ORANGE = '\x1B'
COLOR_LRED = '\x1C'
COLOR_GOLD = '\x1D'


--[[Author: Noya
  Date: 09.08.2015.
  Hides all dem hats
]]
function HideWearables( event )
  local hero = event.caster
  local ability = event.ability

  hero.hiddenWearables = {} -- Keep every wearable handle in a table to show them later
    local model = hero:FirstMoveChild()
    while model ~= nil do
        if model:GetClassname() == "dota_item_wearable" then
            model:AddEffects(EF_NODRAW) -- Set model hidden
            table.insert(hero.hiddenWearables, model)
        end
        model = model:NextMovePeer()
    end
end

function ShowWearables( event )
  local hero = event.caster

  for i,v in pairs(hero.hiddenWearables) do
    v:RemoveEffects(EF_NODRAW)
  end
end

--[[
function RemoveWearables(hero)
    print('#RemoveWearables')
    local wearables = {} -- îáúÿâëåíèå ëîêàëüíîãî ìàññèâà íà óäàëåíèå
    local cur = hero:FirstMoveChild() -- ïîëó÷àåì ïåðâûé óêàçàòåëü íàä ïîäîáúåêò îáúåêòà hero ()

    while cur ~= nil do --ïîêà íàø òåêóùèé óêàçàòåëü íå ðàâåí nil(ïóñòîòà/ïóñòîé óêàçàòåëü)
        cur = cur:NextMovePeer() -- âûáèðàåì ñëåäóþùèé óêàçàòåëü íà ïîäîáúåêò íàøåãî îáüåêòà
        if cur ~= nil and cur:GetClassname() ~= "" and cur:GetClassname() == "dota_item_wearable" then -- ïðîâåðÿåì, åëñè òåêóùèé óêàçàòåëü íå ïóñò, íàçâàíèå êëàññà íå ïóñòîå, è åñëè ýòîò êëàññ åñòü êëàññ "dota_item_wearable", òî åñòü íàäåâàåìûå êîñìåòè÷åñêèå ïðåäìåòû
            table.insert(wearables, cur) -- äîáàâëÿåì â òàáëèöó íà óäàëåíèå òåêóùèé ïðåäìåò(ñâåðõó ïðîâåðÿëè êëàññ òåêóùåãî îáúåêòà)
        end
    end
 
    for i = 1, #wearables do -- ñîáñòâåííî öèêë äëÿ óäàëåíèÿ âñåãî çàíåñåííîãî â ìàññèâ íà óäàëåíèå
        UTIL_Remove(wearables[i]) -- óäàëÿåì îáúåêò
    end
end]]