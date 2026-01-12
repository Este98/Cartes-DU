-- See you later !
local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

-- Condition pour pouvoir activer le Skill
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    -- Une seule fois par Duel
    if Duel.GetFlagEffect(tp,id)~=0 then return end    
    -- Si un monstre dont le joueur est le propriétaire est sur son terrain
    return Duel.IsExistingMatchingCard(s.monfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function s.monfilter(c,tp)
    -- Si le joueur contrôle au moins un monstre DONT IL EST PROPRIÉTAIRE
    return c:IsFaceup() and c:IsAbleToHand() and c:IsMonster() and c:GetOwner()==tp
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    -- Affiche le flip du Skill
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    -- Once per Duel
    Duel.RegisterFlagEffect(tp,id,0,0,1)
    -- Sélection du monstre
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
    local tc=Duel.SelectMatchingCard(tp,s.monfilter,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
    -- Retour en main
    Duel.SendtoHand(tc,nil,REASON_RULE)
end