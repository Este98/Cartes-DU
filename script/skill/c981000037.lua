-- Enchanter portrait
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end
    return aux.CanActivateSkill(tp)
        and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
        and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
    Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)

    local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
    local tc=g:GetFirst()
    
    if tc then
        Duel.HintSelection(g)
        tc:AddCounter(0x1015,1)
    end
    
    if Duel.GetFlagEffect(tp,id+100)==0 then
        Duel.RegisterFlagEffect(tp,id+100,0,0,0)
        
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_FIELD)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetTargetRange(LOCATION_MZONE,0)
        e1:SetTarget(s.atkval_tg)
        e1:SetValue(s.atkval)
        Duel.RegisterEffect(e1,tp)
    end
end

function s.atkval_tg(e,c)
    return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end

function s.atkval(e,c)
    return Duel.GetCounter(0,LOCATION_ONFIELD,LOCATION_ONFIELD,0x1015)*300
end