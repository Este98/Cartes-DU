--Witchcrafter Madame Verre
--scripted by Naim
local s,id=GetID()
function s.initial_effect(c)
	--Increase ATK/DEF of your battling Spellcaster monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.atkcon)
	e1:SetTarget(s.atktg)
	e1:SetOperation(s.atkop)
	c:RegisterEffect(e1)
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc,bc=Duel.GetBattleMonster(tp)
	return tc and bc and tc:IsRace(RACE_SPELLCASTER) and bc:IsControler(1-tp)
end
function s.rvfilt(c)
	return c:IsSpell() and not c:IsPublic()
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.rvfilt,tp,LOCATION_HAND,0,1,nil) end
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc,bc=Duel.GetBattleMonster(tp)
	if tc:IsRelateToBattle() and tc:IsFaceup() and tc:IsControler(tp) then
		local sg=Duel.GetMatchingGroup(s.rvfilt,tp,LOCATION_HAND,0,nil)
		local ct=sg:GetClassCount(Card.GetCode)
		local g=aux.SelectUnselectGroup(sg,e,tp,1,ct,aux.dncheck,1,tp,HINTMSG_CONFIRM)
		if #g>0 then
			Duel.ConfirmCards(1-tp,g)
			Duel.ShuffleHand(tp)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(#g*1000)
			e1:SetReset(RESETS_STANDARD_PHASE_END)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			tc:RegisterEffect(e2)
		end
	end
end