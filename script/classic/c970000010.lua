--Guardian Ceal
local s,id=GetID()
function s.initial_effect(c)
	--sum limit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetCondition(s.sumlimit)
	c:RegisterEffect(e1)
end
s.listed_names={95638658}
function s.sumlimit(e)
	return not Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,95638658),e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end