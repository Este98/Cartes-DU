--Vahram, the Magistus Divinity Dragon
--Scripted by Naim
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon procedure
	Synchro.AddProcedure(c,nil,1,1,Synchro.NonTuner(nil),1,99)
	--Prevent destruction by opponent's Spell/Trap
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetValue(s.indesvalue)
	c:RegisterEffect(e1)
end
s.listed_series={SET_MAGISTUS}
function s.indesvalue(e,re,rp)
	return re:IsSpellTrapEffect() and rp==1-e:GetHandlerPlayer()
end