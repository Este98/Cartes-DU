-- Skill : Gain de LP = ATK +100 (terrain actuel uniquement)
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
    -- Effet continu : se déclenche à chaque gain de LP
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_RECOVER)
    e1:SetOperation(s.atkop)
    Duel.RegisterEffect(e1,tp)
end

function s.atkop(e,tp,eg,ep,ev,re,r,rp)
    -- Seulement si le joueur du Skill récupère des LP
    if ep~=tp then return end

    -- Monstres face recto ACTUELLEMENT sur le terrain
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
    for tc in aux.Next(g) do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(200)
        -- Reset standard : l’ATK reste tant que le monstre reste sur le terrain
        e1:SetReset(RESET_EVENT+RESETS_STANDARD)
        tc:RegisterEffect(e1)
    end
end
