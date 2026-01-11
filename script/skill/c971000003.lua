-- Monster Reincarnation
-- Skill : Send un Niveau 7+ de ta main, récupère un monstre Niveau 4 du cimetière à la main
local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

-- Condition pour pouvoir activer le Skill
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    -- Une seule fois par Duel
    if Duel.GetFlagEffect(tp,id)~=0 then return end
    -- return Monstre level 7+ dans la main et monstre level 4 dans le cimetière 
    return Duel.IsExistingMatchingCard(s.disfilter,tp,LOCATION_HAND,0,1,nil) and Duel.IsExistingMatchingCard(s.monfilter,tp,LOCATION_GRAVE,0,1,nil)
end

function s.disfilter(c)
	return c:IsDiscardable() and c:IsMonster() and c:IsLevelAbove(7)
end
function s.monfilter(c)
	return c:IsMonster() and c:IsAbleToHand() and c:IsLevel(4)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    -- Affiche le flip du Skill
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    -- Once per Duel
    Duel.RegisterFlagEffect(tp,id,0,0,1)
	--Cost
	Duel.DiscardHand(tp,s.disfilter,1,1,REASON_COST|REASON_DISCARD)
    -- Target
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectMatchingCard(tp,s.monfilter,tp,LOCATION_GRAVE,0,1,1,nil)
    -- Effect
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
    Duel.ConfirmCards(1-tp, tc)
end