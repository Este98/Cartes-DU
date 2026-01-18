--Tunermorph : Normal
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per duel check
    if Duel.GetFlagEffect(ep,id)>0 then return false end
    --condition
    return Duel.IsExistingMatchingCard(s.monsterfilter,tp,LOCATION_MZONE,0,1,nil)
        and Duel.IsExistingMatchingCard(s.synchrofilter,tp,LOCATION_EXTRA,0,1,nil)
end
function s.monsterfilter(c)
    return c:IsFaceup() and c:IsType(TYPE_NORMAL)
end
function s.synchrofilter(c)
    return c:IsType(TYPE_SYNCHRO) and c.material and c.material~=""
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
    --used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
    local c=e:GetHandler()
    local tc=Duel.SelectMatchingCard(tp,s.monsterfilter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
    Duel.HintSelection(tc)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    local sc=Duel.SelectMatchingCard(tp,s.synchrofilter,tp,LOCATION_EXTRA,0,1,1,nil):GetFirst()
    Duel.ConfirmCards(1-tp,sc)

    local mat=sc.material
    --Debug.Message("mat type = "..type(mat))
    --Debug.Message("matname type = "..type(matname))
    local matname=mat[1]
    --Debug.Message("Selected Synchro Material Name: "..matname)

    local rev=sc:GetCode()
    Duel.RegisterFlagEffect(tp, id+100, RESET_PHASE+PHASE_END, 0, 1)
    aux.RegisterClientHint(c,0,tp,1,0,aux.Stringid(id,0))
    --Summon check
    local e0=Effect.CreateEffect(c)
    e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e0:SetCode(EVENT_SPSUMMON_SUCCESS+SUMMON_TYPE_SYNCHRO)
    e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
        local g=eg:Filter(function(c) return c:GetControler()==tp and c:IsCode(rev) end, nil)
        if #g>0 then
        Duel.ResetFlagEffect(tp, id+100)
        end
    end)
    e0:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e0,tp)
    --2000 damages if the player doesn't summon the selected Synchro Monster
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetCountLimit(1)
    e1:SetCondition(function(e,tp) return Duel.GetFlagEffect(tp, id+100)>0 end)
    e1:SetOperation(function(e,tp) Duel.SetLP(tp, Duel.GetLP(tp)-2000) end)
    e1:SetReset(RESET_PHASE+PHASE_END)
    Duel.RegisterEffect(e1,tp)
    --Change the name of the selected monster to the material's name
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_CHANGE_CODE)
    e2:SetValue(matname)
    e2:SetReset(RESET_EVENT+RESETS_STANDARD|RESET_PHASE+PHASE_END)
    tc:RegisterEffect(e2)
    --Make the selected monster a Tuner if it is not already
    if not tc:IsType(TYPE_TUNER) then
        local e3=Effect.CreateEffect(c)
        e3:SetType(EFFECT_TYPE_SINGLE)
        e3:SetCode(EFFECT_ADD_TYPE)
        e3:SetValue(TYPE_TUNER)
        e3:SetReset(RESET_EVENT+RESETS_STANDARD|RESET_PHASE+PHASE_END)
        tc:RegisterEffect(e3)
    end
end

