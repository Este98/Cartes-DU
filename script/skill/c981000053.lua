--Pendulum shift 
--Created by MRX

local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.revealfilter(c)
    return c:IsType(TYPE_PENDULUM) and not c:IsPublic()
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end

    local lscale=Duel.GetFieldCard(tp, LOCATION_PZONE,0)
    local rscale=Duel.GetFieldCard(tp, LOCATION_PZONE,1)

    return aux.CanActivateSkill(tp)
        and lscale and rscale
        and Duel.IsExistingMatchingCard(s.revealfilter,tp,LOCATION_HAND,0,1,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    Duel.RegisterFlagEffect(tp,id,0,0,0)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)

    local g=Duel.SelectMatchingCard(tp,s.revealfilter,tp,LOCATION_HAND,0,1,1,nil)
    if #g==0 then return end
        local tc=g:GetFirst()
        Duel.ConfirmCards(1-tp,tc)
        local target_scale=tc:GetLeftScale()

        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)

        local sg=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_PZONE,0,1,1,nil)
    
    if #sg>0 then
        local sc=sg:GetFirst()
        Duel.HintSelection(sg)

        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CHANGE_LSCALE)
        e1:SetValue(target_scale)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD)
        sc:RegisterEffect(e1)

        local e2=e1:Clone()
        e2:SetCode(EFFECT_CHANGE_RSCALE)
        sc:RegisterEffect(e2)
    end
end