--Frightfur Leo (C)
local s,id=GetID()
function s.initial_effect(c)
	--Must be properly summoned before reviving
	c:EnableReviveLimit()
	--Fusion summon procedure
	Fusion.AddProcMix(c,true,true,34688023,aux.FilterBoolFunctionEx(Card.IsSetCard,SET_FLUFFAL))
	--Must be fusion summoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
end
s.listed_series={SET_FLUFFAL}
s.material_setcode={SET_FLUFFAL,SET_EDGE_IMP}
