function cancel_bufs( event )

    local target = event.target
    local caster = event.caster
    local durPerDebuf = event.durPerDebuf

    local Duration = 0
    local bufs = caster:FindAllModifiers()
	if bufs then
		for k,buf in pairs(bufs) do
			target:RemoveModifierByName(buf:GetEffectName())
			if buf:IsDebuff() then
				Duration = Duration + durPerDebuf
			end
		end
	end
	if Duration > 0 then
		caster:AddNewModifier(caster, nil, "modifier_cancel_buf_speed", {duration = Duration})
	end
end