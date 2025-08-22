--Prayer to the Evil Spirits
Duel.LoadScript("c420.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff(c,nil,Fusion.InHandMat,s.fextra,nil,nil,nil,2)
	c:RegisterEffect(e1)
end
s.listed_series={0xef,0x154a}
function s.matfilter(c)
	return c:IsSetCard({0xef,0x154a,SET_CYBER_ANGEL}) or c:IsCode(8797586) or c:IsCode(68007326) or c:IsCode(49674183)
            or c:IsCode(96470883) or c:IsCode(94381039) or c:IsCode(28593329) or c:IsCode(89055154)
            or c:IsCode(85399281) or c:IsCode(12332865) or c:IsCode(79928401) or c:IsCode(95956346)
            or c:IsCode(68860936) or c:IsCode(37405032) or c:IsCode(19280589) or c:IsCode(45215225)
            or c:IsCode(76103404) or c:IsCode(28053106) or c:IsCode(12500059) or c:IsCode(82243738)
            or c:IsCode(50139096) or c:IsCode(42216237) or c:IsCode(53334641) or c:IsCode(32448765)
            or c:IsCode(58699500) or c:IsCode(30691817) or c:IsCode(160022035)
end
function s.checkextra(tp,sg,fc)
	return sg:FilterCount(Card.IsLocation,nil,LOCATION_HAND)==1 and sg:FilterCount(Card.IsLocation, nil, LOCATION_GRAVE)==1
end
function s.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(s.matfilter,tp,LOCATION_HAND|LOCATION_GRAVE,0,nil),s.checkextra
end