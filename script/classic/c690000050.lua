--外法の騎士
--Illegal Knight
--Scripted by MRX

local s,id=GetID()
function s.initial_effect(c)
	--Tribute Summon with 1 monster that mentions "Adventurer Token"
	aux.AddNormalSummonProcedure(c,true,false,1,1,SUMMON_TYPE_TRIBUTE,aux.Stringid(id,0),s.ntfilter)
	--Change control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_CONTROL+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,{id,1})
	e2:SetCondition(s.bravecon)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
end
s.listed_names={TOKEN_ADVENTURER}
function s.ntfilter(c)
	return c:IsMonster() and c:ListsCode(TOKEN_ADVENTURER)
end
function s.bravecon(e,tp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,TOKEN_ADVENTURER),tp,LOCATION_ONFIELD,0,1,nil)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToChangeControler()
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp,LOCATION_REASON_CONTROL)>0
		and Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not Duel.GetControl(c,1-tp) then return end
	local g=Duel.GetTargetCards(e)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
