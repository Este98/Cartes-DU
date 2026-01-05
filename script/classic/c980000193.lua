--Crystron Rosenix
local s,id=GetID()
local TOKEN_CRYSTRON=id+1
function s.initial_effect(c)
	--Special Summon 1 "Crystron Token"
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCost(Cost.SelfBanish)
	e2:SetTarget(s.tokentg)
	e2:SetOperation(s.tokenop)
	c:RegisterEffect(e2)
end
s.listed_names={TOKEN_CRYSTRON} --"Crystron Token"
s.listed_series={SET_CRYSTRON}
function s.tokentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_CRYSTRON,SET_CRYSTRON,TYPES_TOKEN,0,0,1,RACE_MACHINE,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function s.tokenop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_CRYSTRON,SET_CRYSTRON,TYPES_TOKEN,0,0,1,RACE_MACHINE,ATTRIBUTE_WATER) then
		local token=Duel.CreateToken(tp,TOKEN_CRYSTRON)
		if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then
			--It cannot be tributed
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(3303)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT|RESETS_STANDARD)
			token:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			token:RegisterEffect(e2,true)
		end
		Duel.SpecialSummonComplete()
	end
end