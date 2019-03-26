
SELECT * from A_ORD_RIS where ITEMNO in
  (SELECT ITEMNO from
  (SELECT DISTINCT ITEMNO, ITEMNAME, FORMID,FORMNAME from A_ORD_RIS) GROUP BY ITEMNO,ITEMNAME HAVING count(1) > 1)

SELECT CODE,NAME,CODE_EMRTEMP,NAME_EMRTEMP,PK_EMRTEMP from BD_ORD ord
  INNER JOIN BD_ORD_EMR emr on emr.PK_ORD = ord.PK_ORD and emr.DEL_FLAG = 0 and ord.DEL_FLAG = 0
where not exists(SELECT * from A_ORD_RIS aris where ITEMNO in
  (SELECT ITEMNO from
  (SELECT DISTINCT ITEMNO, ITEMNAME, FORMID,FORMNAME from A_ORD_RIS) GROUP BY ITEMNO,ITEMNAME HAVING count(1) > 1)
    and aris.ITEMNO = CODE and aris.ITEMNAME = NAME and aris.FORMID = emr.CODE_EMRTEMP
)

SELECT * from A_ORD_RIS aris where ITEMNO in
  (SELECT ITEMNO from
  (SELECT DISTINCT ITEMNO, ITEMNAME, FORMID,FORMNAME from A_ORD_RIS) GROUP BY ITEMNO,ITEMNAME HAVING count(1) > 1)
AND not exists(SELECT CODE,NAME,CODE_EMRTEMP,NAME_EMRTEMP,PK_EMRTEMP from BD_ORD ord
  INNER JOIN BD_ORD_EMR emr on emr.PK_ORD = ord.PK_ORD and emr.DEL_FLAG = 0 and ord.DEL_FLAG = 0
  where  aris.ITEMNO = CODE and aris.ITEMNAME = NAME and aris.FORMID = emr.CODE_EMRTEMP
) and ITEMNAME = '乳腺彩超（穿刺等专用）'

--执行科室
insert into NHIS_GZ.BD_ORD_DEPT
select
	replace(sys_guid(), '-', '') PK_ORDDEPT,
	'a41476368e2943f48c32d0cb1179dab8' PK_ORG,
	PK_ORDORG,
	PK_ORD,
	'a41476368e2943f48c32d0cb1179dab8' PK_ORG_EXEC,
	PK_DEPT,
	'1' FLAG_DEF,
	'检查项目' CREATOR,
	sysdate CREATE_TIME,
	null MODIFIER,
	'0' DEL_FLAG,
	null TS
from

---电子单
INSERT INTO BD_ORD_EMR
  SELECT
    replace(sys_guid(), '-', '') PK_ORDEMR,
    '~'                          PK_ORG,
    t.PK_ORD                    PK_ORD,
    t.PK_TMP                         PK_EMRTEMP,
    '1'                          FLAG_ACTIVE,
    NULL                         CREATOR,
    sysdate                      CREATE_TIME,
    NULL                         MODIFIER,
    NULL                         MODITY_TIME,
    '0'                          DEL_FLAG,
    NULL                         TS,
    DZDID                       CODE_EMTEMP,
    DZDNAME                  NAME_EMTEMP,
;

SELECT * from BD_ORD where OLD_ID is null;
SELECT dt.* from BL_IP_DT dt
  INNER JOIN BD_PD pd on pd.PK_PD = dt.PK_PD
  INNER JOIN BD_OU_DEPT dept on dept.PK_DEPT = dt.PK_DEPT_EX
where pd.dt_pois in ('01','02','04') and NAME_DEPT = '南院麻醉科';

UPDATE BL_IP_DT
set BATCH_NO = '1171206'
 where PK_CGIP in (SELECT PK_CGIP from BL_IP_DT dt
  INNER JOIN BD_PD pd on pd.PK_PD = dt.PK_PD
  INNER JOIN BD_OU_DEPT dept on dept.PK_DEPT = dt.PK_DEPT_EX
where pd.dt_pois in ('01','02','04') and NAME_DEPT = '南院麻醉科' and dt.PK_PD = 'A122C646F39D47F88DCAC794311B4714')
--瑞80A07121  EBA1F0A1D4534CD2AB245B5BDF14C29B
--舒1180102 1D0900237CC14B1AAC6894B9EDA7FADB
-- 芬1171206 A122C646F39D47F88DCAC794311B4714
-- 吗160705-2
SELECT * from BD_PD_IND
SELECT * from BD_PD where;

select * from BL_IP_DT where PRICE > '2000' ;

SELECT PK_ITEM from BD_PD;

