--Restart
--Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddPreDrawSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)

        Duel.Hint(HINT_SKILL_FLIP,tp,id | (1<<32))
        Duel.Hint(HINT_CARD, tp, id)
    
    if Duel.SelectYesNo(tp,aux.Stringid(id, 0)) then end
        local g=Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
        local count=#g

        if count>0 then

        Duel.ConfirmCards(1-tp,g)
        Duel.ShuffleHand(tp)

        Duel.SendtoDeck(g,nil,5, REASON_EFFECT)

        Duel.ShuffleDeck(tp)
        Duel.BreakEffect()
        Duel.Draw(tp, 5, REASON_EFFECT)
    end
end