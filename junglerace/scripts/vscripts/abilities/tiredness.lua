function tiredness_used_ability( event )

    local ability = event.event_ability
    local multip_cooldown = event.multip_cooldown

    ability:StartCooldown(ability:GetCooldown(ability:GetLevel())*multip_cooldown)
end