SELECT * from PV_ENCOUNTER where NAME_PI = '周文勇'
SELECT * from CN_ORDER where PK_PV = '8db649cf6f4a4a14abc18f092d671d8f' ORDER BY ORDSN DESC
SELECT * from EX_ORDER_OCC where PK_CNORD = '4233e0ffb11a4f41b9ec4c9f000db5f7';

----------------------------------------------------------------------高值耗材报表
SELECT
--  CASE when PK_PD is not null and FLAG_PD = 1 then '1'
--  when PK_PD is null and FLAG_PD = 1 then '2'
--   when PK_PD is null and FLAG_PD = 0 then '3'
--  end type,
  edept.NAME_DEPT,adept.NAME_DEPT,NAME_CG,SPEC,NAME,QUAN,sum(AMOUNT)
from BL_IP_DT dt
  INNER JOIN BD_OU_DEPT adept on adept.PK_DEPT = dt.PK_DEPT_APP
  INNER JOIN BD_OU_DEPT edept on edept.PK_DEPT = dt.PK_DEPT_EX
  INNER JOIN BD_OU_DEPT cdept on cdept.PK_DEPT = dt.PK_DEPT_CG
  LEFT JOIN BD_UNIT unit on unit.PK_UNIT = dt.PK_UNIT
  where edept.NAME_DEPT like '乳腺肿瘤%'
GROUP BY edept.NAME_DEPT,adept.NAME_DEPT,NAME_CG,SPEC,NAME,QUAN
;
;
  INNER JOIN
where PK_CNORD = '535bfeab09384b7f9d14ce9bcbc6f87f';
--flag_pd

----------------------------------------------------------------------急诊药房目录


