--Supreme King's Kingdom
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
s.listed_series={SET_EVIL_HERO, SET_FUSION}
s.listed_names={CARD_DARK_FUSION}
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local c=e:GetHandler()
    --Dark Fusion ignore
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(72043279)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(0x5f)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,tp)
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
    e3:SetCode(EVENT_FREE_CHAIN)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e3:SetCountLimit(1)
    e3:SetRange(0x5f)
    e3:SetCondition(s.searchcon)
    e3:SetOperation(s.searchop)
    Duel.RegisterEffect(e3,tp)
end
function s.searchcon(e,tp,eg,ep,ev,re,r,rp)
    return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(s.hfilter, tp, LOCATION_HAND, 0, 1, nil, tp)
        and not Duel.HasFlagEffect(tp,id)
end
function s.searchop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_CARD,tp,id)
	--You can only use this Skill once per Duel
	Duel.RegisterFlagEffect(tp,id,0,0,0)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local tg=Duel.SelectMatchingCard(tp, s.hfilter, tp, LOCATION_HAND, 0, 1, 1, nil, tp)
    if #tg>0 and Duel.SendtoDeck(tg, nil, 1, REASON_EFFECT)~=0 then
        local tgc=tg:GetFirst()
        Duel.BreakEffect()
        Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
        local g=Duel.SelectMatchingCard(tp, s.dfilter, tp, LOCATION_DECK, 0, 1, 1, nil, tgc:GetCode())
        Duel.SendtoHand(g, tp, REASON_EFFECT)
        Duel.ConfirmCards(1-tp, g)
        Duel.ShuffleHand(tp)
        Duel.ShuffleDeck(tp)
    end
end
function s.hfilter(c,tp)
    return c:IsAbleToDeck() and (c:IsSetCard(SET_EVIL_HERO) 
        or (c:IsSpell() and c:IsSetCard(SET_FUSION)))
        and Duel.IsExistingMatchingCard(s.dfilter, tp, LOCATION_DECK, 0, 1, nil, c:GetCode())
end
function s.dfilter(c,code)
    return c:IsAbleToHand() and not c:IsCode(code) and (c:IsSetCard(SET_EVIL_HERO) or c:IsCode(CARD_DARK_FUSION))
end