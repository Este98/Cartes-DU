--The Phantom Knights Order
local s, id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --twice per duel check
    if Duel.GetFlagEffect(ep,id)>1 then return end
    --condition
    return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(s.filter, tp, LOCATION_MZONE, 0, 1, nil)
end
function s.filter(c)
    return c:IsFaceup() and c:IsSetCard(0xdb) and c:HasLevel()
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    --used skill flag register
    Duel.RegisterFlagEffect(ep,id,0,0,0)
    --Skill negation check
    if aux.CheckSkillNegation(e,tp) then return end
    local c=e:GetHandler()
    if Duel.IsExistingMatchingCard(s.filter, tp, LOCATION_MZONE, 0, 1, nil) then
        Duel.Hint(HINT_SELECTMSG, tp, aux.Stringid(id,0))
        local g=Duel.SelectMatchingCard(tp, s.filter, tp, LOCATION_MZONE, 0, 1, 2, nil)
        if #g>0 then
            Duel.HintSelection(g)
            for tc in aux.Next(g) do
                local e1=Effect.CreateEffect(c)
                e1:SetType(EFFECT_TYPE_SINGLE)
                e1:SetCode(EFFECT_XYZ_LEVEL)
                e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
                e1:SetRange(LOCATION_MZONE)
                e1:SetValue(s.xyzlvl)
                e1:SetReset(RESET_EVENT|RESETS_STANDARD-RESET_TOFIELD|RESET_PHASE|PHASE_END)
                tc:RegisterEffect(e1)
            end
        end
    end
end
function s.xyzlvl(e,c)
    return 2,3,4
end