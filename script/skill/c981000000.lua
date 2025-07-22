--Gimmick Puppet - 4 or 8
local s, id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>1 then return end
	--condition
    local b1= Duel.IsExistingMatchingCard(s.filterh, tp, LOCATION_HAND, 0, 1, nil)
    local b2= Duel.IsExistingMatchingCard(s.filterf, tp, LOCATION_MZONE, 0, 1, nil)
	return aux.CanActivateSkill(tp) and (b1 or b2)
end
function s.filterh(c)
    return Card.IsSetCard(c, 0x1083) and Card.IsLevel(c, 8)
end
function s.filterf(c)
    return Card.IsSetCard(c, 0x1083) and not Card.IsLevel(c, 8)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    --used skill flag register
    Duel.RegisterFlagEffect(ep,id,0,0,0)
    --Skill negation check
    if aux.CheckSkillNegation(e,tp) then return end
	local c=e:GetHandler()
    local b1= Duel.IsExistingMatchingCard(s.filterh, tp, LOCATION_HAND, 0, 1, nil)
    local b2= Duel.IsExistingMatchingCard(s.filterf, tp, LOCATION_MZONE, 0, 1, nil)
    local op=Duel.SelectEffect(tp,{b1,aux.Stringid(id,0)},{b2,aux.Stringid(id,1)})
    if not (b1 or b2) then return false end
    if b1 and op==1 then
        local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0):Filter(s.filterh, nil, 1)
        for tc in aux.Next(hg) do
		    local e1=Effect.CreateEffect(c)
		    e1:SetType(EFFECT_TYPE_SINGLE)
		    e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
		    e1:SetValue(4)
		    e1:SetReset(RESET_EVENT|RESETS_STANDARD-RESET_TOFIELD|RESET_PHASE|PHASE_END)
		    tc:RegisterEffect(e1)
        end
        local e2=Effect.CreateEffect(c)
	    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	    e2:SetCode(EVENT_TO_HAND)
	    e2:SetReset(RESET_PHASE|PHASE_END)
	    e2:SetOperation(s.hlvop)
	    Duel.RegisterEffect(e2,tp)
    elseif b2 and op==2 then
        local hg=Duel.GetFieldGroup(tp, LOCATION_MZONE, 0):Filter(s.filterf, nil, 1)
        for tc in aux.Next(hg) do
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
		    e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
		    e1:SetValue(8)
		    e1:SetReset(RESET_EVENT|RESETS_STANDARD-RESET_TOFIELD|RESET_PHASE|PHASE_END)
		    tc:RegisterEffect(e1)
        end
	end
end
function s.hlvfilter(c,tp)
	return c:IsLevelAbove(1) and c:IsControler(tp)
end
function s.hlvop(e,tp,eg,ep,ev,re,r,rp)
	local hg=eg:Filter(s.hlvfilter,nil,tp)
	local tc=hg:GetFirst()
	for tc in aux.Next(hg) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
		e1:SetValue(4)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD-RESET_TOFIELD|RESET_PHASE|PHASE_END)
		tc:RegisterEffect(e1)
	end
end