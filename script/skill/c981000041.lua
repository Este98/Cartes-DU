-- Frequency portrait
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)

    if not aux.CanActivateSkill(tp) then return false end
    if Duel.HasFlagEffect(tp,id) then return false end
    return Duel.IsMainPhase()
        and Duel.IsExistingMatchingCard(Card.IsCanRemoveCounter,tp,LOCATION_ONFIELD,0,1,nil,tp,COUNTER_SPELL,1,REASON_COST)
        and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)

    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
    Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,0))

    local g_counter=Duel.SelectMatchingCard(tp,Card.IsCanRemoveCounter,tp,LOCATION_ONFIELD,0,1,1,nil,tp,COUNTER_SPELL,1,REASON_COST)

    if #g_counter>0 then
        g_counter:GetFirst():RemoveCounter(tp,COUNTER_SPELL,1,REASON_COST)
    end

    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)

    local g_target=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
    local tc=g_target:GetFirst()

    if tc then

        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(500)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)

    end
end