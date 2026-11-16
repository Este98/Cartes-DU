--魔術師の弟子－ブラック・マジシャン・ガール
--Dark Magician Girl the Magician's Apprentice
--scripted by MRX

local s,id=GetID()
function s.initial_effect(c)
	--This card's name becomes "Dark Magician Girl"
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(CARD_DARK_MAGICIAN_GIRL)
	c:RegisterEffect(e1)
	-- This card is always treated as "Shining Sarcophagus" (Everywhere: Deck, Hand, Field, Grave)
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e2:SetValue(CARD_SHINING_SARCOPHAGUS)
    c:RegisterEffect(e2)
	--Gains 300 ATK for each monster in the GYs that mentions "Shining Sarcophagus"
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(s.atkval)
	c:RegisterEffect(e4)
end
s.listed_names={CARD_DARK_MAGICIAN_GIRL,CARD_SHINING_SARCOPHAGUS}

function s.atkfilter(c)
	return c:ListsCode(CARD_SHINING_SARCOPHAGUS) and c:IsMonster()
end
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(s.atkfilter,0,LOCATION_GRAVE,LOCATION_GRAVE,nil)*300
end
