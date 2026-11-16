--サイレント・ソードマン・ゼロ
--Silent Swordsman Zero
--Scripted by MRX
local s,id=GetID()
function s.initial_effect(c)
	--Increase this card's Level by 1 during your opponent's Standby Phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_LVCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE|PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(function(e,tp) return e:GetHandler():HasLevel() and not Duel.IsTurnPlayer(tp) end)
	e1:SetOperation(s.lvop)
	c:RegisterEffect(e1)
	--Gains ATK equal to the difference between its current Level and its original Level x 500
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(s.atkval)
	c:RegisterEffect(e2)
end
s.listed_names={CARD_SHINING_SARCOPHAGUS}
function s.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:HasLevel() then
		--Increase its Level by 1
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
	end
end

function s.atkval(e,c)
	local ct=c:GetLevel()-c:GetOriginalLevel()
	return ct>0 and ct*500 or 0
end
