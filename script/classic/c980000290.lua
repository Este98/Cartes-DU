--Ukiyoe-P.U.N.K. Sharakusai
local s,id=GetID()
function s.initial_effect(c)
	--Fusion Summon
	local fusparam=aux.FilterBoolFunction(Card.IsSetCard,SET_PUNK)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCost(Cost.PayLP(600))
	e1:SetTarget(Fusion.SummonEffTG(fusparam))
	e1:SetOperation(Fusion.SummonEffOP(fusparam))
	c:RegisterEffect(e1)
end
s.listed_series={SET_PUNK}