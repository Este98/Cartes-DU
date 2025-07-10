--Toon Kingdom (B)
local s,id=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--change name
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(15259703)
	c:RegisterEffect(e2)
    --destroy replace
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT+EFFECT_DESTROY_REPLACE)
    e3:SetRange(LOCATION_FZONE)
    e3:SetTargetRange(LOCATION_MZONE, 0)
    c:RegisterEffect(e3)
end
s.listed_names={15259703}
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetDecktopGroup(tp,5):IsExists(Card.IsAbleToRemove,5,nil) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end