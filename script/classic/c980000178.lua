--P.U.N.K. JAM FEVER!
--Scripted by Hatter
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon procedure: 2 Level 8 monsters, or 1 "P.U.N.K." Fusion or Synchro Monster
	Xyz.AddProcedure(c,nil,8,2,s.ovfilter,aux.Stringid(id,0),2,s.xyzop)
	--Draw 1 card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCost(Cost.AND(Cost.PayLP(600),Cost.DetachFromSelf(1)))
	e1:SetTarget(s.drtg)
	e1:SetOperation(s.drop)
	c:RegisterEffect(e1)
end
s.listed_names={id}
s.listed_series={SET_PUNK}
function s.ovfilter(c,tp,xyzc)
	return c:IsFaceup() and c:IsSetCard(SET_PUNK,xyzc,SUMMON_TYPE_XYZ,tp)
		and (c:IsType(TYPE_FUSION,xyzc,SUMMON_TYPE_XYZ,tp) or c:IsType(TYPE_SYNCHRO,xyzc,SUMMON_TYPE_XYZ,tp))
end
function s.xyzop(e,tp,chk)
	if chk==0 then return not Duel.HasFlagEffect(tp,id) end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE|PHASE_END,EFFECT_FLAG_OATH,1)
	return true
end
function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.drop(e,tp,eg,ep,ev,re,r,rp,chk)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end