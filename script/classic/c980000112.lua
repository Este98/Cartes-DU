--Bloom Diva the Melodious Choir
local s,id=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	Fusion.AddProcMix(c,true,true,aux.FilterBoolFunctionEx2(Card.IsMelodiousSongtress),aux.FilterBoolFunctionEx(Card.IsSetCard,SET_MELODIOUS))
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--avoid battle damage
	local e3=e1:Clone()
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e3)
end
s.listed_series={SET_MELODIOUS_MAESTRA,SET_MELODIOUS}
s.material_setcode={SET_MELODIOUS,SET_MELODIOUS_MAESTRA}