--Medusa's Gaze
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --twice per duel check
    if Duel.GetFlagEffect(ep,id)>1 then return end
    --condition
    return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(s.filter, tp, LOCATION_MZONE, 0, 1, nil)
        and Duel.IsExistingMatchingCard(Card.IsFaceup, tp, 0, LOCATION_MZONE, 1, nil)
end
function s.filter(c)
    return c:IsFaceup() and c:IsSetCard(SET_REPTILIANNE)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    --used skill flag register
    Duel.RegisterFlagEffect(ep,id,0,0,0)
    --Skill negation check
    if aux.CheckSkillNegation(e,tp) then return end
    if Duel.IsExistingMatchingCard(Card.IsFaceup, tp, 0, LOCATION_MZONE, 1, nil) then
        Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_FACEUP)
        local tc=Duel.SelectMatchingCard(tp, Card.IsFaceup, tp, 0, LOCATION_MZONE, 1, 1, nil):GetFirst()
        if tc then
            Duel.HintSelection(tc)
		    --ATK becomes 0
		    local e1=Effect.CreateEffect(e:GetHandler())
		    e1:SetType(EFFECT_TYPE_SINGLE)
		    e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		    e1:SetValue(0)
		    e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		    tc:RegisterEffect(e1)
		    --Cannot change its battle position
		    local e2=Effect.CreateEffect(e:GetHandler())
		    e2:SetDescription(3313)
		    e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		    e2:SetType(EFFECT_TYPE_SINGLE)
		    e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		    e2:SetReset(RESET_EVENT|RESETS_STANDARD)
		    tc:RegisterEffect(e2)
        end
	end
end