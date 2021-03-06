/****** Script for SelectTopNRows command from SSMS  ******/

select [WOK_ID], [WOK_CBS_ESLO_STAW_ID], [DATA_UTWORZENIA]
from [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_WERSJE_OFERT_KREDYTOW]
where [WOK_SKRE_ID] = 2361442


SELECT TOP 1000 
	   wofe.[WOK_ID]
      --,wofe.[WOK_SKRE_ID]
      ,wofe.[WOK_CBS_ESLO_STAW_ID]
      ,wofe.[WOK_CZY_ZGODA_WSPOLMALZONKA]
      ,wofe.[WOK_CZY_WYBRANE_UBEZPIECZENIE]
	  ,okre.[OKRE_ID]
	  ,(select ofer.[OFER_ID] from [CBO].[SCH_OFERTY].[T_OFERTY] as ofer where (ofer.[OFER_ID] = okre.[OKRE_CBO_OFER_ID])) as [ID oferty]
      ,(select ofer.[OFER_KOD] from [CBO].[SCH_OFERTY].[T_OFERTY] as ofer where (ofer.[OFER_ID] = okre.[OKRE_CBO_OFER_ID])) as [Kod oferty]
	  ,(select ofer.[OFER_NAZWA] from [CBO].[SCH_OFERTY].[T_OFERTY] as ofer where (ofer.[OFER_ID] = okre.[OKRE_CBO_OFER_ID])) as [Nazwa oferty]
      ,okre.[OKRE_CBM_OMAI_ID]
      ,okre.[OKRE_CZY_DOSTEPNA]
      ,okre.[OKRE_CZY_ZAZNACZONA]
      ,okre.[OKRE_CZY_UBEZPIECZENIE_WYMAGANE]
      ,okre.[OKRE_CZY_DOSTEPNY_BRAK_UBEZPIECZENIA]
	  ,okre.[OKRE_LIMIT_GLOBALNY_BEZ_ZGODY_WSPOL]
	  ,kred.[KRED_ID]
      ,kred.[KRED_OKRE_ID]
      ,kred.[KRED_KWOTA_NETTO]
      ,kred.[KRED_KWOTA_BRUTTO]
      ,kred.[KRED_MAX_RATA]
      ,kred.[KRED_OKRES_KREDYTOWANIA]
      ,kred.[KRED_CZY_ZGODA_WSPOLMALZONKA]
	  ,kred.[KRED_CZY_WYMAGANE_PORECZ]
	  ,kred.[KRED_CZY_OSWIADCZENIE_MOZLIWE]
      ,kred.[KRED_CZY_WYBRANY]
      ,kred.[KRED_CZY_ZAPREZENTOWANY]
      ,kred.[KRED_CZY_PRZELICZONY]
	  ,kred.[KRED_CBU_GRUP_ID_WYBRANA]
	  ,kred.[KRED_MAX_KWOTA_BRUTTO_UBEZPIECZENIE]
	  ,kred.[KRED_CZY_PRZEKROCZENIE_KWOTY_W_PROCEDURZE_UPROSZCZONEJ]
      ,kred.[KRED_SUMA_ZAANGAZOWANIA_W_PROCEDURZE_UPROSZCZONEJ]
	  ,kred.[KRED_DATA_OSTATNIEJ_RATY]
	  ,kred.[KRED_WAGA_PROWIZJI]
	  ,kred.[KRED_WSPOLCZYNNIK_RRK]
	  ,wofe.[WOK_SKRE_ID]
	  --,kred.[KRED_KWOTA_KAUCJI]
	  --,klog.[KRED_XML]
	  ,kucz.[KUCZ_MAX_KWOTA_BRUTTO]
      ,kucz.[KUCZ_MAX_KWOTA_NETTO_ZDOLNOSC]
      ,kucz.[KUCZ_MAX_KWOTA_NETTO_DOCHODY]
      ,kucz.[KUCZ_MAX_KWOTA_NETTO_SCORING]
      ,kucz.[KUCZ_MAX_KWOTA_NETTO_MAILING]
      ,kucz.[KUCZ_MAX_KWOTA_NETTO_RACHUNEK]
      ,kucz.[KUCZ_MAX_KWOTA_NETTO_OFERTA]
	  ,kucz.[KUCZ_LIMIT_BEZ_ZGODY_MALZONKA]
	  ,okre.[OKRE_CZY_PETLA_OSWIADCZENIE]
  FROM [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_WERSJE_OFERT_KREDYTOW] as wofe
  inner join [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_OFERTY_KREDYTOWE] as okre on wofe.[WOK_ID] = okre.[OKRE_WOK_ID]
  inner join [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_KREDYTY] as kred on okre.[OKRE_ID] = kred.[KRED_OKRE_ID]
  --inner join [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_KREDYTY_LOG] as klog on kred.[KRED_ID] = klog.[KRED_ID]
  inner join [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_KREDYT_UCZESTNICY] as kucz on kred.[KRED_ID] = kucz.[KUCZ_KRED_ID]
  where 
			(wofe.[WOK_CBS_ESLO_STAW_ID] = 18
		or	wofe.[WOK_CBS_ESLO_STAW_ID] = 56)
		and okre.[OKRE_CZY_DOSTEPNA] = 1
		and ([WOK_SKRE_ID] = 2361442)
		--and kred.[KRED_CZY_WYBRANY] = 1
	
  order by wok_skre_id desc --kred.[KRED_KWOTA_NETTO] desc, kred.[KRED_OKRES_KREDYTOWANIA] desc, kred.[KRED_MAX_RATA] asc

  --update [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_KREDYTY]
  --set [KRED_KWOTA_KAUCJI] = 123456789.12000
  --where [KRED_ID] = 142951
