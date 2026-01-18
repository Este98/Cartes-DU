--Love is Pain
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per Duel check
    if Duel.GetFlagEffect(tp,id)>0 then return end
    --condition
    return aux.CanActivateSkill(tp) and Duel.GetLP(tp)<=4000
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    --Once per duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    local c=e:GetHandler()
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_DAMAGE)
    e1:SetRange(0x5f)
    e1:SetCondition(s.skillcon)
    e1:SetOperation(s.skillop)
    Duel.RegisterEffect(e1,tp)
end
function s.skillcon(e,tp,eg,ep,ev,re,r,rp)
    return ep==tp and (r&REASON_EFFECT)~=0 and rp~=tp and Duel.GetLP(tp)<=4000
end
function s.skillop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_CARD,tp,id)
    Duel.Damage(1-tp, ev, REASON_RULE)
end