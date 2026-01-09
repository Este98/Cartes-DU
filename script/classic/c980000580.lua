--Ritual Beast Ulti-Gaiapelio
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	Fusion.AddProcMix(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,SET_RITUAL_BEAST_ULTI),aux.FilterBoolFunctionEx(Card.IsSetCard,SET_RITUAL_BEAST_TAMER),aux.FilterBoolFunctionEx(Card.IsSetCard,SET_SPIRITUAL_BEAST))
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(aux.fuslimit)
	c:RegisterEffect(e3)
end
s.listed_series={SET_RITUAL_BEAST,SET_RITUAL_BEAST_ULTI,SET_RITUAL_BEAST_TAMER,SET_SPIRITUAL_BEAST}
s.material_setcode={SET_RITUAL_BEAST,SET_RITUAL_BEAST_TAMER,SET_SPIRITUAL_BEAST,SET_RITUAL_BEAST_ULTI}
