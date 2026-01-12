--Feeling the Storm
local s,id=GetID()
function s.initial_effect(c)
	aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>1 then return end
	--condition
	return aux.CanActivateSkill(tp) and Duel.IsPlayerCanDraw(tp,1)
        and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_GRAVE,0,5,nil)
end
function s.filter(c)
	return c:IsLinkMonster() and c:IsAbleToDeck()
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
    local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_GRAVE,0,5,5,nil)
	Duel.HintSelection(g)
	Duel.ConfirmCards(1-tp, g)
    if #g==5 and Duel.SendtoDeck(g,nil,SEQ_DECKTOP,REASON_EFFECT)~=0 then
        Duel.BreakEffect()
        Duel.Draw(tp,1,REASON_EFFECT)
    end
end