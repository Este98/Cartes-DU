
--Arcana Reading
--Scripted by MRX

local s,id=GetID()
local LIGHT_BARRIER_CUSTOM=690000120

function s.initial_effect(c)
	--Flip a coin, apply appropriate effect based on result
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)

	--Normal summon 1 "Arcana Force" monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,{id,1})
	e2:SetCondition(s.nscon)
	e2:SetCost(Cost.SelfBanish)
	e2:SetTarget(s.nstg)
	e2:SetOperation(s.nsop)
	c:RegisterEffect(e2)
end

s.toss_coin=true
s.listed_names={CARD_LIGHT_BARRIER,LIGHT_BARRIER_CUSTOM}
s.listed_series={SET_ARCANA_FORCE}

--Recognize official and custom Light Barrier
function s.lbfilter(c)
	return c:IsFaceup()
		and c:IsCode(CARD_LIGHT_BARRIER,LIGHT_BARRIER_CUSTOM)
end

function s.thfilter(c)
	return c.toss_coin and c:IsAbleToHand() and not c:IsCode(id)
end

function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
			or Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_DECK,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function s.thop(e,tp,eg,ep,ev,re,r,rp)
	--Prevent GY effect during this turn
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE|PHASE_END,0,1)

	local sel
	if Duel.IsExistingMatchingCard(s.lbfilter,tp,LOCATION_FZONE,0,1,nil) then
		local self=Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
		local oppo=Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_DECK,1,nil)
		local op=Duel.SelectEffect(tp,
			{self,aux.GetCoinEffectHintString(COIN_HEADS)},
			{oppo,aux.GetCoinEffectHintString(COIN_TAILS)})
		if op==1 then
			sel=COIN_HEADS
		elseif op==2 then
			sel=COIN_TAILS
		else
			return
		end
	else
		sel=Duel.TossCoin(tp,1)
	end

	if sel==COIN_HEADS then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	elseif sel==COIN_TAILS then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(1-tp,Card.IsAbleToHand,tp,0,LOCATION_DECK,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
		end
	end
end

--GY effect cannot be activated during the turn this card was activated
function s.nscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,id)==0
end

function s.nsfilter(c)
	return c:IsSetCard(SET_ARCANA_FORCE) and c:IsSummonable(true,nil)
end

function s.nstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.IsExistingMatchingCard(s.nsfilter,tp,LOCATION_HAND,0,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end

function s.nsop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,s.nsfilter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
