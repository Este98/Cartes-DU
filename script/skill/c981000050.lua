--Secret Seeker
--Created by MRX

local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end
    return aux.CanActivateSkill(tp)
        and Duel.GetMatchingGroupCount(Card.IsFacedown, tp, 0, LOCATION_ONFIELD,nil)>0
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)

    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
    local g=Duel.SelectMatchingCard(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)

    if #g>0 then
        Duel.ConfirmCards(tp, g)
    end
end