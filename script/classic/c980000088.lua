--Dogmatika Fleurdelis, the Knighted
--Logical Nonsense
--Substitute ID
local s,id=GetID()
function s.initial_effect(c)
	--Negate effects of monster SS from Extra Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id, 1))
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCondition(s.negcon)
    e1:SetTarget(s.negtg)
    e1:SetOperation(s.negop)
	c:RegisterEffect(e1)
	--Increase its ATK
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,{id,2})
	e4:SetCondition(s.atkcon)
	e4:SetOperation(function(e) e:GetHandler():UpdateAttack(500) end)
	c:RegisterEffect(e4)
end
	--Lists "Dogmatika" archetype
s.listed_series={SET_DOGMATIKA}
	--Specifically lists itself
s.listed_names={id}
	--If special summoned from extra deck
function s.cfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
    --If another "Dogmatika" monster is on your field
function s.dogmafilter(c)
    return c:IsSetCard(SET_DOGMATIKA) and not c:IsCode(69680031) --Code for Dogmatika Fleurdelis, the Knighted
end
    --Activation legality
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(s.cfilter, tp, LOCATION_MZONE, LOCATION_MZONE, 1, nil)
        and Duel.IsExistingMatchingCard(s.dogmafilter, tp, LOCATION_MZONE, 0, 1, nil)
end
    --Check and select existing target
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,s.cfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
    --Negate effects of monster SS from Extra Deck
function s.negop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsDisabled() and tc:IsSummonLocation(LOCATION_EXTRA) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESETS_STANDARD_PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESETS_STANDARD_PHASE_END)
		tc:RegisterEffect(e2)
    end
end
	--If your "Dogmatika" monster declares an attack
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and at:IsSetCard(SET_DOGMATIKA)
end