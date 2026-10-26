-- Portrait of the alliance
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,nil,nil)
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_STARTUP)
    e1:SetCountLimit(1)
    e1:SetRange(0x5f)
    e1:SetLabel(0)
    e1:SetOperation(s.flipop)
    c:RegisterEffect(e1)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local player=c:GetControler()

    Duel.Hint(HINT_SKILL_FLIP,player,id|(1<<32))
    Duel.Hint(HINT_CARD,player,id)

    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetTargetRange(LOCATION_MZONE,0)
    e1:SetTarget(s.tg)
    e1:SetValue(s.val)
    Duel.RegisterEffect(e1,player)
end

function s.tg(e,c)
    return c:IsRace(RACE_WARRIOR)
end
function s.filter(c)
    return c:IsFaceup() and c:IsRace(RACE_WARRIOR|RACE_SPELLCASTER)
end
function s.val(e,c)
    return Duel.GetMatchingGroupCount(s.filter,c:GetControler(),LOCATION_MZONE,0,nil)*100
end   