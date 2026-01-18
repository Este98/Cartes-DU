--Level Variation
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per Duel check
    if Duel.GetFlagEffect(tp,id)>0 then return end
    return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(Card.HasLevel, tp, LOCATION_HAND, 0, 1, nil)
        and Duel.IsExistingMatchingCard(s.filter, tp, LOCATION_MZONE, 0, 1, nil)
end
function s.filter(c)
    return c:HasLevel() and c:IsFaceup()
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,0,id)
    --Once per duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    local rev=Duel.SelectMatchingCard(tp,Card.HasLevel,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
    Duel.ConfirmCards(1-tp,rev)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local tc=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
    if not tc then return end
    Duel.HintSelection(tc)
    Duel.BreakEffect()
    local b1=tc:HasLevel()
    local b2=tc:IsLevelAbove(2)
    local op=Duel.SelectEffect(tp,
			{b1,aux.Stringid(id,0)},
			{b2,aux.Stringid(id,1)})
    if op==1 then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_LEVEL)
        e1:SetValue(rev:GetLevel())
        e1:SetReset(RESET_EVENT|RESETS_STANDARD)
        tc:RegisterEffect(e1)
    else
        local lvl=tc:GetLevel()-rev:GetLevel()
        if lvl<1 then
            lvl=1
            local e2=Effect.CreateEffect(c)
            e2:SetType(EFFECT_TYPE_SINGLE)
            e2:SetCode(EFFECT_CHANGE_LEVEL)
            e2:SetValue(lvl)
            e2:SetReset(RESET_EVENT|RESETS_STANDARD)
            tc:RegisterEffect(e2)
        else
            local e2=Effect.CreateEffect(c)
            e2:SetType(EFFECT_TYPE_SINGLE)
            e2:SetCode(EFFECT_UPDATE_LEVEL)
            e2:SetValue(-rev:GetLevel())
            e2:SetReset(RESET_EVENT|RESETS_STANDARD)
            tc:RegisterEffect(e2)
        end
    end
end