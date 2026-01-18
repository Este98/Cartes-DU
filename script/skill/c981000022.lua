--Aroma Strategy (DU)
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per Duel check
    if Duel.GetFlagEffect(tp,id)>0 then return end
    return aux.CanActivateSkill(tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,0,id)
    --Once per duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,0))
	Duel.SelectCardsFromCodes(tp,0,1,true,false,tc:GetCode())
end