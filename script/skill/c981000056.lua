-- Xyz Union
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.filter(c)
    return c:IsFaceup() and c:IsLevel(4)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end
    return aux.CanActivateSkill(tp)
        and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,0,2,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)

    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_MZONE,0,2,2,nil)
    if #g==2 then
        Duel.HintSelection(g)
        
        local tc=g:GetFirst()
        while tc do
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_XYZ_LEVEL)
            e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
            e1:SetValue(s.xyzlv3)
            e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
            tc:RegisterEffect(e1)
            
            local e2=e1:Clone()
            e2:SetValue(s.xyzlv5)
            tc:RegisterEffect(e2)
            
            tc=g:GetNext()
        end
    end
end

function s.xyzlv3(e,c)
    return 3
end

function s.xyzlv5(e,c)
    return 5
end