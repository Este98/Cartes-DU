--鉄獣戦線 フラクトール
--Tri-Brigade Fraktall
local s,id=GetID()
function s.initial_effect(c)
    --Send 1 monster from Deck to GY
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,0))
    e1:SetCategory(CATEGORY_TOGRAVE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND|LOCATION_MZONE)
    e1:SetCountLimit(1,id)
    e1:SetCost(Cost.SelfToGrave)
    e1:SetTarget(s.gytg)
    e1:SetOperation(s.gyop)
    c:RegisterEffect(e1)
end
s.listed_series={SET_TRI_BRIGADE}

function s.gyfilter(c)
    return c:IsLevelBelow(3)
        and c:IsRace(RACES_BEAST_BWARRIOR_WINGB)
        and c:IsAbleToGrave()
end

function s.gytg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        return Duel.IsExistingMatchingCard(s.gyfilter,tp,LOCATION_DECK,0,1,nil)
    end
    Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end

function s.gyop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,s.gyfilter,tp,LOCATION_DECK,0,1,1,nil)
    if #g>0 then
        Duel.SendtoGrave(g,REASON_EFFECT)
    end
end
