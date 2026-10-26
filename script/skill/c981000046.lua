--Tether of Defeat
--Created by MRX

local s,id=GetID()

function s.initial_effect(c)

    local e2=Effect.CreateEffect(c)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_STARTUP)
    e2:SetRange(0x5f)
    e2:SetOperation(s.autoflip)
    e2:SetCountLimit(1)
    c:RegisterEffect(e2)
end

function s.autoflip(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id | (1<<32))
    Duel.Hint(HINT_CARD,tp,id)

        --Effet continue
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS) --Effet Auto
    e1:SetCode(EVENT_BATTLE_DESTROYED) --Monstre est détruit au combat
    e1:SetRange(0x5f) --Effet proc zone Skill
    e1:SetCondition(s.mill_con) --Check si c'est un Monstre adverse - 1
    e1:SetOperation(s.mill_op) --Exécute le skill - 2
    Duel.RegisterEffect(e1,tp)
end

-- 1
function s.mill_con(e,tp,eg,ep,ev,re,r,rp)
    local c=eg:GetFirst()
    return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==1-tp
end

--2
function s.mill_op(e,tp,eg,ep,ev,re,r,rp)
    Duel.DiscardDeck(1-tp, 1, REASON_RULE)
end