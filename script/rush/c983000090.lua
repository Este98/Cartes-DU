--Hungry Burger (Rush)
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
    --Change name to "Hungry Burger"
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_ALL)
	e1:SetValue(30243636)
	c:RegisterEffect(e1)
end
s.listed_names={80811661} --"Hamburger Recipe"