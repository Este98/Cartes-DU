--Pendulum switch
--Created by MRX

local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.placefilter(c,name)
    return c:IsType(TYPE_PENDULUM) and not c:IsCode(name)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end

    local pzone_count=Duel.GetFieldGroupCount(tp,LOCATION_PZONE,0)

        return aux.CanActivateSkill(tp)
        and pzone_count==2
        and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,1,nil,TYPE_PENDULUM)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    Duel.RegisterFlagEffect(tp,id,0,0,0)

    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
    local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_PZONE,0,1,1,nil)
    if #sg==0 then return end

    local sc=sg:GetFirst()
    local name=sc:GetCode()

    local sequence=sc:GetSequence()

        Duel.HintSelection(sg)

   if Duel.SendtoHand(sc,nil,REASON_EFFECT)>0 and sc:IsLocation(LOCATION_HAND) then
        Duel.BreakEffect()

        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
        local g=Duel.SelectMatchingCard(tp,s.placefilter,tp,LOCATION_HAND,0,1,1,nil,name)

        if #g>0 then
            local tc=g:GetFirst()
            Duel.MoveToField(tc,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
        end
    end

end