--Gate Guardian Ritual
local s,id=GetID()
function s.initial_effect(c)
    
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(s.target)
    e1:SetOperation(s.operation)
    c:RegisterEffect(e1)
end
s.fit_monster={25833572} --"Gate Guardian"
s.listed_names=CARDS_SANGA_KAZEJIN_SUIJIN
function s.guardianfilter(c,e,tp)
    return c:IsCode(25833572) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function s.matfilter(c)
    return c:IsCode(25955164, 62340868, 98434877) and c:IsAbleToGrave()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then
        local mg=Duel.GetMatchingGroup(s.matfilter,tp,LOCATION_HAND|LOCATION_ONFIELD,0,nil)
        return Duel.IsExistingMatchingCard(s.guardianfilter,tp,LOCATION_HAND|LOCATION_DECK,0,1,nil,e,tp)
            and mg:IsExists(Card.IsCode,1,nil,25955164) --Sanga
            and mg:IsExists(Card.IsCode,1,nil,62340868) --Kazejin
            and mg:IsExists(Card.IsCode,1,nil,98434877) --Suijin
    end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND|LOCATION_DECK)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
    local mg=Duel.GetMatchingGroup(s.matfilter,tp,LOCATION_HAND|LOCATION_ONFIELD,0,nil)
    if not (mg:IsExists(Card.IsCode,1,nil,25955164) --Sanga
        and mg:IsExists(Card.IsCode,1,nil,62340868) --Kazejin
        and mg:IsExists(Card.IsCode,1,nil,98434877)) --Suijin
        then return end

    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local tg=Duel.SelectMatchingCard(tp,s.guardianfilter,tp,LOCATION_HAND|LOCATION_DECK,0,1,1,nil,e,tp)
    if #tg>0 then
        local tc=tg:GetFirst()
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
        local mat1=mg:FilterSelect(tp,Card.IsCode,1,1,nil,25955164) --Sanga
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
        local mat2=mg:FilterSelect(tp,Card.IsCode,1,1,nil,62340868) --Kazejin
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
        local mat3=mg:FilterSelect(tp,Card.IsCode,1,1,nil,98434877) --Suijin
        mat1:Merge(mat2)
        mat1:Merge(mat3)
        Duel.SendtoGrave(mat1,REASON_MATERIAL+REASON_RITUAL)
        Duel.BreakEffect()
        Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
        tc:CompleteProcedure()
    end
end