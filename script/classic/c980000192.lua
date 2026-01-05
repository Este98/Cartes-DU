--Visas Samsara
--scripted by Naim
local s,id=GetID()
function s.initial_effect(c)
	--This card's name becomes "Visas Starfrost"
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE|LOCATION_GRAVE)
	e1:SetValue(CARD_VISAS_STARFROST)
	c:RegisterEffect(e1)
	--Can be treated as a non-tuner for a Synchro Summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_NONTUNER)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
end
s.listed_names={CARD_VISAS_STARFROST}
s.listed_series={SET_VISAS}