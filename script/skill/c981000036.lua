-- Gaia of the eclipse portrait
-- Created by MRX

local s,id=GetID()

function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.tribute_light(c) return c:IsAttribute(ATTRIBUTE_LIGHT) end
function s.tribute_dark(c) return c:IsAttribute(ATTRIBUTE_DARK) end

function s.search_light(c) return c:IsLevel(4) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_WARRIOR) and c:IsAbleToHand() end
function s.search_dark(c) return c:IsLevel(4) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_WARRIOR) and c:IsAbleToHand() end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end
    if not aux.CanActivateSkill(tp) then return false end

    local b1 = not Duel.HasFlagEffect(tp,id+100) 
        and Duel.CheckReleaseGroupEx(tp,s.tribute_light,1,nil,REASON_EFFECT,false,nil)
        and Duel.IsExistingMatchingCard(s.search_dark,tp,LOCATION_DECK,0,1,nil)

    local b2 = not Duel.HasFlagEffect(tp,id+200) 
        and Duel.CheckReleaseGroupEx(tp,s.tribute_dark,1,nil,REASON_EFFECT,false,nil)
        and Duel.IsExistingMatchingCard(s.search_light,tp,LOCATION_DECK,0,1,nil)

    return b1 or b2
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)
    
    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
    
    local b1 = not Duel.HasFlagEffect(tp,id+100) 
        and Duel.CheckReleaseGroupEx(tp,s.tribute_light,1,nil,REASON_EFFECT,false,nil)
        and Duel.IsExistingMatchingCard(s.search_dark,tp,LOCATION_DECK,0,1,nil)

    local b2 = not Duel.HasFlagEffect(tp,id+200) 
        and Duel.CheckReleaseGroupEx(tp,s.tribute_dark,1,nil,REASON_EFFECT,false,nil)
        and Duel.IsExistingMatchingCard(s.search_light,tp,LOCATION_DECK,0,1,nil)

    local op=Duel.SelectEffect(tp,
        {b1, aux.Stringid(id,0)},
        {b2, aux.Stringid(id,1)})

    if op==1 then
        Duel.RegisterFlagEffect(tp,id+100,0,0,0)
        local sg=Duel.SelectReleaseGroupEx(tp,s.tribute_light,1,1,REASON_EFFECT,false,nil)
        Duel.Release(sg,REASON_EFFECT)
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
        local g=Duel.SelectMatchingCard(tp,s.search_dark,tp,LOCATION_DECK,0,1,1,nil)
        if #g>0 then
            Duel.SendtoHand(g,nil,REASON_EFFECT)
            Duel.ConfirmCards(1-tp,g)
        end
    elseif op==2 then
        Duel.RegisterFlagEffect(tp,id+200,0,0,0)
        local sg=Duel.SelectReleaseGroupEx(tp,s.tribute_dark,1,1,REASON_EFFECT,false,nil)
        Duel.Release(sg,REASON_EFFECT)
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
        local g=Duel.SelectMatchingCard(tp,s.search_light,tp,LOCATION_DECK,0,1,1,nil)
        if #g>0 then
            Duel.SendtoHand(g,nil,REASON_EFFECT)
            Duel.ConfirmCards(1-tp,g)
        end
    end
end