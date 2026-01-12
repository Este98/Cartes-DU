--Wave Enlightment
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    -- Une fois par tour (reset phase end)
    if Duel.GetFlagEffect(tp,id)~=0 then return false end

    -- Condition : contrôle au moins 1 monstre ATK = DEF
    return Duel.IsExistingMatchingCard(s.eqfilter,tp,LOCATION_MZONE,0,1,nil)
end

function s.eqfilter(c)
    return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:GetAttack()==c:GetDefense()
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    -- Once per turn
    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)

    -- Récupère les monstres concernés
    local g=Duel.GetMatchingGroup(s.eqfilter,tp,LOCATION_MZONE,0,nil)
    for tc in aux.Next(g) do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(300)
        -- Reset en fin de tour
        e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e1)
    end
end