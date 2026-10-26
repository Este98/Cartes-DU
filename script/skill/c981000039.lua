-- Ape portrait
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.cfilter(c)
    return c:IsFaceup() and (c:IsCode(50781944) or c:IsCode(31975743) or c:IsCode(41098335) or c:IsCode(3030892) or c:IsCode(96914272))
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end

    return aux.CanActivateSkill(tp)
        and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
        and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil)
        and Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_MZONE,1,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
    
    Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
    
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
    local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
    local tc=g:GetFirst()
    
    if tc then
        Duel.HintSelection(g)
        Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
    end
end