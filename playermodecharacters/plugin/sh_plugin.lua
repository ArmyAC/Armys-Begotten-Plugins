local PLUGIN = PLUGIN
PLUGIN:SetGlobalAlias("cwPlayermode");


local COMMAND = Clockwork.command:New("SetPlayermode")
	COMMAND.tip = "Enables playermode for someone. It can be turned off.";
	COMMAND.text = "<string Name> <boolean on/off>"
	COMMAND.access = "s";
	COMMAND.arguments = 2
	-- Called when the command has been run.
	function COMMAND:OnRun(player, arguments)
	 	local target = Clockwork.player:FindByID(arguments[1]);
		if !target:IsAdmin() then
			Clockwork.player:Notify(player, "You cannot set playermode for a normal player.")
			return false
		end
		local status = arguments[2]
		status = tobool(status)
		target:SetCharacterData("Playermoded", status)
		target:SetSharedVar("Playermoded", status)
		Clockwork.player:NotifyAdmins("operator", player:Name() .. " has set playermode to " .. tostring(status) .. " on " .. target:GetName() .. ".", nil);
		local flags = "petcrnCWN4EIK"
		Clockwork.player:TakeFlags(player, flags)

	end;
COMMAND:Register()



if SERVER then

	function cwPlayermode:PostPlayerCharacterInitialized(player)
		if player:GetCharacterData("Playermoded") == true then
			player:SetSharedVar("Playermoded", true)
			local flags = "petcrnCWN4EIK"
			Clockwork.player:TakeFlags(player, flags)
		elseif player:GetCharacterData("Playermoded") != true then
			player:SetSharedVar("Playermoded", false)
		end
	
	end

	-- Custom hook that has to be added if you're using this as an independent plugin. 
	hook.Add("PreMakePlayerEnterObserverMode", "PreventNoclip", function(ply)
		local isAdmin = ply:IsAdmin()
		local playermodestatus
		playermodestatus = ply:GetSharedVar("Playermoded")
		if playermodestatus != true then
			playermodestatus = false
		end
		print(playermodestatus)
		print(isAdmin)

		if isAdmin and playermodestatus == true then

			Clockwork.player:Notify(ply, "You cannot enter noclip on this character!")
		return false end



	end)

	function cwPlayermode:PlayerCanUseCommand(player, commandTable, arguments)
		local access = commandTable.access
		local isAdmin = player:IsAdmin()
		local playermodestatus
		playermodestatus = player:GetSharedVar("Playermoded")
		if playermodestatus != true then
			playermodestatus = false
		end

		local endcommand
		local allowedcommands = {
			"AdminChat",
			"SetPlayermode"
		}

		if (access == "s" or access == "o" or access == "a") and (playermodestatus == true or isAdmin != true) then

			endcommand = true

			for k,v in pairs(allowedcommands) do

				if commandTable.name == v then
					endcommand = false
				end


			end

		end

		if endcommand == true then

			Clockwork.player:Notify(player, "You cannot use admin commands on this character!")
		return false end
	end


end

if CLIENT then


	function cwPlayermode:ContextMenuOpen()
		local ply = Clockwork.Client
		print(ply)
		local isanadmin = ply:IsAdmin()
		local playermodestatus
		playermodestatus = ply:GetSharedVar("Playermoded")
		if playermodestatus != true then
			playermodestatus = false
		end

		if (isanadmin and playermodestatus == true) then return false end

	end

	function cwPlayermode:SpawnMenuOpen()
		local ply = Clockwork.Client
		local isanadmin = ply:IsAdmin()
		local playermodestatus
		playermodestatus = ply:GetSharedVar("Playermoded")
		if playermodestatus != true then
			playermodestatus = false
		end

		if (isanadmin and playermodestatus == true) then return false end


	end
	-- Relies on a new hook if you're running this as an independent plugin.
	function cwPlayermode:PostESPInfo(ply2, text)
		if (ply2:IsValid()) and (ply2:IsAdmin()) then
			local playermodestatus = ply2:GetSharedVar("Playermoded")
			local table_text
			if playermodestatus != nil and playermodestatus == true then
				table_text = {
					["Playermode"] = Color(20,100,0)
				}
				return table_text
			end

		end

	end

	function cwPlayermode:PreDrawESP(ply)

		if (ply:IsValid()) and (ply:IsAdmin()) then
			local playermodestatus = ply:GetSharedVar("Playermoded")
			local allowesp
			playermodestatus = tobool(playermodestatus)
			if playermodestatus == 0 then
				allowesp = true
			elseif playermodestatus == 1 then
				allowesp = false
			else
				allowesp = true
			end
			return allowesp
		end
	end
end

-- TODO: Add in blocking scoreboard, blocking gore raid and other info related things you can see in chat. Add in identification of playermode when typed a message. Come up with some system to have a permanent one instead of toggleable to prevent abuse.