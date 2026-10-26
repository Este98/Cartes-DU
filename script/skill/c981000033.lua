-- Darton portrait 
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end
    return aux.CanActivateSkill(tp)
        and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    
    local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
    local tc=g:GetFirst()
    
    if tc then
        Duel.HintSelection(g)
        
        local all_monsters=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
        local total_diff=0
        local mc=all_monsters:GetFirst()

        while mc do
            local cur_atk=mc:GetAttack()
            local org_atk=mc:GetBaseAttack()
            if cur_atk ~= org_atk then
                total_diff = total_diff + math.abs(cur_atk - org_atk)
            end
            mc=all_monsters:GetNext()
        end
        

        if total_diff > 0 then
            local e1=Effect.CreateEffect(c)
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_ATTACK) 
            e1:SetValue(total_diff)
            e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,Duel.GetTurnPlayer()==tp and 2 or 1)
            tc:RegisterEffect(e1)
        end
    end
end