----检查还有哪些缺失标本的检验项目
SELECT ord.PK_ORD,CODE,NAME,ord.OLD_ID,ord.YB_ID,ord.DEL_FLAG,FLAG_ACTIVE,ord.OLD_TYPE,DT_CONTYPE,lab.DT_SAMPTYPE,alab.DT_SAMPTYPE from BD_ORD ord
	INNER JOIN BD_ORD_LAB lab on lab.PK_ORD = ord.PK_ORD
	INNER JOIN (SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
							from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') alab on alab.YB_ID = ord.YB_ID
where ord.YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0 and lab.DT_SAMPTYPE <> alab.DT_SAMPTYPE;

-- UPDATE BD_ORD_LAB
--  set DT_SAMPTYPE =  '194'
-- where PK_ORDLAB in
 (SELECT lab.DT_SAMPTYPE,alab.DT_SAMPTYPE,NAME from BD_ORD ord
                    	INNER JOIN BD_ORD_LAB lab on lab.PK_ORD = ord.PK_ORD
                    	INNER JOIN (SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
                    							from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') alab on alab.YB_ID = ord.YB_ID
                    where ord.YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0 and lab.DT_SAMPTYPE is null or lab.DT_SAMPTYPE = '-1' )
-- UPDATE BD_ORD_LAB
--  set DT_SAMPTYPE =  '194'
where PK_ORDLAB in (SELECT PK_ORDLAB from BD_ORD ord
                    	INNER JOIN BD_ORD_LAB lab on lab.PK_ORD = ord.PK_ORD
                    	INNER JOIN (SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
                    							from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') alab on alab.YB_ID = ord.YB_ID
                    where ord.YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0 and lab.DT_SAMPTYPE is null or lab.DT_SAMPTYPE = '-1' );

----检查还有哪些缺失容器的检验项目
SELECT ord.PK_ORD,CODE,NAME,ord.OLD_ID,ord.YB_ID,ord.DEL_FLAG,FLAG_ACTIVE,ord.OLD_TYPE,lab.DT_CONTYPE,alab.DT_CONTYPE,lab.DT_SAMPTYPE,alab.DT_SAMPTYPE from BD_ORD ord
	INNER JOIN BD_ORD_LAB lab on lab.PK_ORD = ord.PK_ORD
	INNER JOIN (SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_CONTYPE,SPCODE,D_CODE
							from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') alab on alab.YB_ID = ord.YB_ID
where ord.YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0 and lab.DT_CONTYPE <> alab.DT_CONTYPE;

UPDATE BD_ORD_LAB labb
SET DT_CONTYPE = (SELECT alab.DT_CONTYPE from BD_ORD ord
	INNER JOIN BD_ORD_LAB lab on lab.PK_ORD = ord.PK_ORD
	INNER JOIN (SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_CONTYPE,SPCODE,D_CODE
							from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') alab on alab.YB_ID = ord.YB_ID
where ord.YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0 and lab.DT_CONTYPE <> alab.DT_CONTYPE and lab.PK_ORDLAB = labb.PK_ORDLAB)
where PK_ORDLAB in (SELECT PK_ORDLAB from BD_ORD ord
	INNER JOIN BD_ORD_LAB lab on lab.PK_ORD = ord.PK_ORD
	INNER JOIN (SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_CONTYPE,SPCODE,D_CODE
							from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') alab on alab.YB_ID = ord.YB_ID
where ord.YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0 and lab.DT_CONTYPE <> alab.DT_CONTYPE )



-----------------------------------------
--OLD_TYPE = 1
SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%'; --USINGSCOPEfLAG not in ('1','4','8','16','32','0','28','12','56','33','60','40','28')
-- DELETE from A_BD_ORD_LAB;
SELECT * from A_BD_ORD_LAB;

--需要停止的检验项目
--UPDATE BD_ORD ordd
set FLAG_ACTIVE = 0
where exists(
SELECT itemset.YB_ID,ord.YB_ID,NAME from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	RIGHT JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where itemset.YB_ID is null and ord.PK_ORD = ordd.PK_ORD)

--需要增加的检验项目
SELECT itemset.YB_ID,ord.YB_ID from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	LEFT JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where ord.YB_ID is null;

--更改别名表,一定要先更改这个表,而且查询时也是查询这个表
--------检查名字不一样
SELECT ORD_NAME,NAME,CODE from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME;

--UPDATE BD_ORD_ALIAS ordd
set ALIAS = (SELECT itemset.ORD_NAME from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME and ord.PK_ORD = ordd.PK_ORD),
	SPCODE = (SELECT itemset.SPCODE from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME and ord.PK_ORD = ordd.PK_ORD),
	D_CODE = (SELECT itemset.D_CODE from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME and ord.PK_ORD = ordd.PK_ORD)
where exists(SELECT itemset.SPCODE from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME and ord.PK_ORD = ordd.PK_ORD);

---更改bd_ord表
--UPDATE BD_ORD ordd
set NAME = (SELECT itemset.ORD_NAME from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME and ord.PK_ORD = ordd.PK_ORD),
	SPCODE = (SELECT itemset.SPCODE from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME and ord.PK_ORD = ordd.PK_ORD)
where exists(SELECT itemset.SPCODE from
	(SELECT DISTINCT YB_ID,OLD_TYPE,OLD_ID,ORD_CODE,ORD_NAME,USINGSCOPE,DEPT_ID,DT_SAMPTYPE,DT_COLLTYPE,SPCODE,D_CODE
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
	INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
where NAME <> ORD_NAME and ord.PK_ORD = ordd.PK_ORD);




---费用变更
--总数3085,现匹配2771,系统当前数量2803,需要删除数量32,增加数量314
SELECT itemset.YB_ID,ord.YB_ID,ORD_NAME,ITEM_CODE,item.NAME,ITEM_PRICE from
(SELECT *
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
 inner join BD_ITEM item on item.YB_ID = itemset.ITEM_ID
where not exists(SELECT * from BD_ORD_ITEM orditem where DEL_FLAG = 0
 and orditem.PK_ORD = ord.PK_ORD and orditem.PK_ITEM = item.PK_ITEM and orditem.QUAN = itemset.QUAN);

SELECT * from BD_ORD_ITEM orditem
	INNER JOIN BD_ORD ord on ord.PK_ORD = orditem.PK_ORD  and orditem.DEL_FLAG = 0
													 and YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0
 where not exists (SELECT itemset.YB_ID,ord.YB_ID,ORD_NAME,ITEM_CODE,ITEM_PRICE from
(SELECT *
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
 inner join BD_ITEM item on item.YB_ID = itemset.ITEM_ID
 where orditem.PK_ORD = ord.PK_ORD and orditem.PK_ITEM = item.PK_ITEM and orditem.QUAN = itemset.QUAN)

-----新增医嘱收费项目对照关系
--insert into BD_ORD_ITEM
select
	replace(sys_guid(), '-', '') PK_ORDITEM,
	'a41476368e2943f48c32d0cb1179dab8' PK_ORG,
	PK_ORD,
	PK_ITEM,
	QUAN,
	'0' SORTNO,
	'ben0323' CREATOR,
	sysdate CREATE_TIME,
	null MODIFIER,
	'0' DEL_FLAG,
	null TS,
	null FLAG_OPT,
	'0' FLAG_PD,
	'0' FLAG_UNION,  --默认不合并
	null OLD_ID
from (SELECT itemset.YB_ID,ord.YB_ID,ORD_NAME,ITEM_CODE,item.NAME,ITEM_PRICE,ord.PK_ORD,PK_ITEM,QUAN from
(SELECT *
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
 inner join BD_ITEM item on item.YB_ID = itemset.ITEM_ID
where not exists(SELECT * from BD_ORD_ITEM orditem where DEL_FLAG = 0
 and orditem.PK_ORD = ord.PK_ORD and orditem.PK_ITEM = item.PK_ITEM and orditem.QUAN = itemset.QUAN));
---删除医嘱收费项目对照关系
--UPDATE BD_ORD_ITEM
set DEL_FLAG = '1'
where PK_ORDITEM in (
SELECT orditem.PK_ORDITEM from BD_ORD_ITEM orditem
	INNER JOIN BD_ORD ord on ord.PK_ORD = orditem.PK_ORD  and orditem.DEL_FLAG = 0
													 and YB_ID like '1-%' and FLAG_ACTIVE = 1 and ord.DEL_FLAG = 0
 where not exists (SELECT itemset.YB_ID,ord.YB_ID,ORD_NAME,ITEM_CODE,ITEM_PRICE from
(SELECT *
	 from A_BD_ORD_LAB where USINGSCOPE  LIKE '%住院%') itemset
INNER JOIN (SELECT * from BD_ORD where YB_ID like '1-%' and FLAG_ACTIVE = 1 and DEL_FLAG = 0) ord on ord.YB_ID = itemset.YB_ID
 inner join BD_ITEM item on item.YB_ID = itemset.ITEM_ID
 where orditem.PK_ORD = ord.PK_ORD and orditem.PK_ITEM = item.PK_ITEM and orditem.QUAN = itemset.QUAN))


SELECT * from BD_ORD where NAME like '%test%'
SELECT * from BD_ORD_ITEM where PK_ORD = 'a7e70d0665264e65a299c2171e42ac05';
SELECT PRICE,PACK_SIZE from BD_PD where NAME = '5%葡萄糖注射液GS'
SELECT * from BD_PD_STORE where PACK_SIZE is null;
SELECT * from BD_PD_CONVERT where PACK_SIZE is null;
SELECT count(1), PK_ORD,PK_ITEM from BD_ORD_ITEM where DEL_FLAG = 0 GROUP BY PK_ORD,PK_ITEM HAVING count(1) > 1
SELECT * from A_BD_ORD_LAB GROUP BY YB_ID,ITEM_ID HAVING count(1)

SELECT * from A_BD_ORD_ITEM_DETIAL where DESCRIPTION = '双肾CT平扫+增强+CTA'

SELECT * from BD_PD where PK_PD = '5FABF2284B7F47FCAC0665C5A680586F';
SELECT * from BD_DEFDOC where CODE_DEFDOCLIST = '030203';
SELECT * from BD_ITEM where  CODE_HP like '9-357';



SELECT
	item.*
FROM
	(

			SELECT
				pd.code,
				pd.eu_usecate,
				pd.flag_st,
				'1' AS flag_unit,
				'' AS srv_pk_unit,
				pd.pk_pd AS pk_ord,
				ordtype.code AS code_ordtype,
				als. ALIAS AS NAME,
				als.spcode AS py_code,
				als.d_code,
				pd. NAME AS srvname,
				'1' AS flag_pd,
				'1' AS flag_bl,
				'0' AS flagctlsrv,
				pd.note AS descord,
				pd.pk_org,
				pd.code_freq,
				fqed.eu_always,
				fqed.cnt,
				pd.code_supply,
				sup.flag_pivas,
				'' AS usagenote,
				pd.dosage_def AS quan_def,
				pd.pk_unit_def,
				pds.pk_org AS pk_org_exec,
				pds.pk_dept AS pk_dept_exec,
				con.pack_size * pd.price / pd.pack_size AS price,
				pd.pk_unit_min,
				pd.weight,
				pd.pk_unit_wt,
				pd.vol,
				pd.pk_unit_vol,
				CASE
			WHEN bas.pk_pd IS NULL THEN
				con.spec
			ELSE
				pd.spec
			END spec,
			con.pack_size,
			con.pk_unit,
			unit. NAME unit,
			stk.quan_min,
			stk.quan_min / con.pack_size quan_pack,
			pd.dt_pois,
			pd.dt_anti,
			pd.flag_ped,
			ind.desc_ind,
			'0' AS eu_hptype,
			'0' AS eu_hpratio,
			CASE
		WHEN bas.pk_pd IS NULL THEN
			'0'
		ELSE
			'1'
		END flag_base,
		pds.pk_pdconvert,
		pd.eu_sex,
		pd.age_min,
		pd.age_max,
		pd.eu_muputype,
		pd. NAME AS pd_name
	FROM
		bd_pd pd
	INNER JOIN bd_pd_as als ON pd.pk_pd = als.pk_pd
	AND als.del_flag = '0'
	INNER JOIN bd_ordtype ordtype ON ordtype.pk_ordtype = pd.pk_ordtype
	AND ordtype.del_flag = '0'
	LEFT JOIN bd_pd_store pds ON pds.pk_pd = pd.pk_pd
	AND pds.flag_stop = '0'
	AND pds.del_flag = '0'
	AND pds.pk_dept IN (
		'3E6F13C8B5F44204B852C83928A51307',
		'72697297D860419CB0A94F6E44EE5F79'
	)
	LEFT JOIN bd_pd_convert con ON con.pk_pdconvert = pds.pk_pdconvert
	AND con.del_flag = '0'
	LEFT OUTER JOIN bd_unit unit ON con.pk_unit = unit.pk_unit
	AND unit.del_flag = '0'
	LEFT OUTER JOIN (
		SELECT
			SUM (quan_min - quan_prep) quan_min,
			pk_pd,
			flag_stop
		FROM
			pd_stock
		WHERE
			del_flag = '0'
		AND pk_dept IN (
			'3E6F13C8B5F44204B852C83928A51307',
			'72697297D860419CB0A94F6E44EE5F79'
		)
		GROUP BY
			pk_pd,
			flag_stop
	) stk ON pds.pk_pd = stk.pk_pd
	LEFT OUTER JOIN bd_pd_base bas ON pd.pk_pd = bas.pk_pd
	AND bas.del_flag = '0'
	AND bas.pk_dept = 'B9771C4A92084058A612212F98FBCD15'
	LEFT OUTER JOIN bd_pd_rest rest ON pd.pk_pd = rest.pk_pd
	AND rest.del_flag = '0'
	LEFT JOIN bd_term_freq fqed ON fqed.code = pd.code_freq
	AND fqed.del_flag = '0'
	LEFT JOIN bd_supply sup ON sup.code = pd.code_supply
	AND sup.del_flag = '0'
	LEFT JOIN (
		SELECT
			idp.pk_pd,
			bind.desc_ind
		FROM
			bd_indtype idt
		INNER JOIN bd_pd_ind bind ON idt.code_type = bind.code_indtype
		AND bind.del_flag = '0'
		INNER JOIN bd_pd_indpd idp ON bind.pk_pdind = idp.pk_pdind
		AND idp.del_flag = '0'
		INNER JOIN bd_pd_indhp idh ON idt.pk_indtype = idh.pk_indtype
		AND idh.del_flag = '0'
		AND idh.pk_hp = 'EA7A36C38B454455B3A1B4C5507B1831'
	) ind ON ind.pk_pd = pd.pk_pd
	WHERE
		pd.dt_pdtype LIKE '0%'
	AND pd.flag_reag = '0'
	AND pd.flag_rm = '0'
	AND (
		(
			bas.pk_pd IS NULL
			AND pds.pk_pdconvert IS NOT NULL
		)
		OR (bas.pk_pd IS NOT NULL)
	)
	AND (
		pds.pk_pdconvert IS NULL
		OR (
			pds.pk_pdconvert IS NOT NULL
			AND NVL (stk.flag_stop, '0') = '0'
		)
	)
	AND pd.flag_stop = '0'
	AND (
		rest.eu_ctrltype IS NULL
		OR (
			rest.eu_ctrltype = '0'
			AND rest.pk_emp = '9b4573800bf34b13bb71cc0c62ef79ad'
		)
		OR (
			rest.eu_ctrltype = '1'
			AND rest.pk_dept = '60EC696A79EE4BAEB2D3EB9265B237B1'
		)
		OR (
			rest.eu_ctrltype = '2'
			AND rest.pk_diag = '7E852FF776D2D770E053C008A8C0A432'
		)
	)
	) item
INNER JOIN bd_ordtype ty ON item.code_ordtype = ty.code
WHERE
	ty.eu_cpoetype = '0'
AND (
	1 = 0
	OR item. NAME LIKE '%FHWSSHJ%'
	OR item.code LIKE '%000491%'
)
ORDER BY
	LENGTH (item. NAME)

SELECT * from BD_OU_DEPT where pk_dept IN (
			'3E6F13C8B5F44204B852C83928A51307',
			'72697297D860419CB0A94F6E44EE5F79'
		)