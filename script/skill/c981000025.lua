--Extra Curse
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
    --Register Special Summons from the Extra Deck
	aux.GlobalCheck(s,function()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(s.checkop)
		Duel.RegisterEffect(ge1,0)
	end)
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
    for tc in eg:Iter() do
        if tc:IsSummonLocation(LOCATION_EXTRA) then
            local sp=tc:GetSummonPlayer()
            Duel.RegisterFlagEffect(1-sp,id,RESET_PHASE|PHASE_END,0,2)
        end
    end
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per Duel check
    if Duel.GetFlagEffect(tp,id+1)>0 then return end
    --condition
    return Duel.HasFlagEffect(tp,id) and aux.CanActivateSkill(tp)
        and Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)<Duel.GetFieldGroupCount(1-tp,LOCATION_EXTRA,0)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    --Once per Duel
    Duel.RegisterFlagEffect(tp,id+1,0,0,0)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local tc=Duel.SelectMatchingCard(tp, Card.IsFaceup, tp, 0, LOCATION_EMZONE, 1, 1,nil):GetFirst()
    if tc then
        Duel.HintSelection(tc)
        local atk=Duel.GetFieldGroupCount(1-tp,LOCATION_EXTRA,0)-Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)
        --Decrease ATK/DEF by the differents in each player's Extra Deck
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(-atk*300)
        e1:SetReset(RESET_EVENT|RESETS_STANDARD|RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
        local e2=e1:Clone()
        e2:SetCode(EFFECT_UPDATE_DEFENSE)
        tc:RegisterEffect(e2)
    end
end