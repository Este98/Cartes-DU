--Life Charge
local s,id=GetID()
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per Duel check
    if Duel.GetFlagEffect(tp,id)>0 then return end
    --condition
    return aux.CanActivateSkill(tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    --Once per Duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    local lp=Duel.GetTurnCount()*200
    Duel.Recover(tp, lp, REASON_RULE)
end