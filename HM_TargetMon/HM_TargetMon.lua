--
-- �������������BUFF������ CD ���
--

HM_TargetMon = {
	bSkillMon = true,		-- Ŀ�꼼�� CD ���
	bSkillRight = false,		-- ���������Ҷ���
	bTargetBuffEx = true,	-- Ŀ������BUFF
	bTargetRight = false,	-- Ŀ�� BUFF �Ҷ���
	bSelfBuffEx = true,		-- ��������BUFF
	bSelfRight = false,		-- ����BUFF �Ҷ���
	bBoxEvent2 = false,		-- ͼ������¼�
	nSize = 55,					-- BOX ��С
	tSkillList = {},			-- �Զ����ؼ���  	[dwForce] => { [name] => N (s) }
	tBuffList = {},			-- �Զ�����BUFF	[nType] => { [name] => true|false }
	tNSBuffEx = {},			-- �ų�����Լ�
	tNTBuffEx = {},			-- �ų����Ŀ��
	tAnchor = {},				-- λ��
}

-- customdata
HM.RegisterCustomData("HM_TargetMon")

---------------------------------------------------------------------
-- ���غ����ͱ���
---------------------------------------------------------------------
local _HM_TargetMon = {
	tCD = {},
}

-- get skill name by id
local function _s(dwSkillID)
	local szName, _ = HM.GetSkillName(dwSkillID)
	return szName
end

-- get buff name by id
local function _b(dwBuffID, dwLevel)
	local szName, _ = HM.GetBuffName(dwBuffID, dwLevel)
	return szName
end

-- skill list (by force, < 0 disable )
_HM_TargetMon.tSkillList4 = {
	{		-- ����
		[_s(236)--[[Ħڭ����]]] = 25,
		[_s(242)--[[׽Ӱʽ]]] = 20,
		[_s(240)--[[����ʽ]]] = 30,
		[_s(249)--[[���̽Կ�]]] = 14,
		[_s(252)--[[��ʨ�Ӻ�]]] = 25,
		[_s(257)--[[�͹Ǿ�]]] = 35,
		[_s(261)--[[�����]]] = 60,
		[_s(498)--[[ǧ��׹]]] = 25,
	},  {	-- ��
		[_s(182)--[[��ʯ���]]] = 17,
		[_s(100)--[[��¥��Ӱ]]] = 24,
		[_s(132)--[[���໤��]]] = 36,
		[_s(186)--[[ܽ�ز���]]] = 25,
		[_s(183)--[[����ָ]]] = 10,
		[_s(2663)--[[���紵ѩ]]] = 120,
		[_s(136)--[[ˮ���޼�]]] = 60,
		[_s(228)--[[̫��ָ]]] = 25,
		[_s(14963)--[[��Ҷ����]]] = 105,
		[_s(14965)--[[�Ϸ�����]]] = 105,
		[_s(2645)--[[�������]]] = 90,
	}, {	-- ���
		[_s(412)--[[�����]]] = 50,
		[_s(413)--[[����ɽ]]] = 110,
		[_s(482)--[[��]]] = 15,
		[_s(418)--[[ͻ]]] = 20,
		[_s(422)--[[Х�绢]]] = 90,
		[_s(428)--[[�ϻ��]]] = 23,
		[_s(433)--[[�γ۳�]]] = 40,
		[_s(423)--[[��]]] = 19,
		[_s(2628)--[[Ԩ]]] = 45,
		[_s(424)--[[��]]] = 25,
	}, {	-- ����
		[_s(2681)--[[��������]]] = 60,
		[_s(363)--[[������]]] = 10,
		[_s(588)--[[�˽���һ]]] = 14,
		[_s(310)--[[���ɾ���]]] = 20,
		[_s(366)--[[�������]]] = 20,
		[_s(370)--[[���Զ���]]] = 25,
		[_s(372)--[[תǬ��]]] = 120,
		[_s(371)--[[��ɽ��]]] = 240,
		[_s(307)--[[��������]]] = 30,
		[_s(358)--[[��̫��]]] = 10,
		[_s(355)--[[ƾ������]]] = 30,
		[_s(302)--[[�巽�о�]]] = 15,
		[_s(303)--[[���Ż���]]] = 20,
		[_s(305)--[[��ת��һ]]] = 15,
		[_s(2699)--[[�˻Ĺ�Ԫ]]] = 14,
		[_s(346)--[[������]]] = 30,
	},  {	-- ����
		[_s(544)--[[��������]]] = 40,
		[_s(546)--[[��Ӱ����]]] = 15,
		[_s(547)--[[����ͨ��]]] = 30,
		[_s(550)--[[ȵ̤֦]]] = 45,
		[_s(574)--[[��Ū��]]] = 75,
		[_s(557)--[[��صͰ�]]] = 45,
		[_s(552)--[[������]]] = 480,
		[_s(569)--[[��ĸ����]]] = 15,
		[_s(555)--[[����Ͱ�]]] = 40,
		[_s(558)--[[������ŭ]]] = 90,
		[_s(568)--[[��������]]] = 120,
	},  {	-- �嶾
		[_s(2212)--[[����]]] = 12,
		[_s(2218)--[[�ù�]]] = 60,
		[_s(2228)--[[����]]] = 30,
		[_s(2226)--[[�Ƴ��׼�]]] = 27,
		[_s(2230)--[[Ů洲���]]] = 54,
		[_s(2227)--[[�Ƴ��]]] = 120,
		[_s(2957)--[[ʥ��֯��]]] = 18,
		[_s(2235)--[[ǧ������]]] = 60,
		[_L["Call pet"]] = 30,
	},  {	-- ����
		[_s(3099)--[[жԪ��]]] = 10,
		[_s(3115)--[[���켬��]]] = 45,
		[_s(3114)--[[��������]]] = 60,
		[_s(3090)--[[����]]] = 20,
		[_s(3089)--[[������]]] = 25,
		[_s(3094)--[[��������]]] = 120,
		[_s(3112)--[[������Ӱ]]] = 90,
		[_s(3103)--[[���Ƕ�Ӱ]]] = 45,
		[_s(3101)--[[���Ǽ�]]] = 10,
		[_s(3118)--[[����̿�]]] = 30,
		[_s(15131)--[[��������]]] = 70,
		[_s(15070)--[[ת������]]] = 25,
	},  {	-- �ؽ�
		[_s(1610)--[[ϼ����ʯ]]] = 10,
		[_s(1577)--[[������]]] = 15,
		[_s(1656)--[[Х��]]] = 10.5,
		[_s(1647)--[[����]]] = 12,
		[_s(1649)--[[����]]] = 14,
		[_s(1589)--[[��Ȫ����]]] = 28,
		[_s(1596)--[[�׹��ɽ]]] = 16,
		[_s(1613)--[[����ƾ�]]] = 15,
		[_s(1668)--[[������]]] = 100,
		[_s(1666)--[[Ȫ����]]] = 40,
		[_s(1580)--[[��Ȫ��Ծ]]] = 30,
		[_s(1655)--[[̽÷]]] = 20,
		[_s(1665)--[[�紵��]]] = 20,
		[_s(1909)--[[ժ��]]] = 20,
	},  {	-- ؤ��
		-- [_s(5265)--[[��������]]] = 23,
		[_s(5262)--[[��Ծ��Ԩ]]] = 8,
		[_s(5257)--[[��Ȯ����]]] = 45,
		[_s(5259)--[[����ͷ]]] = 20,
		[_s(5267)--[[��Х����]]] = 36,
		[_s(5269)--[[������]]] = 40,
		[_s(5270)--[[Ц����]]] = 90,
		-- [_s(5272)--[[����ң]]] = 60,
	},  {	-- ����
		[_s(3977)--[[������Ӱ]]] = 20,
		[_s(3975)--[[��η����]]] = 28,
		[_s(3973)--[[̰ħ��]]] = 45,
		[_s(3974)--[[������ɢ]]] = 45,
		[_s(3978)--[[�������]]] = 120,
		[_s(4910)--[[��������]]] = 25,
		[_s(3969)--[[������]]] = 90,
		[_s(3968)--[[���ⷨ]]] = 60,
		[_s(3971)--[[������]]] = 45,
		[_s(3970)--[[�ùⲽ]]] = 30,
	},
	-- ����
	[0] = {
		[_s(9003)--[[��������]]] = 30,
		[_s(9002)--[[��ҡֱ��]]] = 30,
	},
	-- ����
	[21] = {
		[_s(13046)--[[����]]] = 15,
		-- [_s(13050)--[[�ܷ�]]] = 18,
		[_s(13068)--[[����]]] = 45,
		[_s(13049)--[[��ǽ]]] = 20,
		[_s(13424)--[[����]]] = 20,
		[_s(13070)--[[�ܱ�]]] = 90,
		[_s(13042)--[[�޾�]]] = 30,
		[_s(13067)--[[����]]] = 35,
		[_s(13054)--[[ն��]]] = 12,
		[_s(13040)--[[Ѫŭ]]] = 25,
	},
	-- ����
	[22] = {
		[_s(14073)--[[Ц������]]] = 80,
		[_s(14074)--[[��������]]] = 60,
		[_s(14076)--[[��������]]] = 35,
		[_s(14081)--[[��Ӱ��˫]]] = 180,
		[_s(14082)--[[��Ӱ��б]]] = 20,
		[_s(14083)--[[���Ӱ��]]] = 160,
		[_s(14093)--[[����ڤ]]] = 15,
		[_s(14095)--[[������Х]]] = 20,
		[_s(15068)--[[��������]]] = 90,
	},
}

