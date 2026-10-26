-- Android portrait
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
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetCountLimit(1) -- Une fois par tour
    e1:SetCondition(s.lpcon)
    e1:SetOperation(s.lpop)
    Duel.RegisterEffect(e1,tp)
end

function s.lpcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp
end

function s.filter(c)
    return c:IsFaceup() and c:IsRace(RACE_PSYCHIC)
end

function s.lpop(e,tp,eg,ep,ev,re,r,rp)
    -- On compte tes monstres Psychique face recto sur le terrain
    local count=Duel.GetMatchingGroupCount(s.filter,tp,LOCATION_MZONE,0,nil)
    if count>0 then
        Duel.Hint(HINT_CARD,tp,id)
        Duel.Recover(tp,count*300,REASON_EFFECT)
    end
end