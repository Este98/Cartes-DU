-- Super Strength ! 
-- Skill : Fixe l'ATK d'un monstre à 2000 à partir du tour 5. (Once per duel)
local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

-- Condition pour pouvoir activer le Skill
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    -- Une seule fois par Duel
    if Duel.GetFlagEffect(tp,id)~=0 then return end
    -- A partir du tour 5 et nécessite un monstre sur le terrain
    return Duel.GetTurnCount()>=5 and Duel.IsExistingMatchingCard(s.monfilter,tp,LOCATION_MZONE,0,1,nil)
end


function s.monfilter(c)
    return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    -- Affiche le flip du Skill
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    -- Once per Duel
    Duel.RegisterFlagEffect(tp,id,0,0,1)
    -- Sélection du monstre
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local tc=Duel.SelectMatchingCard(tp,s.monfilter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
    if not tc then return end

    -- Set ATK to 2000 de façon permanente tant qu'il reste sur le terrain
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_ATTACK_FINAL)
    e1:SetValue(2000)
    e1:SetReset(RESET_EVENT+RESETS_STANDARD)
    tc:RegisterEffect(e1)
end