-- add new force
for k, v in pairs(g_tStrings.tForceTitle) do
	if k > 10 and not _HM_TargetMon.tSkillList4[k] then
		_HM_TargetMon.tSkillList4[k] = {}
	end
end

-- ���ܼ���
_HM_TargetMon.tChongNeng = {
	[_s(418)--[[ͻ]]] = 2,
	[_s(13067)--[[����]]] = 3,
	[_s(13040)--[[Ѫŭ]]] = 3,
	[_s(15070)--[[ת������]]] = 3,
	[_s(14082)--[[��Ӱ��б]]] = 3,
	[_s(14074)--[[��������]]] = 2,
	[_s(2681)--[[��������]]] = 3, -- ��������3�γ���
	[_s(242)--[[׽Ӱʽ]]] = 2,
}

--buff list (by type)
_HM_TargetMon.tBuffList4 = {
	{
		szType = _L["Invincible"],	-- 1
		tName = {
			_b(377)--[[��ɽ��]], _b(961)--[[̫��]], _b(772)--[[����]], _b(3425)--[[������]], _b(360)--[[��]],
			_b(6182)--[[ڤ��]], _b(9934)--[[�Ϸ�����]],
		},
	}, {
		szType = _L["Silence"],	-- 2
		tName = {
			_b(726)--[[���ɾ���]], _b(692)--[[��Ĭ]], _b(712)--[[��������]],	-- ��������2��712
			_b(4053)--[[��η����]], _b(8450)--[[����]], _b(9378)--[[����]],
			_b(10283)--[[����]],
		},
	}, {
		szType = _L["Uncontrollable"],	--3
		tName = {
			_b(411)--[[��¥��Ӱ]], _b(1186)--[[�۹�]], _b(2847)--[[����]], _b(855)--[[����]],
			_b(2756)--[[������]], _b(2781)--[[תǬ��]], _b(3279)--[[����֮��]], _b(1856)--[[����]], _b(1676)--[[��Ȫ��Ծ]], -- תǬ��2��2781
			_b(1686)--[[��Ȫ����]], _b(2840)--[[�Ƴ��]], _b(2544)--[[�����׼�]], _b(3822)--[[�̵��׼�]], _b(4245)--[[ʥ��]],
			_b(4421)--[[���]], _b(4468)--[[��Ȼ]], _b(6373)--[[��Ԩ]], _b(6361)--[[�ɽ�]], _b(6314)--[[����]], _b(6292)--[[������]],
			_b(6247)--[[���Ĺ�]], _b(6192)--[[������]], _b(6131)--[[����]], _b(5995)--[[Ц����]], _b(6459)--[[������]],
			_b(6015)--[[��Ծ��Ԩ]], _b(6369)--[[������]], _b(6087)--[[�������]], _b(5754)--[[����]], _b(5950)--[[�Ƴ��׼�]],
			_b(3275)--[[������Ⱥ]], _b(8247)--[[�޾�]], _b(8265)--[[��ǽ]], _b(8293)--[[ǧ��]], _b(8458)--[[ˮ���޼�]],
			_b(8449)--[[�ٻ�]], _b(8483)--[[����]], _b(8716)--[[����]], _b(9059)--[[���]], _b(9068)--[[����]], _b(9999)--[[����]],
			_b(6284)--[[ʥ������]], _b(677)--[[ȵ̤֦]], _b(9855)--[[����]], _b(9342)--[[ʯ����]], _b(9294)--[[��Ӱ]],
			_b(9848)--[[̽÷]], _b(10245)--[[����Χ]],
		},
	}, {
		szType = _L["Halt"],	-- 4
		tName = {
			_b(415)--[[ѣ��]], _b(533)--[[��ä]], _b(567)--[[���̽Կ�]], _b(572)--[[��ʨ�Ӻ�]], _b(682)--[[������ŭ]],
			_b(548)--[[ͻ]], _b(2275)--[[�ϻ��]], _b(740)--[[��ע]], _b(1721)--[[����]], _b(1904)--[[�׹��ɽ]], _b(1927)--[[����]],
			_b(2489)--[[Ы������]], _b(2780)--[[��������]], _b(3223)--[[������]], _b(3224)--[[����]], _b(727)--[[��]],
			_b(1938)--[[����ƾ�]], _b(4029)--[[�ս�]], _b(4871)--[[��������]], _b(4875)--[[��ħ]], _b(6276)--[[�ùⲽ]],
			_b(6128)--[[����]], _b(6107)--[[���]], _b(5876)--[[�ƻ�]], _b(6365)--[[������ħ��]], _b(6380)--[[����ң]],
			_b(2755)--[[����]], _b(1902)--[[Σ¥]], _b(2877)--[[��Ӱ]], _b(4438)--[[��ҹ����]],
			_b(8329)--[[����]], _b(8455)--[[����]], _b(8570)--[[����]],
		},
	}, {
		szType = _L["Entrap"],	-- 5
		tName = {
			_b(1937)--[[���Ż���]], _b(679)--[[Ӱ��]], _b(706)--[[ֹˮ]], _b(4038)--[[����]], _b(2289)--[[�巽�о�]],
			_b(2492)--[[��������]], _b(2547)--[[�����׼�]], _b(1931)--[[�¹�����]], _b(6364)--[[��]], _b(4758)--[[����]],
			_b(5809)--[[̫��]], _b(5764)--[[����]], _b(5694)--[[̫��ָ]], _b(5793)--[[���]], _b(4436)--[[��ҹ����]],
			_b(3359)--[[��צ]], _b(8251)--[[����]], _b(8327)--[[�Ͻ�]], _b(3216)--[[���Ĵ̹�]], _b(9569)--[[������]],
			_b(9730)--[[����ع��]], _b(10282)--[[����]],
		},
	}, {
		szType = _L["Freeze"],	-- 6
		tName = {
			-- ����������ܸ�Ϊ��6082
			-- _b(998)--[[̫��ָ]],
			_b(678)--[[��������]], _b(686)--[[��������]], _b(554)--[[�������]], _b(556)--[[���ǹ���]], _b(675)--[[ܽ�ز���]],
			_b(737)--[[���]], _b(1229)--[[����]], _b(1247)--[[ͬ��]], _b(4451)--[[����]], _b(1857)--[[����]],
			_b(1936)--[[筴�����]], _b(2555)--[[˿ǣ]], _b(6317)--[[����]], _b(6108)--[[�������]], _b(6091)--[[��Ӱ]],
			_b(2311)--[[�ù�]], _b(4437)--[[��ҹ����]],
		},
	}, {
		szType = _L["Breakout"],	-- 7
		tName = {
			_b(200)--[[�����]], _b(2719)--[[���]], _b(2757)--[[��������]], _b(538)--[[��������]], _b(1378)--[[��ˮ]],
			_b(3468)--[[��������]], _b(3859)--[[����Ӱ]], _b(2726)--[[����]], _b(5994)--[[������]], _b(2779)--[[Ԩ]],
			_b(1728)--[[ݺ��]], _b(3316)--[[����]], _b(2543)--[[�����׼�]], _b(9906)--[[��ľ����]],
		},
	}, {
		szType = _L["Reduce-injury"],	-- 8
		tName = {
			-- ��������Ѹ�Ϊ��6264 �ˣ���û������Ӱ��
			_b(367)--[[����ɽ]], _b(384)--[[תǬ��]], _b(399)--[[�����]], _b(122)--[[���໤��]], _b(3068)--[[����]],
			_b(1802)--[[����]], _b(684)--[[��صͰ�]], _b(4439)--[[̰ħ��]], _b(6315)--[[����]], _b(2077)--[[����]],
			_b(6240)--[[��ˮ��]], _b(5996)--[[Ц����]], _b(5810)--[[�Ի�]], _b(6200)--[[��Х����]], _b(6636)--[[ʥ��֯��]],
			_b(6262)--[[����]], _b(2849)--[[��Ϸˮ]], _b(3315)--[[����]], _b(8279)--[[�ܱ�]], _b(8300)--[[��ǽ]],
			_b(8427)--[[�ٻ�]], _b(8291)--[[�ܻ�]], _b(8495)--[[����]], _b(2983)--[[����]], _b(10014)--[[����]],
			_b(10051)--[[��ˮ��Ӱ]], _b(10107)--[[��˷�]], _b(9334)--[[÷����Ū]],
		},
	}, {
		szType = _L["Dodge"],	-- 9
		tName = {
			_b(3214)--[[��������]], _b(2065)--[[������]], _b(5668)--[[�紵��]], _b(6434)--[[����ң]],
			_b(6299)--[[�������]], _b(6174)--[[����]],
		},
	}, {
		szType = _L["Uncontrollable2"],	-- 10
		tName = {
			_b(374)--[[��̫��]], _b(1903)--[[Х��]],
		},	-- ��̫��2��374
	}, {
		szType = _L["Reduce-heal"],	-- 11
		tName = {
			_b(2774)--[[����]], _b(3195)--[[������]], _b(3538)--[[����]], _b(574)--[[����]], _b(576)--[[��ӽ�ɳ]],
			_b(2496)--[[����ݲ�]], _b(2502)--[[Ы��]], _b(4030)--[[�½�]], _b(6155)--[[��������]], _b(8487)--[[�ܻ�]],
			_b(9514)--[[����]],
		},
	}, {
		szType = _L["Slower"],	-- 12
		tName = {
			-- ������ؿ��ܸ�Ϊ��6072
			-- _b(733)--[[̫��]],
			_b(4928)--[[����]], _b(549)--[[��]], _b(450)--[[��һ]], _b(523)--[[����]], _b(2274)--[[����]], _b(560)--[[��̫��]],
			_b(563)--[[����ʽ]], _b(584)--[[����ָ]], _b(1553)--[[�������]], _b(1720)--[[����]],
			_b(2297)--[[ǧ˿]], _b(3484)--[[����]], _b(3226)--[[����޼]], _b(4054)--[[ҵ���︿]], _b(6275)--[[���賤��]],
			_b(6259)--[[ѩ����]], _b(6191)--[[ҵ��]], _b(6162)--[[ɽ��]], _b(6130)--[[���]], _b(6078)--[[�����滨��]],
			_b(3466)--[[���]], _b(4435)--[[��ҹ����]], _b(8299)--[[��ǽ]], _b(8398)--[[����]], _b(8492)--[[����]],
			_b(9170)--[[����]], _b(10001)--[[����]], _b(9507)--[[������]], _b(9217)--[[������]],
		},
	}, {
		szType = _L["Others"],	-- 13
		tName = {
			_b(678)--[[��������]], _b(3929)--[[����]], _b(198)--[[������]], _b(203)--[[Х�绢]],
			_b(3858)--[[��Ȥ]], _b(994)--[[����]], _b(3399)--[[����]], _b(3276)--[[׷������]], _b(4028)--[[ʥ����]],
			_b(6354)--[[���]], _b(6346)--[[����޺�]], _b(6350)--[[�ٷ�]], _b(6266)--[[����Ѫ]], _b(6224)--[[����]],
			_b(6172)--[[ӥĿ]], _b(6143)--[[Ȫ����]], _b(6121)--[[�绢]], _b(6122)--[[����]], _b(6425)--[[��ظ�]],
			_b(6085)--[[Ӱ��]], _b(5970)--[[����]], _b(5875)--[[�ƻ�]], _b(5789)--[[��������]], _b(5666)--[[���⽭ɽ]],
			_b(999)--[[�꼯]], _b(6074)--[[����·]], _b(376)--[[������]], _b(4937)--[[�������]], _b(4937,2)--[[����ͬ��]],
			_b(2315)--[[Ů洲���]], _b(2795)--[[�޺�����]], _b(2778)--[[Ԩ]], _b(3215)--[[���켬��]], _b(8438)--[[����]],
			_b(6256)--[[����]], _b(2542)--[[����׼�]],  _b(2920)--[[����]], _b(748)--[[����]], _b(6223)--[[���]],
			_b(8451)--[[���]], _b(8391)--[[�ܷ�]], _b(126)--[[����]], _b(8378)--[[����]], _b(9175)--[[Ϣ��]],
			_b(9909)--[[�������]], _b(10015)--[[���]], _b(10121)--[[ӳ��]], _b(9962)--[[ƽ��]], _b(9263)--[[��������]],
			_b(4462)--[[��Ȼ����]], _b(9271)--[[ޒ��]], _b(9277)--[[ޒ��]], _b(8491)--[[�Ÿ�]], _b(10212)--[[���ɳ��]],
			_b(9395)--[[������]], _b(10278)--[[��δ��]],
		},
	}, {
		szType = _L["Silence2"],	-- 14
		tName = {
			_b(445)--[[����ʽ]], _b(690)--[[����ͨ��]], _b(2182)--[[���Զ���]], _b(2838)--[[�������]],
			_b(3227)--[[÷����]], _b(2807)--[[����]], _b(2490)--[[�Х����]], _b(585)--[[����ָ]],
			_b(9214)--[[������Х]],
		},
	}, {
		szType = _L["Orange-weapon"],	-- 15
		tName = {
			_b(1914)--[[����]], _b(1921)--[[���]], _b(6471)--[[ǧҶ����]],
			-- _b(1918)--[[...]],
			_b(1911,1)--[[���]], _b(1911,2)--[[�ٺ�]], _b(1911,3)--[[������Ȫ]], _b(1911,4)--[[�����ŵ�]],
			_b(1912,1)--[[�ݳ�]], _b(1912,2)--[[����]], _b(1912,3)--[[����]], _b(1912,4)--[[�̺�]],
			_b(1913,1)--[[����]], _b(1913,2)--[[�Ϲ�]], _b(1913,3)--[[���]], _b(1913,4)--[[ī��]],
			_b(1915,1)--[[����]], _b(1915,2)--[[��Ӱ]], _b(1915,3)--[[ѩ��]], _b(1915,4)--[[������λ]],
			_b(1916,1)--[[��������]], _b(1916,2)--[[����]], _b(1916,3)--[[��������]], _b(1916,4)--[[Ԩ΢ָ��]],
			_b(1917,1)--[[���¡��һ�]], _b(1917,2)--[[��������]], _b(1917,3)--[[�ɽ���Īа]], _b(1917,4)--[[��������Ӱ]],
			_b(1919,1)--[[��ľ����]], _b(1919,2)--[[�׹�����]], _b(1919,3)--[[ȼľ]], _b(1919,4)--[[���ġ���]],
			_b(1920,1)--[[���·���]], _b(1920,2)--[[����]], _b(1920,3)--[[���Ĺ۷�]], _b(1920,4)--[[������Ե]],
			_b(1922,1)--[[֯�׶ϳ�]], _b(1922,2)--[[����]], _b(1922,3)--[[̫��]], _b(1922,4)--[[��ˮ]],
			_b(3028,1)--[[ԡ��]], _b(3028,2)--[[��ڤ]], _b(3028,3)--[[̫������]], _b(3028,4)--[[�����]],
			_b(3487,1)--[[��Ԩ����]], _b(3487,2)--[[�����]], _b(3487,3)--[[��β���]], _b(3487,4)--[[��������]],
			_b(3488,1)--[[��ȸ��]], _b(3488,2)--[[��ɳ��Ӱ]], _b(3488,3)--[[��ɽ��]], _b(3488,4)--[[�컯���]],
			_b(4930,1)--[[���]], _b(4930,2)--[[��ħ����]], _b(4930,3)--[[��������]], _b(4930,4)--[[���¾���]],
			_b(4931,1)--[[����]], _b(4931,2)--[[������Ӱ]], _b(4931,3)--[[������]], _b(4931,4)--[[ִ��]],
			_b(6466,1)--[[����Ǭ��]], _b(6466,2)--[[˪����]], _b(6466,3)--[[����а��]], _b(6646,4)--[[�ķ糰��]],
			_b(8474,1)--[[Ѫ��]], _b(8474,2)--[[̫�����]], _b(8474,3)--[[����]], _b(8474,4)--[[������]],
			_b(8474,5)--[[ǧ��]], _b(8474,6)--[[����]], _b(8474,7)--[[������ȸ]], _b(8474,8)--[[���޹���]],
			_b(10192,1)--[[������]], _b(10192,4)--[[������]], _b(10193,1)--[[ӯȱ]], _b(10193,4)--[[�ļ���]],
		},
	}, {
		szType = _L["BanSprint"],	-- 16
		tName = {
			_b(562,1)--[[������]], _b(562,4)--[[ǧ˿����]], _b(562,5)--[[�Ի�]], _b(562,7)--[[����]], _b(562,8)--[[��Ӱ]], _b(562,9)--[[����]],
			_b(1939)--[[�ƾ�]], _b(6074)--[[����·]], _b(4497)--[[����]], _b(535)--[[�벽��]], _b(8257)--[[����]],
			_b(10246)--[[��Χ]],
		},
	}
}

