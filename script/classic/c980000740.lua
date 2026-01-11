--Ojama King
local s,id=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	Fusion.AddProcMix(c,true,true,12482652,42941100,79335209)
	--disable field
	--disable field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetCondition(s.discon)
	e1:SetOperation(s.disop)
	c:RegisterEffect(e1)
end
s.material_setcode=SET_OJAMA
function s.discon(e)
	local c=e:GetHandler()
	return c:IsInExtraMZone()
end
function s.disop(e,tp)
	local c=e:GetHandler()
	local zone=c:GetColumnZone(LOCATION_ONFIELD, 0, 0, c:GetControler())
	return zone
end