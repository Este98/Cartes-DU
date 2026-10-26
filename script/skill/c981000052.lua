--Align the stars ! 
--Created by MRX

local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.revealfilter(c)
    return c:IsSetCard(SET_NUMBER) and c:IsType(TYPE_XYZ) and not c:IsPublic()
end

function s.lvfilter(c)
    return c:IsFaceup() and c:HasLevel()
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end

    return aux.CanActivateSkill(tp)
        and Duel.IsExistingMatchingCard(s.revealfilter,tp,LOCATION_EXTRA,0,1,nil)
        and Duel.IsExistingMatchingCard(s.lvfilter,tp,LOCATION_MZONE,0,1,nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
    Duel.RegisterFlagEffect(tp,id+100,0,0,0)

    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    local g=Duel.SelectMatchingCard(tp,s.revealfilter,tp,LOCATION_EXTRA,0,1,1,nil)
    if #g==0 then return end

    local tc=g:GetFirst()
    Duel.ConfirmCards(1-tp,tc)

    local rk=tc:GetRank()

    local sg=Duel.GetMatchingGroup(s.lvfilter,tp,LOCATION_MZONE,0,nil)
    local sc=sg:GetFirst()
    while sc do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CHANGE_LEVEL)
        e1:SetValue(rk)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
        sc:RegisterEffect(e1)
        sc=sg:GetNext()
    end

        local e2=Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_FIELD)
        e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
        e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
        e2:SetDescription(aux.Stringid(id,3))
        e2:SetTargetRange(1,0)
        e2:SetTarget(s.splimit)
        e2:SetReset(RESET_PHASE+PHASE_END)
        Duel.RegisterEffect(e2,tp)
    end

    function s.splimit(e,c,sump,sumtype,sumpos,targetp,se)
        return c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(SET_NUMBER)

end