-- reset cd
_HM_TargetMon.tSkillReset = {
	[_s(552)--[[������]]] = { _s(557)--[[��صͰ�]], _s(550)--[[ȵ̤֦]], _s(574)--[[��Ū��]], _s(548)--[[������]] },
	[_s(425)--[[����ͻ]]] = { _s(428)--[[�ϻ��]], _s(433)--[[�γ۳�]], _s(426)--[[�Ƽ���]], _s(479)--[[�Ѳ��]] },
	--[_s(346)--[[������]]] = { _s(9003)--[[��������]] },
	--[_s(2645)--[[�������]]] = { _s(182)--[[��ʯ���]] },
	[_s(372)--[[תǬ��]]] = { _s(358)--[[��̫��]], _s(361)--[[��̫��]], _s(357)--[[������]], _s(363)--[[������]] },
	[_s(1651)--[[�ϳ�]]] = { _s(1593)--[[�Ʒ����]] },
	[_s(3978)--[[�������]]] = { _s(3974)--[[������ɢ]], _s(3975)--[[��η����]], _s(4910)--[[��������]], _s(3977)--[[������Ӱ]], _s(3976)--[[ҵ���︿]], _s(3979)--[[��ҹ�ϳ�]] },
	--[_s(153)--[[����������]]] = { _s(413)--[[����ɽ]], _s(313)--[[躹�����]], _s(1645)--[[������ɽ]], _s(3114)--[[��������]] },
	--[_s(1959)--[[����������]]] = { _s(131)--[[��ˮ����]], _s(555)--[[����Ͱ�]], _s(2235)--[[ǧ������]] },
	--[_s(167)--[[����������]]] = { _s(371)--[[��ɽ��]], _s(573)--[[������]], _s(136)--[[ˮ���޼�]], _s(257)--[[�͹Ǿ�]], _s(3094)--[[��������]], _L["Call pet"], _s(3969)--[[������]] },
}

