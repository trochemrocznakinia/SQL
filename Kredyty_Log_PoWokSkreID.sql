/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 
klog.[KRED_ID]
      ,klog.[KRED_XML]
      ,klog.[CBUZ_UTWORZYL_ID]
      ,klog.[DATA_UTWORZENIA]
      ,klog.[CBUZ_MODYFIKOWAL_ID]
      ,klog.[DATA_MODYFIKACJI]
      ,klog.[DATA_PART]
	  ,wok.[WOK_SKRE_ID]
  FROM [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_KREDYTY_LOG] as klog
  join [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_KREDYTY] as kred on kred.[KRED_ID]=klog.[KRED_ID]
  join [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_OFERTY_KREDYTOWE] as okre on kred.[KRED_OKRE_ID] = okre.[OKRE_ID]
  join [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_WERSJE_OFERT_KREDYTOW] as wok on okre.OKRE_WOK_ID = wok.WOK_ID
  where [WOK_SKRE_ID] = 2296927 and WOK.[WOK_CBS_ESLO_STAW_ID]=18
  order by klog.[DATA_UTWORZENIA] desc