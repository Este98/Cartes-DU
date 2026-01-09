--Frightfur Sheep
local s,id=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	Fusion.AddProcMix(c,true,true,61173621,aux.FilterBoolFunctionEx(Card.IsSetCard,SET_FLUFFAL))
end
s.listed_series={SET_FLUFFAL}
s.material_setcode={SET_FLUFFAL,SET_EDGE_IMP}