-- special repeat-name buff
_HM_TargetMon.tFixedBuffEx = {
	[_L("Invincible_%s", _b(6182)--[[ڤ��]])] = 6182,
	[_L("Silence_%s", _b(712)--[[��������]])] = 712,
	[_L("Halt_%s", _b(2780)--[[��������]])] = 2780,
	[_L("Halt_%s", _b(5876)--[[�ƻ�]])] = 5876,
	[_L("Halt_%s", _b(8455)--[[����]])] = 8455,
	[_L("Entrap_%s", _b(1931)--[[�¹�����]])] = 1931,
	[_L("Entrap_%s", _b(5809)--[[̫��]])] = 5809,
	[_L("Entrap_%s", _b(5764)--[[����]])] = 5764,
	[_L("Entrap_%s", _b(5793)--[[���]])] = 5793,
	[_L("Entrap_%s", _b(8327)--[[�Ͻ�]])] = 8327,
	[_L("Entrap_%s", _b(9730)--[[����ع��]])] = 9730,
	[_L("Entrap_%s", _b(8251)--[[����]])] = 8251,
	[_L("Slower_%s", _b(4758)--[[����]])] = 4758,
	[_L("Freeze_%s", _b(685)--[[��������]])] = 685,
	[_L("Freeze_%s", _b(1936)--[[筴�����]])] = 1936,
	[_L("Freeze_%s", _b(2113)--[[Ȫ����]])] = 2113,
	[_L("Freeze_%s", _b(6108)--[[�������]])] = 6108,
	[_L("Uncontrollable2_%s", _b(374)--[[��̫��]])] = 374,
	[_L("Uncontrollable_%s", _b(730)--[[�縮]])] = 730,
	[_L("Uncontrollable_%s", _b(2781)--[[תǬ��]])] = 2781,
	[_L("Uncontrollable_%s", _b(6314)--[[����]])] = 6314,
	[_L("Uncontrollable_%s", _b(6292)--[[������]])] = 6292,
	[_L("Uncontrollable_%s", _b(6247)--[[���Ĺ�]])] = 6247,
	[_L("Uncontrollable_%s", _b(5995)--[[Ц����]])] = 5995,
	[_L("Uncontrollable_%s", _b(6369)--[[������]])] = 6369,
	[_L("Uncontrollable_%s", _b(6015)--[[��Ծ��Ԩ]])] = 6015,
	[_L("Uncontrollable_%s", _b(5754)--[[����]])] = 5754,
	[_L("Uncontrollable_%s", _b(5950)--[[�Ƴ��׼�]])] = 5950,
	[_L("Uncontrollable_%s", _b(8265)--[[��ǽ]])] = 8265,
	[_L("Uncontrollable_%s", _b(8449)--[[�ٻ�]])] = 8449,
	[_L("Uncontrollable_%s", _b(8458)--[[ˮ���޼�]])] = 8458,
	[_L("Uncontrollable_%s", _b(8483)--[[����]])] = 8483,
	[_L("Uncontrollable_%s", _b(8716)--[[����]])] = 8716,
	[_L("Uncontrollable_%s", _b(9294)--[[��Ӱ]])] = 9294,
	[_L("Uncontrollable_%s", _b(9848)--[[̽÷]])] = 9848,
	[_L("Uncontrollable_%s", _b(9068)--[[����]])] = 9068,
	[_L("Uncontrollable_%s", _b(6192)--[[������]])] = 6192,
	[_L("Breakout_%s", _b(5994)--[[������]])] = 5994,
	[_L("Breakout_%s", _b(2779)--[[Ԩ]])] = 2779,
	[_L("Slower_%s", _b(560)--[[��̫��]])] = 560,
	[_L("Slower_%s", _b(733)--[[̫��]])] = 733,
	[_L("Slower_%s", _b(3484)--[[����]])] = 3484,
	[_L("Slower_%s", _b(6162)--[[ɽ��]])] = 6162,
	[_L("Slower_%s", _b(6078)--[[�����滨��]])] = 6078,
	[_L("Slower_%s", _b(8299)--[[��ǽ]])] = 8299,
	[_L("Slower_%s", _b(9170)--[[����]])] = 9170,
	[_L("Slower_%s", _b(9217)--[[������]])] = 9217,
	[_L("Halt_%s", _b(548)--[[ͻ]])] = 548,
	[_L("Halt_%s", _b(8329)--[[����]])] = 8329,
	[_L("Dodge_%s", _b(5668)--[[�紵��]])] = 5668,
	[_L("Dodge_%s", _b(6174)--[[����]])] = 6174,
	[_L("Dodge_%s", _b(6299)--[[�������]])] = 6299,
	[_L("Reduce-dealing_%s", _b(3195)--[[������]])] = 3195,
	[_L("Reduce-injury_%s", _b(384)--[[תǬ��]])] = 384,
	[_L("Reduce-injury_%s", _b(4439)--[[̰ħ��]])] = 4439,
	[_L("Reduce-injury_%s", _b(6315)--[[����]])] = 6315,
	[_L("Reduce-injury_%s", _b(6240)--[[��ˮ��]])] = 6240,
	[_L("Reduce-injury_%s", _b(5996)--[[Ц����]])] = 5996,
	[_L("Reduce-injury_%s", _b(5810)--[[�Ի�]])] = 5810,
	[_L("Reduce-injury_%s", _b(8279)--[[�ܱ�]])] = 8279,
	[_L("Reduce-injury_%s", _b(8300)--[[��ǽ]])] = 8300,	-- or 8650
	[_L("Reduce-injury_%s", _b(8495)--[[����]])] = 8495,
	[_L("Reduce-injury_%s", _b(10051)--[[��ˮ��Ӱ]])] = 10051,
	[_L("Reduce-injury_%s", _b(9334)--[[÷����Ū]])] = 9334,
	[_L("Reduce-injury_%s", _b(1802)--[[����]])] = 1802,
	[_L("BanSprint_%s", _b(562, 1)--[[������]])] = 562,
	[_L("BanSprint_%s", _b(562, 9)--[[����]])] = 562,
	[_L("BanSprint_%s", _b(6074)--[[����·]])] = 6074,
	[_L("BanSprint_%s", _b(8257)--[[����]])] = 8257,
	[_L("Others_%s", _b(6354)--[[���]])] = 6354,
	[_L("Others_%s", _b(6266)--[[����Ѫ]])] = 6266,
	[_L("Others_%s", _b(5970)--[[����]])] = 5970,
	[_L("Others_%s", _b(5875)--[[�ƻ�]])] = 5875,
	[_L("Others_%s", _b(5789)--[[��������]])] = 5789,
	[_L("Others_%s", _b(6425)--[[��ظ�]])] = 6425,
	[_L("Others_%s", _b(2778)--[[Ԩ]])] = 2778,
	[_L("Others_%s", _b(6256)--[[����]])] = 6256,
	[_L("Others_%s", _b(9395)--[[������]])] = 9395,
}

-- special skill alias
_HM_TargetMon.tFixedSkill = {
	[_s(2965)--[[�̵���]]] = _L["Call pet"],
	[_s(2221)--[[ʥЫ��]]] = _L["Call pet"],
	[_s(2222)--[[�����]]] = _L["Call pet"],
	[_s(2223)--[[������]]] = _L["Call pet"],
	[_s(2224)--[[������]]] = _L["Call pet"],
	[_s(2225)--[[������]]] = _L["Call pet"],
}

-- load buffex cache
_HM_TargetMon.LoadBuffEx = function()
	local aCache = {}
	local aType = {}
	for k, v in ipairs(_HM_TargetMon.tBuffList4) do
		aType[k] = v.szType
		for _, vv in ipairs(v.tName) do
			local kkk = _HM_TargetMon.tFixedBuffEx[v.szType .. "_" .. vv] or vv
			aCache[kkk] = { v.szType, k }
			if kkk == 8300 then
				aCache[8650] = { v.szType, k }
			end
		end
	end
	-- override by customdata
	for k, v in pairs(HM_TargetMon.tBuffList) do
		for kk, vv in pairs(v) do
			local szType = aType[k]
			local kkk = _HM_TargetMon.tFixedBuffEx[szType .. "_" .. kk] or kk
			if vv == true then
				aCache[kkk] = { szType, k }
			else
				aCache[kkk] = nil
			end
		end
	end
	_HM_TargetMon.tBuffCache = aCache
end

