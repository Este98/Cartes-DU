--Merciless Scorpion of Serket
--Scripted by The Razgriz
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--Must first be Special Summoned (from your hand) by banishing 1 Level 10 or higher monster from your hand or Deck, while you control "Temple of the Kings"
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(id,0))
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_HAND)
	e0:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e0:SetCondition(s.spcon)
	e0:SetTarget(s.sptg)
	e0:SetOperation(s.spop)
	c:RegisterEffect(e0)
	--Add 1 "Temple of the Kings", or 1 Spell that mentions it, from your Deck to your hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
    --atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(s.atkcon)
	e3:SetOperation(s.atkop)
	c:RegisterEffect(e3)
end
s.listed_names={CARD_TEMPLE_OF_THE_KINGS}
function s.spcostfilter(c,tp)
	return c:IsLevelAbove(10) and c:IsAbleToRemoveAsCost()
end
function s.spcon(e,c)
	if not c then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,CARD_TEMPLE_OF_THE_KINGS),tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(s.spcostfilter,tp,LOCATION_HAND|LOCATION_DECK,0,1,c)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local rg=Duel.GetMatchingGroup(s.spcostfilter,tp,LOCATION_HAND|LOCATION_DECK,0,c)
	local g=aux.SelectUnselectGroup(rg,e,tp,1,1,nil,1,tp,HINTMSG_REMOVE,nil,nil,true)
	if #g>0 then
		g:KeepAlive()
		e:SetLabelObject(g)
		return true
	end
	return false
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	g:DeleteGroup()
end
function s.thfilter(c)
	return (c:IsCode(CARD_TEMPLE_OF_THE_KINGS) or (c:IsSpell() and c:ListsCode(CARD_TEMPLE_OF_THE_KINGS))) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsRelateToBattle()
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE)
	c:RegisterEffect(e1)
end