AddCSLuaFile()

local function fixHands()
    local hands = scripted_ents.GetStored("gmod_hands").t

    hands.Initialize = function(self)
        if CLIENT then
            if self:GetOwner() == LocalPlayer() then
                self.viewHookID = "HandsViewModelChanged_" .. self:EntIndex()

                self:CallOnRemove( "RemoveViewModelChangedHook", function()
                    hook.Remove( "OnViewModelChanged", self.viewHookID )
                end )

                hook.Add( "OnViewModelChanged", self.viewHookID, function(...)
                    self:ViewModelChanged( ... )
                end )
            end
        end

        self:SetNotSolid( true )
        self:DrawShadow( false )
        self:SetTransmitWithParent( true ) -- Transmit only when the viewmodel does!
    end
end


hook.Add( "Initialize", "CFC_FixHands", fixHands )