-- load  monskill cache
_HM_TargetMon.LoadSkillMon = function()
	local aCache = {}
	for _, v in pairs(_HM_TargetMon.tSkillList4) do
		for kk, vv in pairs(v) do
			aCache[kk] = vv
		end
	end
	-- override by customdata
	for _, v in pairs(HM_TargetMon.tSkillList) do
		for kk, vv in pairs(v) do
			if vv > 0 then
				aCache[kk] = vv
			else
				aCache[kk] = nil
			end
		end
	end
	_HM_TargetMon.tSkillCache = aCache
end

-- get buffex type, type index
_HM_TargetMon.GetBuffExType = function(dwBuffID, dwLevel, tNo)
	if not _HM_TargetMon.tBuffCache then
		_HM_TargetMon.LoadBuffEx()
	end
	if not tNo or not tNo[dwBuffID] then
		local rec = _HM_TargetMon.tBuffCache[dwBuffID]
		if not rec and type(dwBuffID) == "number" then
			local szName = HM.GetBuffName(dwBuffID, dwLevel)
			if szName and szName ~= "" and (not tNo or not tNo[szName]) then
				rec = _HM_TargetMon.tBuffCache[szName]
			end
		end
		if rec then
			return rec[1], rec[2]
		end
	end
end

-- get buffex list
_HM_TargetMon.GetBuffExList = function(aBuff, tNo)
	local mBuff, nFrame = {}, GetLogicFrameCount()
	for _, v in ipairs(aBuff) do
		if v.nEndFrame > nFrame and Table_BuffIsVisible(v.dwID, v.nLevel) then
			local szType, nType = _HM_TargetMon.GetBuffExType(v.dwID, v.nLevel, tNo)
			if szType then
				table.insert(mBuff, { buff = v, szType = szType, nType = nType })
			end
		end
	end
	if #mBuff > 1 then
		table.sort(mBuff, function(a, b) return a.nType < b.nType end)
	end
	return mBuff
end

-- get skillmon cooldown
_HM_TargetMon.GetSkillMonCD = function(szName)
	if not _HM_TargetMon.tSkillCache then
		_HM_TargetMon.LoadSkillMon()
	end
	return _HM_TargetMon.tSkillCache[szName]
end

-- purge: [dwCaster] => { { nEnd, nTotal, dwIconID, szName }, ... }
_HM_TargetMon.PurgeData = function()
	local nExpire , nFrame = 960, GetLogicFrameCount()
	if not _HM_TargetMon.nPurgeFrame then
		_HM_TargetMon.nPurgeFrame = nFrame
	elseif (nFrame - _HM_TargetMon.nPurgeFrame) > nExpire then
		_HM_TargetMon.nPurgeFrame = nFrame
		for k, v in pairs(_HM_TargetMon.tCD) do
			for kk, vv in ipairs(v) do
				if vv.nEnd < nFrame then
					table.remove(v, kk)
				end
			end
			if table.getn(v) == 0 then
				_HM_TargetMon.tCD[k] = nil
			end
		end
	end
end

-- get mon cd for player
_HM_TargetMon.GetPlayerCD = function(dwPlayer)
	local aCD, nFrame = {}, GetLogicFrameCount()
	if _HM_TargetMon.tCD[dwPlayer] then
		aCD = _HM_TargetMon.tCD[dwPlayer]
		for k, v in ipairs(aCD) do
			if v.nEnd < nFrame then
				table.remove(aCD, k)
			end
		end
	end
	return aCD
end

-- get forcetitle
_HM_TargetMon.GetForceTitle = function(nForce)
	if nForce > 0 and g_tStrings.tForceTitle[nForce] then
		return g_tStrings.tForceTitle[nForce]
	end
	return g_tStrings.tForceTitle[0]
end

-- get skill belong force
_HM_TargetMon.GetSkillForce = function(szName)
	local nCount = g_tTable.Skill:GetRowCount()
	for i = 1, nCount do
		local tLine = g_tTable.Skill:GetRow(i)
		if tLine.bShow and tLine.dwIconID ~= 13 and tLine.szName == szName then
			local skill = GetSkill(tLine.dwSkillID, 1)
			if skill then
				local szSchool = Table_GetSkillSchoolName(skill.dwBelongSchool)
				for k, v in pairs(g_tStrings.tForceTitle) do
					if k > 0 and v == szSchool then
						return k
					end
				end
				return 0
			end
		end
	end
end

-- edit skill
_HM_TargetMon.EditSkill = function(nForce, szName)
	local frm = _HM_TargetMon.sFrame
	if not frm then
		-- input
		frm = HM.UI.CreateFrame("HM_TARMON_SKILL", { close = false, w = 381, h = 270 })
		frm:Append("Text", { txt = _L["Skill name"], x = 0, y = 0, font = 27 })
		frm:Append("WndEdit", "Edit_Name", { x = 0, y = 28, limit = 100, w = 290, h = 25 } )
		frm:Append("Text", { txt = _L["Skill CD (unit: sec)"], x = 0, y = 60, font = 27 })
		frm:Append("WndEdit", "Edit_Time", { x = 0, y = 88, limit = 100, w = 290, h = 25 } )
		-- buttons
		frm:Append("WndButton", "Btn_Save", { txt = _L["Save"], x = 45, y = 140 }):Click(function()
			local szName = frm:Fetch("Edit_Name"):Text()
			local nTime = tonumber(frm:Fetch("Edit_Time"):Text())
			if szName == "" then
				HM.Alert(_L["Skill name can not be empty"])
			elseif not nTime then
				HM.Alert(_L["Invalid value of skill CD"])
			else
				local nForce = frm.nForce or _HM_TargetMon.GetSkillForce(szName)
				if not nForce then
					HM.Alert(_L("Invalid skill name [%s]", szName))
				else
					if not HM_TargetMon.tSkillList[nForce] then
						HM_TargetMon.tSkillList[nForce] = {}
					end
					HM_TargetMon.tSkillList[nForce][szName] = nTime
					if not frm.nForce then
						HM.Sysmsg(_L("Added skill CD monitor [%s-%s]", _HM_TargetMon.GetForceTitle(nForce), szName))
					end
					frm:Toggle(false)
					_HM_TargetMon.tSkillCache = nil
				end
			end
		end)
		frm:Append("WndButton", "Btn_Cancel", { txt = _L["Cancel"], x = 145, y = 140 }):Click(function() frm:Toggle(false) end)
		_HM_TargetMon.sFrame = frm
	end
	-- show frm
	frm.nForce = nForce
	if not nForce then
		frm:Title(_L["Add skill CD"])
		frm:Fetch("Edit_Name"):Text(""):Enable(true)
		frm:Fetch("Edit_Time"):Text("")
	else
		local tS = HM_TargetMon.tSkillList[nForce] or {}
		frm:Title(_L["Edit skill CD"])
		frm:Fetch("Edit_Name"):Text(szName):Enable(false)
		frm:Fetch("Edit_Time"):Text(tostring(math.abs(tS[szName] or _HM_TargetMon.tSkillList4[nForce][szName])))
	end
	frm:Toggle(true)
end

-- get skill setting menu
_HM_TargetMon.GetSkillMenu = function()
	local m0 = {
		{ szOption = _L["* New *"], fnAction = _HM_TargetMon.EditSkill },
		{
			szOption = _L["* Reset *"],
			fnAction = function()
				HM_TargetMon.tSkillList = {}
				_HM_TargetMon.tSkillCache = nil
			end
		},
		{ bDevide = true, }
	}
	-- default data
	for k, v in pairs(_HM_TargetMon.tSkillList4) do
		local m1 = { szOption = _HM_TargetMon.GetForceTitle(k) }
		local tS = HM_TargetMon.tSkillList[k] or {}
		local aS = {}
		for kk, vv in pairs(tS) do
			if vv > 0 then
				aS[kk] = vv
			end
		end
		for kk, vv in pairs(v) do
			if not tS[kk] then
				aS[kk] = vv
			end
		end
		if not IsEmpty(aS) then
			for kk, vv in pairs(aS) do
				table.insert(m1, {
					szOption = kk .. " (" .. math.abs(vv) .. ")",
					bCheck = true, bChecked = vv > 0,
					fnAction = function() v[kk] = 0 - vv end,
					{ szOption = _L["Edit"], fnAction = function() _HM_TargetMon.EditSkill(k, kk) end },
					{ szOption = _L["Remove"], fnAction = function()
						if not HM_TargetMon.tSkillList[k] then
							HM_TargetMon.tSkillList[k] = {}
						end
						HM_TargetMon.tSkillList[k][kk] = 0
						_HM_TargetMon.tSkillCache = nil
						HM.Sysmsg(_L("Removed skill CD monitor [%s-%s]", _HM_TargetMon.GetForceTitle(k), kk)) end },
				})
			end
			table.insert(m0, m1)
		end
	end
	return m0
end

