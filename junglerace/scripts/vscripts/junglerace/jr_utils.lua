

function GetPointRandomUnit( caster )
	local pickedUnits = {}

	local direUnits = FindUnitsInRadius(caster:GetTeamNumber(),
                              Vector(0, 0, 0),
                              nil,
                              FIND_UNITS_EVERYWHERE,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
 
 	local i = 1
	for _,unit in pairs(direUnits) do

		--if not unit == nil then
			--print("[DEBUG] Unit["..i.."] - "..unit:GetName())
		--end

		if not unit:IsHero() then
			pickedUnits[i] = unit
			--print("[DEBUG] Unit["..i.."] - "..unit:GetName())
		end
		i = i + 1
	end

	i = math.random(#pickedUnits)
	--print("[DEBUG] Finded random unit:"..i)
	if pickedUnits[i] == nil then
		return nil
	end

	return pickedUnits[i]:GetAbsOrigin()
end

function ScrambleArray( arr, size )
	for i = 1, size do
		local r = math.random(size)
		local t = arr[i]
		arr[i] = arr[r]
		arr[r] = t
	end

	return arr
end