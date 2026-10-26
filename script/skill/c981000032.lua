-- Oracle Portait
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)

    if Duel.HasFlagEffect(tp,id) then return false end
    return aux.CanActivateSkill(tp)
        and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    
    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
    
    local ac=Duel.AnnounceCard(tp)
    
    -- On regarde la première carte du Deck
    local g=Duel.GetDecktopGroup(tp,1)
    if #g>0 then
        local tc=g:GetFirst()
        Duel.ConfirmCards(tp,tc) 
        Duel.ConfirmCards(1-tp,tc)
        
        if tc:IsCode(ac) then
            Duel.DisableShuffleCheck()
            Duel.SendtoHand(tc,nil,REASON_EFFECT)
            Duel.ConfirmCards(1-tp,tc)
        else
            Duel.DisableShuffleCheck()
            Duel.SendtoBottomDeck(tc,nil)
        end
    end
end