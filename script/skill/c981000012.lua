--Master of Rites
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,2,false,nil,nil)
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
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local c=e:GetHandler()
    if Duel.GetFlagEffect(tp,id+1)==0 then
        --Check LP loss
		local lp=Duel.GetLP(c:GetControler())
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ADJUST)
		e1:SetLabel(lp)
		e1:SetLabelObject(e)
		e1:SetCondition(s.lpcon)
		e1:SetOperation(s.lpop)
		Duel.RegisterEffect(e1,tp)
        --Add a card to your hand
        local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetCountLimit(1,{id,1})
		e2:SetLabel(0)
		e2:SetLabelObject(e)
		e2:SetCondition(s.con)
		e2:SetOperation(s.op)
		Duel.RegisterEffect(e2,tp)
    end
    Duel.RegisterFlagEffect(ep,id+1,0,0,0)
end
--Loose LP check
function s.lpcon(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetControler()
	return Duel.GetLP(p)~=e:GetLabel()
end
function s.lpop(e,tp,eg,ep,ev,re,r,rp)
    local p=e:GetHandler():GetControler()
	if Duel.GetLP(p)>e:GetLabel() then
		e:SetLabel(Duel.GetLP(p))
		return
	end
    e:GetLabelObject():SetLabel(e:GetLabelObject():GetLabel()+(e:GetLabel()-Duel.GetLP(p)))
    e:SetLabel(Duel.GetLP(p))
end
function s.con(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0)==0 then return end
	--Add Ritual Monster from Deck
	local opt1=Duel.IsExistingMatchingCard(Card.IsRitualMonster, tp, LOCATION_DECK, 0, 1, nil)
		and (e:GetLabel()==0 or (e:GetLabel()>1 and e:GetLabel()<3))
	--Add Ritual Spell from Deck
	local opt2=Duel.IsExistingMatchingCard(Card.IsRitualSpell, tp, LOCATION_DECK, 0, 1, nil)
		and e:GetLabel()<2
	return Duel.IsMainPhase() and Duel.IsTurnPlayer(tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck, tp, LOCATION_HAND, 0, 1, nil)
		and aux.CanActivateSkill(tp) and e:GetLabelObject():GetLabel()>=1000
		and (opt1 or opt2)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,tp,id)
	--Add Ritual Monster from Deck
	local opt1=Duel.IsExistingMatchingCard(Card.IsRitualMonster, tp, LOCATION_DECK, 0, 1, nil)
		and (e:GetLabel()==0 or (e:GetLabel()>1 and e:GetLabel()<3))
	--Add Ritual Spell from Deck
	local opt2=Duel.IsExistingMatchingCard(Card.IsRitualSpell, tp, LOCATION_DECK, 0, 1, nil)
		and e:GetLabel()<2
	if not (opt1 or opt2) then return end
	local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if #g1>0 and Duel.SendtoDeck(g1,nil,1,REASON_EFFECT)~=0 then
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
	else return end
	local op=Duel.SelectEffect(tp,
		{opt1,aux.Stringid(id,0)},
		{opt2,aux.Stringid(id,1)})
	if op==1 then
		local g=Duel.GetMatchingGroup(Card.IsRitualMonster, tp, LOCATION_DECK, 0, nil)
		local tc=g:RandomSelect(tp, 1):GetFirst()
		if tc and tc:IsAbleToHand() then
			Duel.SendtoHand(tc, nil, REASON_EFFECT)
			Duel.ConfirmCards(1-tp, tc)
		end
		e:GetLabelObject():SetLabel(0)
		e:SetLabel(e:GetLabel()+1)
	else
		local g=Duel.GetMatchingGroup(Card.IsRitualSpell, tp, LOCATION_DECK, 0, nil)
		local tc=g:RandomSelect(tp, 1):GetFirst()
		if tc and tc:IsAbleToHand() then
			Duel.SendtoHand(tc, nil, REASON_EFFECT)
			Duel.ConfirmCards(1-tp, tc)
		end
		e:GetLabelObject():SetLabel(0)
		e:SetLabel(e:GetLabel()+2)
	end
end