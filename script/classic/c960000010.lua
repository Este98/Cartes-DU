--Don Zaloog
--Script by Sora-nee
local s,id=GetID()
function s.initial_effect(c)
	--Activate 1 of these effects
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
    e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp) return ep==1-tp end)
    e1:SetTarget(s.efftg)
	e1:SetOperation(s.effop)
	c:RegisterEffect(e1)
end
function s.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
    local b1=Duel.IsPlayerCanDiscardDeck(1-tp,2)
    if chk==0 then return b1 end
    if b1==TRUE then
    e:SetLabel(op)
        e:SetCategory(CATEGORY_DECKDES)
        Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1,-tp,2)
    end
end
function s.effop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerCanDiscardDeck(1-tp,2) then
        Duel.DiscardDeck(1-tp,2,REASON_EFFECT)
    end
end