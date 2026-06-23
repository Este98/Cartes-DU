--Deck Master : Chorus in the Sky
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.AddPreDrawSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return Duel.GetCurrentChain()==0 and Duel.GetTurnCount()==1
        and Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_DECK|LOCATION_HAND, 0, 3, nil, 56433456)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    local g=Duel.GetMatchingGroup(Card.IsCode, tp, LOCATION_DECK|LOCATION_HAND, 0, nil, 56433456)
    if #g==3 then
        Duel.ConfirmCards(1-tp, g)
        Duel.ShuffleHand(tp)
        local ck1=Duel.CreateToken(tp, 64927055)
        local ck2=Duel.CreateToken(tp, 64927055)
        local ck3=Duel.CreateToken(tp, 64927055)
        local cg=Group.FromCards(ck1, ck2, ck3)
        Duel.ConfirmCards(1-tp, cg)
        Duel.SendtoDeck(cg, nil, 0, REASON_RULE)
        Duel.ShuffleDeck(tp)
    end
end