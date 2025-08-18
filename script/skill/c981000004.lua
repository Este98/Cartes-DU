--Barian's Pawn
--Scripted by Este
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
s.listed_names={47660516} --Rank-Up-Magic Barian's Force
function s.revfilter(c)
	return c:IsSetCard({SET_NUMBER_C, SET_CXYZ}) and c:IsType(TYPE_XYZ) and not c:IsPublic()
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end
    return aux.CanActivateSkill(tp) 
        and Duel.IsExistingMatchingCard(s.revfilter, tp, LOCATION_EXTRA, 0, 1, tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    --opd register
	Duel.RegisterFlagEffect(tp,id,0,0,0)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Check if Skill is negated
	if aux.CheckSkillNegation(e,tp) then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    --Reveal card from Extra Deck
    local rc=Duel.SelectMatchingCard(tp, s.revfilter, tp, LOCATION_EXTRA, 0, 1, 1, tp)
    Duel.ConfirmCards(1-tp, rc)
    Duel.ShuffleExtra(tp)
    --Shuffle a card to the Deck and add Barian's Force
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
    if #g>0 and Duel.SendtoDeck(g,nil,1,REASON_EFFECT)~=0 then
        Duel.ShuffleDeck(tp)
        Duel.BreakEffect()
        local rum=Duel.CreateToken(tp, 47660516)
        Duel.SendtoHand(rum, tp, REASON_EFFECT)
        Duel.ConfirmCards(1-tp, rum)
        Duel.ShuffleHand(tp)
    end
end