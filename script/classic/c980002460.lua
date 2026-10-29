--GMX Partner Selandea
--scripted by pyrQ
local s,id=GetID()
function s.initial_effect(c)
	--You can reveal this card in your hand; Special Summon 1 "GMX" monster or 1 level 4 or lower Dinosaur monster from your hand, also you can only attack with "GMX" monsters for the rest of this turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,{id,0})
	e1:SetCost(Cost.SelfReveal)
	e1:SetTarget(s.handsptg)
	e1:SetOperation(s.handspop)
	c:RegisterEffect(e1)
end
s.listed_series={SET_GMX}
function s.gmxdinospfilter(c,e,tp,pos)
	return (c:IsSetCard(SET_GMX) or (c:IsLevelBelow(4) and c:IsRace(RACE_DINOSAUR))) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.handsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.gmxdinospfilter,tp,LOCATION_HAND,0,1,nil,e,tp,POS_FACEUP) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function s.handspop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,s.gmxdinospfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,POS_FACEUP)
		if #g>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	local c=e:GetHandler()
	aux.RegisterClientHint(c,0,tp,1,0,aux.Stringid(id,2))
	--You can only attack with "GMX" monsters for the rest of this turn
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(function(e,c) return not c:IsSetCard(SET_GMX) end)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
end