-- edit buff
_HM_TargetMon.EditBuff = function()
	local frm = _HM_TargetMon.bFrame
	if not frm then
		-- input
		frm = HM.UI.CreateFrame("HM_TARMON_BUFF", { close = false, w = 381, h = 200 })
		local nX = frm:Append("Text", { txt = _L["Name"], x = 0, y = 20, font = 27 }):Pos_()
		nX = frm:Append("WndEdit", "Edit_Name", { x = nX + 5, y = 20, limit = 100, w = 160, h = 25 } ):Pos_()
		frm:Append("WndComboBox", "Combo_Type", { x = nX + 5, y = 20, w = 80, h = 25 } ):Menu( function()
			local m0 = {}
			for k, v in ipairs(_HM_TargetMon.tBuffList4) do
				table.insert(m0, { szOption = v.szType, fnAction = function()
					frm.nType = k
					frm:Fetch("Combo_Type"):Text(v.szType)
				end})
			end
			return m0
		end)
		-- buttons
		frm:Append("WndButton", "Btn_Save", { txt = _L["Save"], x = 45, y = 80 }):Click(function()
			local szName = frm:Fetch("Edit_Name"):Text()
			if szName == "" then
				HM.Alert(_L["Buff name can not be empty"])
			else
				local bExist = nil
				local tBuff = HM_TargetMon.tBuffList[frm.nType] or {}
				for k, v in pairs(tBuff) do
					if k == szName then
						bExist = v == true
						break
					end
				end
				if bExist == nil then
					local tBuff4 = _HM_TargetMon.tBuffList4[frm.nType]
					if tBuff4 then
						for _, v in ipairs(tBuff4.tName) do
							if v == szName then
								bExist = true
								break
							end
						end
					end
				end
				if bExist then
					return HM.Alert(_L["Buff name already exists"])
				end
				tBuff[szName] = true
				HM_TargetMon.tBuffList[frm.nType] = tBuff
				HM.Sysmsg(_L("Added buff monitor [%s-%s]", frm:Fetch("Combo_Type"):Text(), szName))
				frm:Toggle(false)
				_HM_TargetMon.tBuffCache = nil
			end
		end)
		frm:Append("WndButton", "Btn_Cancel", { txt = _L["Cancel"], x = 145, y = 80 }):Click(function() frm:Toggle(false) end)
		_HM_TargetMon.bFrame = frm
	end
	-- show frm
	frm.nType = table.getn(_HM_TargetMon.tBuffList4)
	frm:Fetch("Edit_Name"):Text("")
	frm:Fetch("Combo_Type"):Text(_HM_TargetMon.tBuffList4[frm.nType].szType)
	frm:Title(_L["Add buff monitor"])
	frm:Toggle(true)
end

-- get buff setting menu
_HM_TargetMon.GetBuffMenu = function()
	local m0 = {
		{ szOption = _L["* New *"], fnAction = _HM_TargetMon.EditBuff },
		{
			szOption = _L["* Reset *"],
			fnAction = function()
				HM_TargetMon.tBuffList = {}
				_HM_TargetMon.tBuffCache = nil
			end
		},
		{ bDevide = true, }
	}
	for k, v in ipairs(_HM_TargetMon.tBuffList4) do
		if not IsEmpty(v.tName) then
			local m1 = { szOption = v.szType }
			local tB = HM_TargetMon.tBuffList[k] or {}
			local aB = {}
			for kk, vv in pairs(tB) do
				if vv == true then
					table.insert(aB, kk)
				end
			end
			for _, vv in ipairs(v.tName) do
				if tB[vv] == nil then
					table.insert(aB, vv)
				end
			end
			for _, vv in ipairs(aB) do
				local vk = _HM_TargetMon.tFixedBuffEx[v.szType .. "_" .. vv] or vv
				table.insert(m1, { szOption = vv,
					{ szOption = _L["Monitor target"], bCheck = true, bChecked = not HM_TargetMon.tNTBuffEx[vk], fnAction = function()
						if HM_TargetMon.tNTBuffEx[vk] then
							HM_TargetMon.tNTBuffEx[vk] = nil
						else
							HM_TargetMon.tNTBuffEx[vk] = true
						end
					end }, { szOption = _L["Monitor myself"], bCheck = true, bChecked = not HM_TargetMon.tNSBuffEx[vk], fnAction = function()
						if HM_TargetMon.tNSBuffEx[vk] then
							HM_TargetMon.tNSBuffEx[vk] = nil
						else
							HM_TargetMon.tNSBuffEx[vk] = true
						end
					end }, { szOption = _L["Remove"], fnAction = function()
						if not HM_TargetMon.tBuffList[k] then
							HM_TargetMon.tBuffList[k] = {}
						end
						HM_TargetMon.tBuffList[k][vv] = false
						_HM_TargetMon.tBuffCache = nil
						HM.Sysmsg(_L("Removed buff monitor [%s_%s]", v.szType, vv))
					end },
				})
			end
			table.insert(m0, m1)
		end
	end
	return m0
end

---------------------------------------------------------------------
-- ���ڽ���
---------------------------------------------------------------------
-- add box/text pair
_HM_TargetMon.GetBoxText = function(hBox, hText)
	local nCount = hBox:GetItemCount()
	if hBox.nIndex < nCount then
		nCount = hBox.nIndex
	else
		hBox:AppendItemFromString("<box> w=" .. HM_TargetMon.nSize .. " h=" .. HM_TargetMon.nSize .. " postype=7 eventid=768 </box>")
		hText:AppendItemFromString("<text> w=" .. HM_TargetMon.nSize .. " h=15 postype=7 halign=1 valign=1 </text>")
		if not HM_TargetMon.bBoxEvent2 then
			hBox:Lookup(nCount):ClearEvent()
		end
	end
	hBox.nIndex = nCount + 1
	return hBox:Lookup(nCount), hText:Lookup(nCount)
end

-- get time & font
_HM_TargetMon.GetLeftTime = function(nEndFrame, bFloat)
	local nSec = (nEndFrame - GetLogicFrameCount()) / 16
	if nSec < 100 then
		if bFloat and nSec < 3 then
			return string.format("%.1f\"", nSec), 204
		else
			return string.format("%d\"", nSec), 204
		end
	elseif nSec < 3600 then
		return string.format("%d'", nSec / 60), 203
	elseif nSec < 36000 then
		return string.format("%d", nSec / 3600), 203
	else
		return "", 203
	end
end

-- update skill box
_HM_TargetMon.UpdateSkillBox = function(data, box, txt)
	local nChongNeng = _HM_TargetMon.tChongNeng[data.szName]
	if not box.dwID then
		txt:SetFontScheme(15)
		box:SetOverTextFontScheme(0, 15)
		box:SetOverTextPosition(1, ITEM_POSITION.LEFT_TOP)
		box.OnItemMouseEnter = function()
			this:SetObjectMouseOver(1)
			local x, y = this:GetAbsPos()
			local w, h = this:GetSize()
			OutputSkillTip(this.dwID, this.dwLevel, { x, y, w, h })
		end
		box.OnItemMouseLeave = function()
			this:SetObjectMouseOver(0)
			HideTip()
		end
	end
	if box.dwID ~= data.dwSkillID or box.dwLevel ~= data.dwLevel then
		box.dwID = data.dwSkillID
		box.dwLevel = data.dwLevel
		box:SetObject(UI_OBJECT_SKILL, data.dwSkillID, data.dwLevel)
		box:SetObjectIcon(data.dwIconID)
		box:SetObjectCoolDown(1)
		if string.len(data.szName) > 6 and HM_TargetMon.nSize < 70  then
			txt:SetText(string.sub(data.szName, 1, 4))
		elseif string.len(data.szName) > 4 and HM_TargetMon.nSize < 45 then
			txt:SetText(string.sub(data.szName, 3, 6))
		else
			txt:SetText(data.szName)
		end
		if nChongNeng then
			-- ��ɫ�ͺ�ɫ�ı߿�
			box:SetExtentLayer(2, "ui\\image\\Common\\Box.UITex", 2)
			box:SetExtentLayer(3, "ui\\image\\Common\\Box.UITex", 15)
			box:SetExtentImageType(3, IMAGE.REVERSE_TIMER_SHOW)
			box:SetExtentTimeStartAngle(3, math.pi * 135 / 180)
		else
			box:ClearExtentLayer(3)
			box:ClearExtentLayer(2)
			box:SetOverText(2, "")
		end
	end
	if nChongNeng then
		local nLogicFrame = GetLogicFrameCount()
		local nSec = _HM_TargetMon.GetSkillMonCD(data.szName)
		local nLeftSec = (data.nEnd - nLogicFrame) / 16
		if math.ceil(nLeftSec / nSec) == nChongNeng then -- ����CD״̬
			box:SetObjectCoolDown(1)
			box:SetCoolDownPercentage(1 - nLeftSec % nSec / nSec)
		else -- ����������״̬
			box:SetObjectCoolDown(0)
		end
		local szTime, nFont = _HM_TargetMon.GetLeftTime(data.nEnd - (math.floor(nLeftSec / nSec) * nSec * 16))
		box:SetOverText(1, szTime)
		box:SetOverTextFontScheme(1, nFont)
		box:SetOverText(2, nChongNeng - math.ceil(nLeftSec / nSec)  .. " ") -- �������ֿ������˲��ÿ� ���UI�Ӹ��ո�
		box:SetOverTextFontScheme(2, 15)
		box:SetOverTextPosition(2, ITEM_POSITION.BOTTOM_RIGHT)
		box:SetExtentPercent(3, 1 - nLeftSec % nSec / nSec)
	else
		local szTime, nFont = _HM_TargetMon.GetLeftTime(data.nEnd)
		box:SetOverText(1, szTime)
		box:SetOverTextFontScheme(1, nFont)
		box:SetCoolDownPercentage(1 - (data.nEnd - GetLogicFrameCount()) / data.nTotal)
	end
	box:Show()
	txt:Show()
