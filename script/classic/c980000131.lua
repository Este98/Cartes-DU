--Witchcrafter Genni
--Scripted by ahtelel
local s,id=GetID()
function s.initial_effect(c)
	--Special Summon 1 "Witchcrafter" monster from your Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetHintTiming(0,TIMING_MAIN_END|TIMINGS_CHECK_MONSTER)
	e1:SetCondition(function() return Duel.IsMainPhase() end)
	e1:SetCost(aux.WitchcrafterDiscardAndReleaseCost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--Copy the effect of 1 "Witchcrafter" Spell in your GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,{id,1})
	e2:SetTarget(s.efftg)
	e2:SetOperation(s.effop)
	c:RegisterEffect(e2)
end
s.listed_names={64756282}
s.listed_series={SET_WITCHCRAFTER}
function s.copyfilter(c)
	return c:IsSetCard(SET_WITCHCRAFTER) and c:IsSpell() and c:IsAbleToRemoveAsCost()
		and c:CheckActivateEffect(true,true,false)~=nil
		and c:CheckActivateEffect(true,true,false):GetOperation()~=nil
end
function s.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() and Duel.IsExistingMatchingCard(s.copyfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sc=Duel.SelectMatchingCard(tp,s.copyfilter,tp,LOCATION_GRAVE,0,1,1,nil):GetFirst()
	Duel.Remove(Group.FromCards(sc,c),POS_FACEUP,REASON_COST)
	local te,ceg,cep,cev,cre,cr,crp=sc:CheckActivateEffect(true,true,true)
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
	Duel.ClearOperationInfo(0)
end
function s.effop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	e:SetLabelObject(te:GetLabelObject())
	local op=te:GetOperation()
	if op then
		op(e,tp,eg,ep,ev,re,r,rp)
	end
end