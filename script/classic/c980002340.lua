--World Legacy Guardragon Mardark
--Scripted by MRX

local s,id=GetID()

function s.initial_effect(c)
    --Opponent's monsters lose 500 ATK/DEF
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTargetRange(0,LOCATION_MZONE)
    e1:SetValue(-500)
    c:RegisterEffect(e1)

    local e2=e1:Clone()
    e2:SetCode(EFFECT_UPDATE_DEFENSE)
    c:RegisterEffect(e2)

    --Special Summon from hand
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_SPSUMMON_PROC)
    e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e3:SetRange(LOCATION_HAND)
    e3:SetCountLimit(1,id)
    e3:SetCondition(s.spcon)
    e3:SetOperation(s.spop)
    c:RegisterEffect(e3)

    --Add Level 9 monster from GY to hand
    local e4=Effect.CreateEffect(c)
    e4:SetCategory(CATEGORY_TOHAND)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e4:SetCode(EVENT_DESTROYED)
    e4:SetProperty(EFFECT_FLAG_DELAY)
    e4:SetCountLimit(1,id+1)
    e4:SetCondition(s.thcon)
    e4:SetTarget(s.thtg)
    e4:SetOperation(s.thop)
    c:RegisterEffect(e4)
end

--Banish 2 Normal Monsters from hand or GY
function s.rmfilter(c)
    return c:IsType(TYPE_NORMAL)
        and c:IsMonster()
        and c:IsAbleToRemoveAsCost()
end

function s.spcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(
            s.rmfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,2,c
        )
end

function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectMatchingCard(
        tp,s.rmfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,2,2,c
    )
    Duel.Remove(g,POS_FACEUP,REASON_COST)
end

--Destroyed on the field
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsPreviousLocation(LOCATION_ONFIELD)
        and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end

--Level 9 with different original Type and Attribute
function s.thfilter(c,rc)
    return c:IsLevel(9)
        and c:GetOriginalRace()~=rc:GetOriginalRace()
        and c:GetOriginalAttribute()~=rc:GetOriginalAttribute()
        and c:IsAbleToHand()
end

function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then
        return Duel.IsExistingMatchingCard(
            s.thfilter,tp,LOCATION_GRAVE,0,1,nil,c
        )
    end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end

function s.thop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(
        tp,s.thfilter,tp,LOCATION_GRAVE,0,1,1,nil,c
    )
    if #g>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
end
