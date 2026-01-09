--Ojama Knight
local s,id=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	Fusion.AddProcMixN(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,SET_OJAMA),2)
end
s.listed_series={SET_OJAMA}
s.material_setcode={SET_OJAMA}