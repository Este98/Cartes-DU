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
	--Trat it as a "Hungry" card even after name change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_ADD_SETCODE)
	e2:SetValue(0xF008)
	c:RegisterEffect(e2)
end
s.listed_names={80811661} --"Hamburger Recipe"