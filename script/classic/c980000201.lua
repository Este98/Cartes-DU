--Tri-Brigade Rendezvous
--Scripted by Hatter
local s,id=GetID()
function s.initial_effect(c)
	--ATK up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCountLimit(1,id)
	e1:SetCondition(aux.StatChangeDamageStepCondition)
	e1:SetTarget(s.atktg)
	e1:SetOperation(s.atkop)
	c:RegisterEffect(e1)
end
function s.filter(c,e)
	return c:IsFaceup() and c:IsRace(RACES_BEAST_BWARRIOR_WINGB)
		and c:IsCanBeEffectTarget(e) and c:IsLinked()
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_MZONE,0,1,nil,e) end
	local n=Duel.GetMatchingGroupCount(s.filter,tp,LOCATION_MZONE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	Duel.SelectTarget(tp,s.filter,tp,LOCATION_MZONE,0,1,n,nil,e)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if #g>0 then g:ForEach(s.op,e:GetHandler()) end
end
function s.op(tc,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESETS_STANDARD_PHASE_END)
	e1:SetValue(700)
	tc:RegisterEffect(e1)
end