--The Tie that Binds
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --thrice per duel check
    if Duel.GetFlagEffect(ep,id)>2 then return end
    --condition
    return aux.CanActivateSkill(tp)
        and Duel.IsExistingMatchingCard(Card.IsFaceup, tp, LOCATION_MZONE, 0, 1, nil)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    --used skill flag register
    Duel.RegisterFlagEffect(ep,id,0,0,0)
    --Skill negation check
    if aux.CheckSkillNegation(e,tp) then return end
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
    local atk=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)*100
    if #g==0 or atk==0 then return end
    local tc=g:GetFirst()
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_END)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
	end
end