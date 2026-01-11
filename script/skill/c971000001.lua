-- I'm not done yet !
-- Skill : Fixe les LP à 2000 à partir du tour 5. (Once per duel)
local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end

-- Condition pour pouvoir activer le Skill
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    -- Une seule fois par Duel
    if Duel.HasFlagEffect(tp,id) then return end
    -- A partir du tour 5
    local lp=Duel.GetLP(tp)
    return Duel.GetTurnCount()>=5 and lp~=2000 and aux.CanActivateSkill(tp)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    -- Affiche le flip du Skill
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    -- Once per Duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    -- Fixe les Life Points à 2000
    Duel.SetLP(tp,2000)
end
