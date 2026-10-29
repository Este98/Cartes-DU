--GMX Associate Noma
--scripted by pyrQ & Este
local s,id=GetID()
function s.initial_effect(c)
	--If this card is Special Summoned by a monster effect: You can target 1 card each from your GY and your opponent's GY; place each card on either the top or bottom of the Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,{id,0})
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp) return re and re:IsMonsterEffect() end)
	e1:SetTarget(s.tdtg)
	e1:SetOperation(s.tdop)
	c:RegisterEffect(e1)
end
s.listed_series={SET_GMX}
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetTargetGroup(Card.IsAbleToDeck,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
	if chk==0 then return aux.SelectUnselectGroup(g,e,tp,2,2,aux.dpcheck(Card.GetControler),0) end
	local tg=aux.SelectUnselectGroup(g,e,tp,2,2,aux.dpcheck(Card.GetControler),1,tp,HINTMSG_TODECK)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,2,tp,0)
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e)
	if #tg==0 then return end
	local op,sequence=nil
	local your_g,opp_g=tg:Split(Card.IsControler,nil,tp)
	if #your_g>0 then
		s.place_on_top_or_bottom(your_g,tp,tp)
	end
	if #opp_g>0 then
		s.place_on_top_or_bottom(opp_g,1-tp,tp)
	end
end
function s.place_on_top_or_bottom(group,owner,trig_player)
	local op=nil
	if Duel.GetFieldGroupCount(owner,LOCATION_DECK,0)==0 then
		op=1
	else
		local offset=(owner~=trig_player) and 2 or 0
		op=Duel.SelectEffect(trig_player,
			{true,aux.Stringid(id,2+offset)},
			{true,aux.Stringid(id,3+offset)})
	end
	local sequence=op==1 and SEQ_DECKTOP or SEQ_DECKBOTTOM
	Duel.SendtoDeck(group,nil,sequence,REASON_EFFECT)
	if op==1 then Duel.ConfirmDecktop(owner,1) end
end