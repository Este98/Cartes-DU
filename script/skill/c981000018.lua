--Data Recovery System
local s,id=GetID()
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
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local c=e:GetHandler()
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetCountLimit(1)
    e1:SetCondition(s.skillcon)
    e1:SetOperation(s.skillop)
    Duel.RegisterEffect(e1,tp)
end
function s.filter(c,id)
    return c:GetReason()&(REASON_LINK|REASON_MATERIAL)==(REASON_LINK|REASON_MATERIAL) and c:IsMonster() and c:GetTurnID()==id and c:IsAbleToHand()
end
function s.skillcon(e,tp,eg,ep,ev,re,r,rp)
    local tid=Duel.GetTurnCount()
    return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(Card.IsAbleToGrave, tp, LOCATION_HAND, 0, 1, nil)
        and Duel.IsExistingMatchingCard(s.filter, tp, LOCATION_GRAVE, 0, 1, nil, tid)
end
function s.skillop(e,tp,eg,ep,ev,re,r,rp)
    if not Duel.SelectYesNo(tp, aux.Stringid(id,0)) then return end
    Duel.Hint(HINT_CARD,tp,id)
    local tid=Duel.GetTurnCount()
    local dis=Duel.SelectMatchingCard(tp, Card.IsAbleToGrave, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.SendtoGrave(dis, REASON_DISCARD)
    local g=Duel.SelectMatchingCard(tp, s.filter, tp, LOCATION_GRAVE, 0, 1, 1, nil, tid)
    if #g>0 then
        Duel.HintSelection(g)
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end