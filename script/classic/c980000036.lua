--Marincess Current
--scripted by Larry126
local s,id=GetID()
function s.initial_effect(c)
	--Inflict Damage 400x the Link Rating of monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.damcon)
	e1:SetTarget(s.damtg)
	e1:SetOperation(s.damop)
	c:RegisterEffect(e1)
end
s.listed_series={SET_MARINCESS}
function s.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(SET_MARINCESS) and c:IsLinkMonster() and c:IsControler(tp)
end
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
	return s.cfilter(eg:GetFirst(),tp)
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetFirst():IsRelateToBattle() end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,eg:GetFirst():GetLink()*400)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ac=eg:GetFirst()
	Duel.Damage(p,ac:GetLink()*400,REASON_EFFECT)
	if Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,0,nil,tp):IsExists(Card.IsLinkAbove,1,nil,2)
		and ac:GetBattleTarget():IsLinkMonster() and ac:GetLink()>0 then
		Duel.BreakEffect()
		Duel.Damage(p,ac:GetBattleTarget():GetLink()*500,REASON_EFFECT)
	end
end