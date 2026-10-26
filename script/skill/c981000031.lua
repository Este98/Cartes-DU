-- Rhino Portrait
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop,1)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    return aux.CanActivateSkill(tp)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)

    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetTargetRange(LOCATION_MZONE,0) 
    e1:SetCondition(s.atkcon)
    e1:SetTarget(s.atktg)
    e1:SetValue(500)
    Duel.RegisterEffect(e1,tp)

end

function s.atkcon(e)
    local ph=Duel.GetCurrentPhase()
    return ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL
end

function s.atktg(e,c)
    local bc=c:GetBattleTarget()
    return bc and c:GetColumnGroup():IsContains(bc)
end