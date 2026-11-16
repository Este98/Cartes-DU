--デーモンの光来
--Archfiend's Advent
--scripted by MRX

local s,id=GetID()
function s.initial_effect(c)
	--Can be Normal Summoned without Tributing if you control "Shining Sarcophagus"
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.notribcon)
	c:RegisterEffect(e1)
	--Other monsters you control gain 500 ATK during your turn
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(function(e) return Duel.IsTurnPlayer(e:GetHandlerPlayer()) end)
	e4:SetTarget(function(e,c) return c~=e:GetHandler() end)
	e4:SetValue(500)
	c:RegisterEffect(e4)
end
s.listed_names={CARD_SHINING_SARCOPHAGUS}
function s.notribcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,CARD_SHINING_SARCOPHAGUS),tp,LOCATION_ONFIELD,0,1,nil)
end