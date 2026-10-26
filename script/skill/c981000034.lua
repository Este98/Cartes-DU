-- Portrait of the armageddon
--Created by MRX
local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop,1)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    return aux.CanActivateSkill(tp)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(s.descon)
    e1:SetOperation(s.desop)
    Duel.RegisterEffect(e1,tp)
end

function s.ritfilter(c,tp)
    return c:IsControler(tp) and c:IsRitualMonster() and c:IsAttribute(ATTRIBUTE_DARK) 
        and c:IsLevel(4) and c:IsSummonType(SUMMON_TYPE_RITUAL)
end

function s.descon(e,tp,eg,ep,ev,re,r,rp)
    return eg:IsExists(s.ritfilter,1,nil,tp) 
        and Duel.GetFlagEffect(tp,id)<2
        and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end

function s.desop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetFlagEffect(tp,id)>=2 then return end
    if not Duel.SelectYesNo(tp,aux.Stringid(id,0)) then return end
    
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    
    Duel.Hint(HINT_CARD,tp,id)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
    if #g>0 then
        Duel.HintSelection(g)
        Duel.Destroy(g,REASON_EFFECT)
    end
end