end

-- update buff box
_HM_TargetMon.UpdateBuffBox = function(data, box, txt, szType)
	if not box.dwID then
		box:SetOverTextFontScheme(0, 15)
		box:SetOverTextPosition(1, ITEM_POSITION.LEFT_TOP)
		box.OnItemMouseEnter = function()
			this:SetObjectMouseOver(1)
			local dwOwner = this:GetParent().dwOwner
			local x, y = this:GetAbsPos()
			local w, h = this:GetSize()
			OutputBuffTip(dwOwner, this.dwID, this.nLevel, 1, false, 0, { x, y, w, h })
		end
		box.OnItemMouseLeave = function()
			this:SetObjectMouseOver(0)
			HideTip()
		end
	end
	if box.dwID ~= data.dwID or box.nLevel ~= data.nLevel then
		local szName, dwIconID = HM.GetBuffName(data.dwID, data.nLevel)
		box.dwID = data.dwID
		box:SetObject(UI_OBJECT_NOT_NEED_KNOWN, data.dwID)
		box:SetObjectIcon(dwIconID)
		if szType ~= _L["Others"] and szType ~= _L["Orange-weapon"] then
			szName = string.gsub(szType, "%d+$", "")
		end
		txt:SetText(szName)
		if box:GetParent().dwOwner == GetClientPlayer().dwID then
			if data.bCanCancel then
				txt:SetFontScheme(167)
			else
				txt:SetFontScheme(17)
			end
		else
			if data.bCanCancel then
				txt:SetFontScheme(16)
			else
				txt:SetFontScheme(159)
			end
		end
	end
	box.nLevel = data.nLevel
	if data.nStackNum > 1 then
		box:SetOverText(0, data.nStackNum)
	else
		box:SetOverText(0, "")
	end
	local szTime, nFont = _HM_TargetMon.GetLeftTime(data.nEndFrame, true)
	box:SetOverText(1, szTime)
	box:SetOverTextFontScheme(1, nFont)
	box:Show()
	txt:Show()
end

-- adjust size
_HM_TargetMon.AdjustSize = function(frame)
	local nW, nH = HM_TargetMon.nSize * 3, HM_TargetMon.nSize + 25
	local handle = frame:Lookup("", "")
	local hBox, hText = handle:Lookup("Handle_Box"), handle:Lookup("Handle_Text")
	frame:SetSize(nW, nH)
	handle:SetSize(nW, nH)
	hBox:SetSize(nW, HM_TargetMon.nSize)
	hText:SetSize(nW, 25)
	hText:SetRelPos(0, HM_TargetMon.nSize + 5)
	hBox:Clear()
	hText:Clear()
	handle:FormatAllItemPos()
end

-- anchor
_HM_TargetMon.UpdateAnchor = function(frame)
	local an = HM_TargetMon.tAnchor[frame.nIndex]
	if an then
		-- custom pos
		frame:SetPoint(an.s, 0, 0, an.r, an.x, an.y)
	else
		-- default pos
		local dir = Station.Lookup("Normal/HM_TargetDir")
		if dir then
			local x, y = dir:GetAbsPos()
			if frame.nIndex == 3 then
				local _, h = dir:GetSize()
				frame:SetAbsPos(x, y + h)
			else
				frame:SetAbsPos(x, y - (3 - frame.nIndex) * (HM_TargetMon.nSize + 25))
			end
		else
			frame:SetAbsPos(460, 220 + (frame.nIndex - 1) * (HM_TargetMon.nSize + 25))
		end
	end
	frame:CorrectPos()
end

-- create
_HM_TargetMon.OnFrameCreate = function()
	this:RegisterEvent("ON_ENTER_CUSTOM_UI_MODE")
	this:RegisterEvent("ON_LEAVE_CUSTOM_UI_MODE")
	this:RegisterEvent("UI_SCALED")
	_HM_TargetMon.AdjustSize(this)
	_HM_TargetMon.UpdateAnchor(this)
	if this.nIndex == 1 then
		UpdateCustomModeWindow(this, _L["HM skill CD"])
	elseif this.nIndex == 2 then
		UpdateCustomModeWindow(this, _L["HM target BUFF"])
	elseif this.nIndex == 3 then
		UpdateCustomModeWindow(this, _L["HM self BUFF"])
	end
end

-- breathe
_HM_TargetMon.OnFrameBreathe = function()
	-- base check
	local nFrame, me = GetLogicFrameCount(), GetClientPlayer()
	if not me or (nFrame % 3) ~= (this.nIndex - 1) then return end
	--if not me then return end
	local tar = GetTargetHandle(me.GetTarget())
	-- draw data
	local hBox, hText, bHide = this:Lookup("", "Handle_Box"), this:Lookup("", "Handle_Text"), true
	if this.nIndex == 1 then
		if tar and _HM_TargetMon.tCD[tar.dwID] then
			hBox.nIndex = 0
			for _, v in ipairs(_HM_TargetMon.tCD[tar.dwID]) do
				if v.nEnd > nFrame then
					local box, txt = _HM_TargetMon.GetBoxText(hBox, hText)
					_HM_TargetMon.UpdateSkillBox(v, box, txt)
					bHide = false
				end
			end
		end
	else
		local aBuff, tNo, bMine = nil, nil, false
		if this.nIndex == 2 and tar then	-- target buff
			aBuff = HM.GetAllBuff(tar)
			hBox.dwOwner = tar.dwID
			tNo = HM_TargetMon.tNTBuffEx
			bMine = not IsPlayer(tar.dwID)
		elseif this.nIndex == 3 then -- and (not tar or tar.dwID ~= me.dwID or not HM_TargetMon.bTargetBuffEx) then
			aBuff = HM.GetAllBuff(me)
			hBox.dwOwner = me.dwID
			tNo = HM_TargetMon.tNSBuffEx
		end
		if aBuff then
			local mBuff = _HM_TargetMon.GetBuffExList(aBuff, tNo)
			hBox.nIndex = 0
			if #mBuff > 0 then
				for _, v in ipairs(mBuff) do
					if not bMine or v.buff.dwSkillSrcID == me.dwID then
						local box, txt = _HM_TargetMon.GetBoxText(hBox, hText)
						_HM_TargetMon.UpdateBuffBox(v.buff, box, txt, v.szType)
					end
				end
			end
			bHide = hBox.nIndex == 0
		end
	end
	if bHide then
		hBox:Hide()
		hText:Hide()
	else
		for i = hBox:GetItemCount() - 1, hBox.nIndex, -1 do
			hBox:Lookup(i):Hide()
			hText:Lookup(i):Hide()
		end
		hBox:FormatAllItemPos()
		hText:FormatAllItemPos()
		hBox:Show()
		hText:Show()
		-- right align
		local handle = this:Lookup("", "")
		if (HM_TargetMon.bSkillRight and this.nIndex == 1)
			or (HM_TargetMon.bTargetRight and this.nIndex == 2)
			or (HM_TargetMon.bSelfRight and this.nIndex == 3)
		then
			local w1, _ = handle:GetSize()
			local w2 = hBox.nIndex * HM_TargetMon.nSize
			--local w2, _ = hBox:GetAllItemSize()
			hBox:SetRelPos(w1 - w2, 0)
			hText:SetRelPos(w1 - w2, HM_TargetMon.nSize + 5)
		else
			hBox:SetRelPos(0, 0)
			hText:SetRelPos(0, HM_TargetMon.nSize + 5)
		end
		handle:FormatAllItemPos()
	end
end

-- drag
_HM_TargetMon.OnFrameDragEnd = function()
	this:CorrectPos()
	HM_TargetMon.tAnchor[this.nIndex] = GetFrameAnchor(this)
end

-- event
_HM_TargetMon.OnEvent = function(event)
	if event == "ON_ENTER_CUSTOM_UI_MODE" or event == "ON_LEAVE_CUSTOM_UI_MODE" then
		UpdateCustomModeWindow(this)
	elseif event == "UI_SCALED" then
		_HM_TargetMon.UpdateAnchor(this)
	end
end

-- update frame
_HM_TargetMon.UpdateFrame = function(bEnable, nIndex)
	local frame = Station.Lookup("Normal/HM_TargetMon_" .. nIndex)
	if bEnable then
		if not frame then
			frame = Wnd.OpenWindow("interface\\HM\\HM_TargetMon\\HM_TargetMon.ini", "HM_TargetMon_" .. nIndex)
			frame.nIndex = nIndex
			frame.OnFrameBreathe = _HM_TargetMon.OnFrameBreathe
			frame.OnFrameDragEnd = _HM_TargetMon.OnFrameDragEnd
			frame.OnEvent = _HM_TargetMon.OnEvent
			local _this = this
			this = frame
			_HM_TargetMon.OnFrameCreate()
			this = _this
		end
	elseif frame then
		Wnd.CloseWindow(frame)
	end
end

