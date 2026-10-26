-- Re:Ex portrait
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,nil,nil)
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_STARTUP)
    e1:SetCountLimit(1)
    e1:SetRange(0x5f)
    e1:SetLabel(0)
    e1:SetOperation(s.flipop)
    c:RegisterEffect(e1)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    return aux.CanActivateSkill(tp) and not Duel.HasFlagEffect(tp,id) 
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    Duel.RegisterFlagEffect(tp,id,0,0,1)

    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_BATTLE_START)
    e1:SetCondition(s.atkcon)
    e1:SetOperation(s.atkop)
    Duel.RegisterEffect(e1,tp)
end

function s.atkcon(e,tp,eg,ep,ev,re,r,rp)

    if Duel.HasFlagEffect(tp,id+100) then return false end

    local a=Duel.GetAttacker()
    local d=Duel.GetAttackTarget()
    if not d then return false end

    local my_mon = nil
    local opp_mon = nil

    if a:IsControler(tp) then
        my_mon = a
        opp_mon = d
    elseif d:IsControler(tp)then
        my_mon = d
        opp_mon = a
    end

    if not my_mon or not opp_mon then return false end

    return my_mon:IsRace(RACE_DINOSAUR) and my_mon:IsLevelBelow(4)
        and opp_mon:IsLocation(LOCATION_MZONE) and (opp_mon:GetSequence()==5 or opp_mon:GetSequence()==6)
end

function s.atkop(e,tp,eg,ep,ev,re,r,rp)
    local a=Duel.GetAttacker()
    local d=Duel.GetAttacker()

    local tc = a:IsControler(tp) and a or d

    if tc then
        if Duel.SelectYesNo(tp, aux.Stringid(id,0) or 95) then
            Duel.Hint(HINT_CARD,tp,id)

            Duel.RegisterFlagEffect(tp,id+100,REASON_EFFECT+PHASE_END,0,1)

            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_ATTACK)
            e1:SetValue(500)
            e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
            tc:RegisterEffect(e1)
        end
    end
end