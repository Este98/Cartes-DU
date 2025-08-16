--Numbers War
--Scripted by Este
local s,id=GetID()
function s.initial_effect(c)
    aux.EnableExtraRules(c,s,s.op)
end
function s.op(c)
    --indes by battle
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e1:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
    e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard, {SET_NUMBER, SET_CXYZ}))
    e1:SetValue(s.indvalue)
    Duel.RegisterEffect(e1, 0)
    --cannot leave the field
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    e2:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
    e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard, {SET_NUMBER, SET_CXYZ}))
    e2:SetValue(s.indvalue2)
    Duel.RegisterEffect(e2, 0)
    --[[local e3=e2:Clone()
    e3:SetCode(EFFECT_CANNOT_TO_DECK)
    Duel.RegisterEffect(e3, 0)
    local e4=e2:Clone()
    e4:SetCode(EFFECT_CANNOT_REMOVE)
    Duel.RegisterEffect(e4, 0)]]--
    --cannot target
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_FIELD)
    e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e5:SetTargetRange(LOCATION_MZONE, LOCATION_MZONE)
    e5:SetTarget(aux.TargetBoolFunction(Card.IsSetCard, {SET_NUMBER, SET_CXYZ}))
    e5:SetValue(s.tgtvalue)
    Duel.RegisterEffect(e5, 0)
end
function s.indvalue(e,c)
    return not c:IsSetCard({SET_NUMBER, SET_CXYZ})
end
function s.indvalue2(e,re)
    local rec=re:GetHandler()
    return not rec:IsSetCard({SET_NUMBER, SET_CXYZ}) and not rec:IsSpellTrap()
end
function s.tgtvalue(e,re,rp)
    local rec=re:GetHandler()
    return not rec:IsSetCard({SET_NUMBER, SET_CXYZ}) and not rec:IsSpellTrap()
end