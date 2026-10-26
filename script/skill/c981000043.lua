-- I'm ascending ! 
-- Created by MRX

local s,id=GetID()

local cardsoul=88301833

function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,nil,nil)
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_STARTUP)
    e1:SetCountLimit(1)
    e1:SetRange(0x5f)
    e1:SetLabel(0)
    e1:SetOperation(s.flipop)
    c:RegisterEffect(e1)
end
    
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()

    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    local tc=Duel.GetFirstMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,nil,cardsoul)
    if tc and Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then

        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
        e1:SetRange(LOCATION_SZONE)
        e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
        e1:SetValue(1)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
        tc:RegisterEffect(e1)

        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        e2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
        e2:SetCountLimit(1)
        e2:SetOperation(s.backtodeck)
        Duel.RegisterEffect(e2,tp)
    end
end

function s.backtodeck(e,tp,eg,ep,ev,re,r,rp)

    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)

    local g=Duel.SelectMatchingCard(tp,Card.IsAbleToBottomDeck,tp,LOCATION_HAND,0,1,1,nil)

    if #g>0 then
        Duel.BreakEffect()
        Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
    end

end