--Energy Drain
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetFlagEffect(tp,id)>0 then return end
    --condition
    return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(s.filter, tp, LOCATION_MZONE, LOCATION_MZONE, 2, nil)
end
function s.filter(c)
    return c:IsFaceup() and c:IsMonster()
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    --Once per Duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
    local g=Duel.SelectMatchingCard(tp, s.filter, tp, LOCATION_MZONE, LOCATION_MZONE, 2, 2,nil)
    local tc1=g:GetFirst()
    local tc2=g:GetNext()
    if tc1 and tc2 then
        Duel.HintSelection(g)
        local atk1=tc1:GetBaseAttack()
        local atk2=tc2:GetBaseAttack()
        --Change their ATK to 0 until the end of this turn
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_BASE_ATTACK)
        e1:SetValue(atk2)
        e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE+PHASE_END)
        tc1:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_SET_BASE_ATTACK)
        e2:SetValue(atk1)
        e2:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE+PHASE_END)
        tc2:RegisterEffect(e2)
    end
end