function fire(data)
  local target = data.caller
  if target ~= nil then
    local arrow = thisEntity:FindAbilityByName("dota_ability_trap_arrow")
    thisEntity:CastAbilityOnPosition(target:GetOrigin(), arrow, -1 )
  end
end