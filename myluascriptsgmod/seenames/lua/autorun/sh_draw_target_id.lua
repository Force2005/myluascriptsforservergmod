dti_sv_disablemod = CreateConVar( 'dti_sv_disablemod', '0', { FCVAR_REPLICATED, FCVAR_ARCHIVE } )

if CLIENT then
	hook.Add("HUDDrawTargetID", "Seefox:DrawTargetID", function()
		if !dti_sv_disablemod:GetBool() then
			return false
		end
	end)
end