/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000
       wfin.[WFIN_KRED_ID] as [CBWG_WFIN_KRED_ID]
      ,wfin.[WFIN_CBS_TWFI_KOD] as [CBWG_WFIN_CBS_TWFI_KOD]
      ,(select cbs_twfi.[TWFI_NAZWA] from [CBS].[SCH_OBIEKTY].[T_TYPY_WARUNKOW_FINANSOWYCH] cbs_twfi 
									where (cbs_twfi.[TWFI_ID] = wfin.[WFIN_CBS_TWFI_ID])) as [CBWG_WFIN_CBS_TWFI_NAZWA]
      ,wfin.[WFIN_WARTOSC_PROC] as [CBWG_WFIN_WARTOSC_PROC]
      ,(select cbs_podm.[PODM_NAZWA_SKROCONA] from [CBP].[SCH_PODMIOTY].[T_PODMIOTY] cbs_podm 
											 where (cbs_podm.[PODM_ID] = wfin.[WFIN_CBP_PODM_ID])) [CBWG_WFIN_CBP_PODM_NAZWA]
      ,wfin.[WFIN_WARTOSC_PROC_BAZOWA] as [CBWG_WFIN_WARTOSC_PROC_BAZOWA]
      ,wfin.[WFIN_CBP_WWFI_ID] as [CBWG_WFIN_CBP_WWFI_ID]
      ,cbp_wwfi.[WWFI_WFIN_ID] as [CBP_WWFI_WFIN_ID]
	  ,cbp_wwfi.[WWFI_TYP_WYLICZENIA]
	  ,case 
			when cbp_wwfi.[WWFI_TYP_WYLICZENIA] IS NULL then ''
			when cbp_wwfi.[WWFI_TYP_WYLICZENIA]  = 0 then 'Podana wartość'
			when cbp_wwfi.[WWFI_TYP_WYLICZENIA]  = 5 then 'Przedział z wartością domyślną'
			when cbp_wwfi.[WWFI_TYP_WYLICZENIA]  = 7 then 'Tabela'
			when cbp_wwfi.[WWFI_TYP_WYLICZENIA]  = 8 then 'Tabela z przedziałem'
			when cbp_wwfi.[WWFI_TYP_WYLICZENIA]  = 9 then 'Tabela z przedziałami'
			else 'Wartość nie zdefiniowana'
			end as [CBP_WWFI_TYP_WYLICZENIA]
      ,cbp_wwfi.[WWFI_WARTOSC] as [CBP_WWFI_WARTOSC]
      ,cbp_wwfi.[WWFI_FN_WYBIERAJCA] as [CBP_WWFI_FN_WYBIERAJCA]
      ,cbp_wwfi.[WWFI_WARTOSC_OD] as [CBP_WWFI_WARTOSC_OD]
      ,cbp_wwfi.[WWFI_WARTOSC_DO] as [CBP_WWFI_WARTOSC_DO]
	  ,cbp_wfin.[WFIN_NAZWA] as [CBP_WFIN_NAZWA]
      ,cbp_wfin.[WFIN_KOD] as [CBP_WFIN_KOD]
      ,wfin.[WFIN_UBEZ_ID] as [CBWG_WFIN_UBEZ_ID]
	  ,case 
			when wfin.[WFIN_UBEZ_ID] is null then ''

			when wfin.[WFIN_UBEZ_ID] is not null then (
													   select cbu_ubez.[UBEZ_NAZWA]
													   from [CBU].[SCH_UBEZP].[T_UBEZPIECZENIA] cbu_ubez 
													   where (
																cbu_ubez.[UBEZ_ID] = (
																						select ubez.[UBEZ_CBU_UBEZ_ID] 
																						from [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_UBEZPIECZENIA] ubez
																						where ubez.[UBEZ_ID] = wfin.[WFIN_UBEZ_ID]
																					 )
															 )
													  )
	   end as [CBWG_WFIN_UBEZ_NAZWA]
	  ,case 
			when wfin.[WFIN_UBEZ_ID] is null then ''

			when wfin.[WFIN_UBEZ_ID] is not null then (
													   select cbu_ubez.[UBEZ_KOD]
													   from [CBU].[SCH_UBEZP].[T_UBEZPIECZENIA] cbu_ubez 
													   where (
																cbu_ubez.[UBEZ_ID] = (
																						select ubez.[UBEZ_CBU_UBEZ_ID] 
																						from [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_UBEZPIECZENIA] ubez
																						where ubez.[UBEZ_ID] = wfin.[WFIN_UBEZ_ID]
																					 )
															 )
													  )


	   end as [CBWG_WFIN_UBEZ_KOD]
  from [CBWG].[SCH_SPRAWY_KREDYTOWE].[T_WARUNKI_FINANSOWE] wfin
  inner join [CBP].[SCH_PODMIOTY].[T_WERSJE_WARUNKOW_FINANSOWYCH] cbp_wwfi on cbp_wwfi.[WWFI_ID] = wfin.[WFIN_CBP_WWFI_ID]
  inner join [CBP].[SCH_PODMIOTY].[T_WARUNKI_FINANSOWE] cbp_wfin on cbp_wfin.[WFIN_ID] = cbp_wwfi.[WWFI_WFIN_ID]
  where 
			cbp_wwfi.[WWFI_CBS_ESLO_STAW_ID] = 18 and (cbp_wwfi.[WWFI_DATA_OD]<getdate() and getdate()<cbp_wwfi.[WWFI_DATA_DO])
		and wfin.[WFIN_KRED_ID] =20951

  order by wfin.[WFIN_KRED_ID] desc