--Reincarnation Ritual
local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    --Once per Duel check
    if Duel.GetFlagEffect(tp,id)>0 then return end
    return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(s.rsfilter,tp,LOCATION_HAND,0,1,nil,tp)
end
function s.rsfilter(c,tp)
    local p=tp
    return c:IsRitualSpell() and c:IsAbleToGrave() and Duel.IsExistingMatchingCard(s.rmfilter,tp,LOCATION_GRAVE,0,1,nil,c,p)
end
function s.rmfilter(c,mc,tp)
    local g=Duel.GetMatchingGroup(s.tfilter,tp,LOCATION_HAND|LOCATION_MZONE,0,nil)
    local lv=c:GetLevel()
    local ct=#g
    return c:IsRitualMonster() and ct>0 and g:CheckWithSumEqual(Card.GetLevel,lv,1,ct)
        and (mc.fit_monster and c:IsCode(table.unpack(mc.fit_monster)) or mc:ListsCode(c:GetCode())
        or mc.fit_series and c:IsSetCard(table.unpack(mc.fit_series)) or mc:ListsArchetype(c:GetSetCard()))
end
function s.tfilter(c)
    return c:HasLevel() and c:IsCanBeRitualMaterial()
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,0,id)
    --Once per duel
    Duel.RegisterFlagEffect(tp,id,0,0,0)
    --Select and send to GY 1 Ritual Spell from hand
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local sc=Duel.SelectMatchingCard(tp,s.rsfilter,tp,LOCATION_HAND,0,1,1,nil,tp):GetFirst()
    Duel.SendtoGrave(sc,REASON_EFFECT)
    --Select and Ritual Summon 1 Ritual Monster from GY
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local p=tp
    local tc=Duel.SelectMatchingCard(tp,s.rmfilter,tp,LOCATION_GRAVE,0,1,1,nil,sc,p):GetFirst()
    Duel.HintSelection(tc)
    --Ritual Summon it
    --Note : I'm not using classic Ritual Summon procedure because it's a skill effect
    local lv = tc:GetLevel()
    local mg = Duel.GetRitualMaterial(tp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
    local mat = mg:SelectWithSumEqual(tp,Card.GetLevel,lv,1,99,tc)
    Duel.ReleaseRitualMaterial(mat)
    Duel.BreakEffect()
    Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
    tc:CompleteProcedure()
end