-- update frames
_HM_TargetMon.UpdateFrames = function()
	_HM_TargetMon.UpdateFrame(HM_TargetMon.bSkillMon, 1)
	_HM_TargetMon.UpdateFrame(HM_TargetMon.bTargetBuffEx, 2)
	_HM_TargetMon.UpdateFrame(HM_TargetMon.bSelfBuffEx, 3)
end

-- adjust all size
_HM_TargetMon.AdjustSizeAll = function()
	for i = 1, 3, 1 do
		local frame = Station.Lookup("Normal/HM_TargetMon_" .. i)
		if frame then
			_HM_TargetMon.AdjustSize(frame)
			_HM_TargetMon.UpdateAnchor(frame)
			UpdateCustomModeWindow(frame)
		end
	end
end

---------------------------------------------------------------------
-- �¼���������
---------------------------------------------------------------------
_HM_TargetMon.OnSkillCast = function(dwCaster, dwSkillID, dwLevel, szEvent)
	if not HM_TargetMon.bSkillMon then
		return
	end
	-- get name
	local szName, dwIconID = HM.GetSkillName(dwSkillID, dwLevel)
	if not szName or szName == "" or dwIconID == 13 then
		return
	end
	-- for chongnen
	if _HM_TargetMon.tChongNeng[szName] and szEvent == "DO_SKILL_CAST" then
		return
	end
	_HM_TargetMon.PurgeData()
	if not HM_Jabber then
		HM.Debug3("#" .. dwCaster .. "#" .. szEvent .. " (" .. szName .. "#" .. dwSkillID .. ", Lv" .. dwLevel .. ")")
	end
	-- check reset
	local aReset = _HM_TargetMon.tSkillReset[szName] or {}
	for _, v in ipairs(aReset) do
		local aCD = _HM_TargetMon.tCD[dwCaster] or {}
		for kk, vv in ipairs(aCD) do
			if vv.szName == v then
				table.remove(aCD, kk)
			end
		end
	end
	-- check cd
	if _HM_TargetMon.tFixedSkill[szName] then
		szName = _HM_TargetMon.tFixedSkill[szName]
	end
	local nSec = _HM_TargetMon.GetSkillMonCD(szName)
	if nSec then
		local bAdd = true
		local nTotal = nSec * 16
		local nLogicFrameCount = GetLogicFrameCount()
		local nEnd = nLogicFrameCount + nTotal
		if not _HM_TargetMon.tCD[dwCaster] then
			_HM_TargetMon.tCD[dwCaster] = {}
		else
			for k, v in ipairs(_HM_TargetMon.tCD[dwCaster]) do
				if v.szName == szName then
					local nChongNeng = _HM_TargetMon.tChongNeng[szName]
					if nChongNeng then
						if v.nEnd > nLogicFrameCount then
							v.nEnd   = v.nEnd + nTotal
							v.nTotal = v.nTotal + nTotal
							bAdd = false
						end
					end
					if bAdd then
						table.remove(_HM_TargetMon.tCD[dwCaster], k)
					end
					break
				end
			end
		end
		if bAdd then
			table.insert(_HM_TargetMon.tCD[dwCaster], {
				nEnd = nEnd, nTotal = nTotal,
				dwSkillID = dwSkillID, dwLevel = dwLevel,
				dwIconID = dwIconID, szName = szName
			})
		end
	end
end

---------------------------------------------------------------------
-- ���ý���
---------------------------------------------------------------------
_HM_TargetMon.PS = {}

-- init panel
_HM_TargetMon.PS.OnPanelActive = function(frame)
	local ui, nX = HM.UI(frame), 0
	-- skillmon
	ui:Append("Text", { txt = _L["Target skill"], font = 27 })
	nX = ui:Append("WndCheckBox", { txt = _L["Enable monitor target skill CD"], checked = HM_TargetMon.bSkillMon })
	:Pos(10, 28):Click(function(bChecked)
		HM_TargetMon.bSkillMon = bChecked
		_HM_TargetMon.UpdateFrame(bChecked, 1)
		if not bChecked then _HM_TargetMon.tCD = {} end
	end):Pos_()
	ui:Append("WndCheckBox", { txt = _L["Right aligment"], checked = HM_TargetMon.bSkillRight })
	:Pos(nX + 10, 28):Click(function(bChecked) HM_TargetMon.bSkillRight = bChecked end)
	ui:Append("WndComboBox", { txt = _L["Set monitor skill"], x = 10, y = 58 }):Menu(_HM_TargetMon.GetSkillMenu)
	-- buffex
	ui:Append("Text", { txt = _L["Important BUFF"], font = 27, x = 0, y = 94 })
	nX = ui:Append("WndCheckBox", { txt = _L["Monitor target important BUFF"], checked = HM_TargetMon.bTargetBuffEx })
	:Pos(10, 122):Click(function(bChecked)
		HM_TargetMon.bTargetBuffEx = bChecked
		_HM_TargetMon.UpdateFrame(bChecked, 2)
	end):Pos_()
	ui:Append("WndCheckBox", { txt = _L["Right aligment"], checked = HM_TargetMon.bTargetRight })
	:Pos(nX + 10, 122):Click(function(bChecked) HM_TargetMon.bTargetRight = bChecked end)
	ui:Append("WndCheckBox", { txt = _L["Monitor own important BUFF"], checked = HM_TargetMon.bSelfBuffEx })
	:Pos(10, 150):Click(function(bChecked)
		HM_TargetMon.bSelfBuffEx = bChecked
		_HM_TargetMon.UpdateFrame(bChecked, 3)
	end)
	ui:Append("WndCheckBox", { txt = _L["Right aligment"], checked = HM_TargetMon.bSelfRight })
	:Pos(nX + 10, 150):Click(function(bChecked) HM_TargetMon.bSelfRight = bChecked end)
	ui:Append("WndComboBox", { txt = _L["Set monitor buff"], x = 10, y = 178 }):Menu(_HM_TargetMon.GetBuffMenu)
	-- other
	ui:Append("Text", { txt = _L["Others"], font = 27, x = 0, y = 212 })
	nX = ui:Append("Text", { txt = _L["Adjust icon size of monitor buff/skill"], x = 10, y = 240 }):Pos_()
	ui:Append("WndComboBox", "Combo_Size", { x = nX + 5, y = 240, w = 60, h = 25 })
	:Text(tostring(HM_TargetMon.nSize)):Menu(function()
		local m0 = {}
		for i = 35, 80, 5 do
			table.insert(m0, { szOption = tostring(i), fnAction = function()
				HM_TargetMon.nSize = i
				HM.UI.Fetch(frame, "Combo_Size"):Text(tostring(i))
				_HM_TargetMon.AdjustSizeAll()
			end })
		end
		return m0
	end)
	ui:Append("WndCheckBox", { txt = _L["Show buff/skill tips when mouse enter the icon (affect to rotate lens)"], checked = HM_TargetMon.bBoxEvent2 })
	:Pos(10, 268):Click(function(bChecked)
		HM_TargetMon.bBoxEvent2 = bChecked
	end)
	-- tips
	ui:Append("Text", { txt = _L["Tips"], font = 27, x = 0, y = 304 })
	ui:Append("Text", { txt = _L["1. Press SHIFT-U to adjust the monitor position"], x = 10, y = 329 })
	ui:Append("Text", { txt = _L["2. As buff name often conflict, please tell me if you find wrong"], x = 10, y = 354 })
end

---------------------------------------------------------------------
-- ע���¼�����ʼ��
---------------------------------------------------------------------
HM.RegisterEvent("PLAYER_ENTER_GAME", _HM_TargetMon.UpdateFrames)
HM.RegisterEvent("SYS_MSG", function()
	if arg0 == "UI_OME_SKILL_HIT_LOG" and arg3 == SKILL_EFFECT_TYPE.SKILL then
		_HM_TargetMon.OnSkillCast(arg1, arg4, arg5, arg0)
	elseif arg0 == "UI_OME_SKILL_EFFECT_LOG" and arg4 == SKILL_EFFECT_TYPE.SKILL then
		_HM_TargetMon.OnSkillCast(arg1, arg5, arg6, arg0)
	elseif (arg0 == "UI_OME_SKILL_BLOCK_LOG" or arg0 == "UI_OME_SKILL_SHIELD_LOG"
			or arg0 == "UI_OME_SKILL_MISS_LOG" or arg0 == "UI_OME_SKILL_DODGE_LOG")
		and arg3 == SKILL_EFFECT_TYPE.SKILL
	then
		_HM_TargetMon.OnSkillCast(arg1, arg4, arg5, arg0)
	end
end)
HM.RegisterEvent("DO_SKILL_CAST", function()
	_HM_TargetMon.OnSkillCast(arg0, arg1, arg2, "DO_SKILL_CAST")
end)

-- add to HM panel
HM.RegisterPanel(_L["Target BUFF/CD"], 332, _L["Target"], _HM_TargetMon.PS)

-- public api
HM_TargetMon.GetBuffExType = _HM_TargetMon.GetBuffExType
HM_TargetMon.GetBuffExList = _HM_TargetMon.GetBuffExList
HM_TargetMon.UpdateFrames = _HM_TargetMon.UpdateFrames
HM_TargetMon.GetLeftTime  = _HM_TargetMon.GetLeftTime
HM_TargetMon.GetPlayerCD = function(dwPlayer) return _HM_TargetMon.tCD[dwPlayer] or {} end
