--Geological survey
--Created by MRX

local s,id=GetID()
function s.initial_effect(c)
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return end
    return aux.CanActivateSkill(tp) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
    Duel.Hint(HINT_CARD,tp,id)

    Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
   
    local deck_count=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
    local count=math.min(3,deck_count)

    local g=Duel.GetDecktopGroup(tp,count)
    Duel.ConfirmCards(tp,g)

    local op=Duel.SelectOption(tp,aux.Stringid(id,1),aux.Stringid(id,2))

    if op==0 then
        Duel.MoveToDeckTop(g,tp)
    else
        Duel.MoveToDeckBottom(g,tp)
    end
end