
--ライトロード・スピリット シャイア
--Shire, Lightsworn Spirit
local s,id=GetID()
function s.initial_effect(c)
	--atk def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(s.value)
	c:RegisterEffect(e1)
end
s.listed_series={SET_LIGHTSWORN}
function s.filter(c)
	return c:IsSetCard(SET_LIGHTSWORN) and c:IsMonster()
end
function s.value(e,c)
	local g=Duel.GetMatchingGroup(s.filter,c:GetControler(),LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	return ct*300
end
