--Reload
--Created by MRX

local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end

    return aux.CanActivateSkill(tp)
        and Duel.GetTurnCount()>=5
        and Duel.IsPlayerCanDraw(tp)
        and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    Duel.RegisterFlagEffect(tp,id,0,0,0)

    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
    local count=#g

    if #g>0 then
        Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
        Duel.ShuffleDeck(tp)
        Duel.BreakEffect()
        Duel.Draw(tp,#g,REASON_EFFECT)
    end

end