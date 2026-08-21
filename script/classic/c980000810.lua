--Fortune Vision
--Scripted by Hatter
local s,id=GetID()
function s.initial_effect(c)
	--When this card is activated: You can add 1 "Fortune Lady" card from your Deck to your hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--Apply a "make the next battle damage you take this turn become 0" effect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(s.nodamcon)
	e3:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk) if chk==0 then return true end Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription()) end)
	e3:SetOperation(s.nodamop)
	c:RegisterEffect(e3)
end
s.listed_series={SET_FORTUNE_LADY}
function s.thfilter(c)
	return c:IsSetCard(SET_FORTUNE_LADY) and c:IsAbleToHand()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function s.nodamcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.confilter,1,nil,1-tp)
end
function s.nodamop(e,tp,eg,ep,ev,re,r,rp)
	--Make the next battle damage you take this turn become 0
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(id,5))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE|PHASE_DAMAGE_CAL|PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
