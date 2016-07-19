
function SpellSteal( keys )
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target

	--local abilCount = target:GetAbilityCount() -- it will be always 16
	--print("[DEBUG SPELLSTEAL] Start cast ability")

	local abilList = {}
	local b = 0

	for i = 0, 15 do 
		local abil = target:GetAbilityByIndex(i)

		if abil ~= nil then 
			b = b + 1
			abilList[b] = abil
			--print("[DEBUG SPELLSTEAL] abilList["..b.."] = "..abil:GetAbilityName())
		end
	end

	--print("[DEBUG SPELLSTEAL] target has "..#abilList.." abilities")

	if #abilList > 0 then
		local numAbil = 1
		if #abilList > 1 then
			numAbil = math.random(#abilList)
		end

		local abilName = abilList[numAbil]:GetAbilityName()
		--print("[DEBUG SPELLSTEAL] choosed abil #"..numAbil.." - "..abilName)

		if caster:GetAbilityByIndex(0) ~= nil and caster:GetAbilityByIndex(1) ~= nil and caster:GetAbilityByIndex(2) ~= nil and caster:GetAbilityByIndex(3) ~= nil then
			--print("[DEBUG SPELLSTEAL] removing SpellSteal ability from caster")
			caster:RemoveAbility(ability:GetAbilityName())
		end

		local added_abil = caster:AddAbility(abilName)
		added_abil:SetLevel(1)
		target:RemoveAbility(abilName)
	end

	--[[
	if abilCount > 0 then
		--print("[DEBUG SPELLSTEAL] count of target abils is "..abilCount)

		for i=0, abilCount - 1 do
			--print("[DEBUG SPELLSTEAL] for where index = "..i)
			local abil = target:GetAbilityByIndex(i)

			if abil ~= nil then 
				local abName = abil:GetAbilityName()
				--print("[DEBUG SPELLSTEAL] Finded ability - "..abName)

				if caster:GetAbilityByIndex(0) ~= nil and caster:GetAbilityByIndex(1) ~= nil and caster:GetAbilityByIndex(2) ~= nil and caster:GetAbilityByIndex(3) ~= nil then
					--print("[DEBUG SPELLSTEAL] removing SpellSteal ability from caster")
					caster:RemoveAbility(ability:GetAbilityName())
				end

				local added_abil = caster:AddAbility(abName)
				added_abil:SetLevel(1)
				target:RemoveAbility(abName)

				return
			end
		end
	end]]
end