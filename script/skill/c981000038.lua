-- Rock spirit portrait 
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
    e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE) -- Concerne uniquement ton terrain
    e1:SetCondition(s.atkcon)
    e1:SetTarget(s.atktg)
    e1:SetValue(300)
    Duel.RegisterEffect(e1,tp)
end

function s.atkcon(e)
    local ph=Duel.GetCurrentPhase()
    return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end

function s.atktg(e,c)
    return c:IsRace(RACE_ROCK)
end