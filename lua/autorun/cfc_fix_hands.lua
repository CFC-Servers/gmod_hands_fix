AddCSLuaFile()

FixHands = function()
    local hands = scripted_ents.GetStored("gmod_hands").t

    hands.Initialize = function(self)
        self:SetNotSolid( true )
        self:DrawShadow( false )
        self:SetTransmitWithParent( true ) -- Transmit only when the viewmodel does!

        self.viewHookID = "HandsViewModelChanged_" .. self:EntIndex()

        if ( SERVER or self:GetOwner() == LocalPlayer() ) then
            hook.Add( "OnViewModelChanged", self.viewHookID, self.ViewModelChanged )

            self:CallOnRemove( "RemoveViewModelChangedHook", function()
                hook.Remove( "OnViewModelChanged", self.viewHookID )
            end )
        end
    end
end


hook.Add( "Think", "CFC_FixHands", function()
    hook.Remove( "Think", "CFC_FixHands" )
    FixHands()
end )
