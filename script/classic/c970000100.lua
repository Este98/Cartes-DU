--Rex, Gale Fur Hire
--scripted by Naim
local s,id=GetID()
function s.initial_effect(c)
	--Draw 1 card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.drwcon)
	e1:SetTarget(s.drwtg)
	e1:SetOperation(s.drwop)
	c:RegisterEffect(e1)
end
s.listed_names={id}
s.listed_series={SET_FUR_HIRE}
function s.drwconfilter(c,opp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsControler(opp) and c:IsReason(REASON_EFFECT)
end
function s.drwcon(e,tp,eg,ep,ev,re,r,rp)
	return re and not re:GetHandler():IsSetCard(SET_FUR_HIRE) and eg:IsExists(s.drwconfilter,1,nil,1-tp)
end
function s.drwtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,SET_FUR_HIRE),tp,LOCATION_MZONE,0,1,e:GetHandler())
		and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.drwop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end