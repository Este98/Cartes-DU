--Attack Charge
local s,id=GetID()
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per Duel check
    if Duel.GetFlagEffect(tp,id)>0 then return end
    --condition
    return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(Card.IsFaceup, tp, LOCATION_MZONE, 0, 1, nil)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    --Once per Duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_FACEUP)
    local tc=Duel.SelectMatchingCard(tp, Card.IsFaceup, tp, LOCATION_MZONE, 0, 1, 1, nil):GetFirst()
    if tc then
        Duel.HintSelection(tc)
        local atk=Duel.GetTurnCount()*100
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(atk)
        e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
    end
end