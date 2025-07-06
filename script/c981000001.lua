--Spiral Spear Strike (Skill)
local s,id=GetID()
function s.initial_effect(c)
    --skill
    aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end
local CARD_SPIRAL_STRIKE=49328340
s.listed_names={CARD_GAIA_CHAMPION,CARD_SPIRAL_STRIKE}
s.listed_series={0xbd}

function s.flipfilter(c)
    return c:IsFaceup() and (c:IsCode(CARD_GAIA_CHAMPION) or (c:IsSetCard(0xbd) 
    and c:IsAttackAbove(2300)))
end

function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
    if Duel.HasFlagEffect(tp,id) then return false end
    local ft=Duel.GetLocationCount(tp, LOCATION_SZONE)
    if ft<=0 then return false end
    return Duel.IsExistingMatchingCard(s.flipfilter, e:GetHandlerPlayer(), LOCATION_MZONE, 0, 1, nil)
end

function s.flipop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SKILL_FLIP, tp, id|1<<32)
    Duel.Hint(HINT_CARD, tp, id)
    --once per Duel register
    Duel.RegisterFlagEffect(tp, id, 0, 0, 0)
    --Check if the skill is negated ("Anti Skill")
    if aux.CheckSkillNegation(e,tp) then return end
    --Add Spiral Spear Strike on the field
    local token=Duel.CreateToken(tp, CARD_SPIRAL_STRIKE)
    Duel.MoveToField(token, tp, tp, LOCATION_SZONE, POS_FACEUP, true)
end