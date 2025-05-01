local PLUGIN = PLUGIN
-- This plugin relies on a change to clockwork/framework/hooks/cl_hooks.lua at line 2708/2709, which calls this function below it. Make sure that DrawTargetBounty is called.

if CLIENT then
    function PLUGIN:DrawTargetBounty(target, alpha, x, y)
        local gender = target:GetGender()
        local gentext = "He"
        local gentext2 = "Him"
        local bountied
        local bountytext
        if gender == GENDER_FEMALE then
            gentext = "Her"
            gentext2 = "She"
        end
        local bountystatus = target:GetBounty()

        if bountystatus >= 1 then
            bountytext = "This person is a known criminal of the Glaze. " .. gentext .. " is worth " .. bountystatus .. " coin."
            bountied = true
        end
        local textColor = Color(207,177,40)

        if (bountied) then
            return Clockwork.kernel:DrawInfo(Clockwork.kernel:ParseData(bountytext), x, y, textColor, alpha);
        end
    end
end