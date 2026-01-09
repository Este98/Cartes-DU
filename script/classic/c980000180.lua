--幻奏の音姫マイスタリン・シューベルト
--Schuberta the Melodious Maestra
local s,id=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	Fusion.AddProcMixN(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,SET_MELODIOUS),2)
end
s.listed_series={SET_MELODIOUS}
s.material_setcode=SET_MELODIOUS