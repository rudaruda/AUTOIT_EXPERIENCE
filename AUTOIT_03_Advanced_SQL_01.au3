Global $adCN = ObjCreate ("ADODB.Connection")
Global $adRS = ObjCreate("ADODB.Recordset")
; Set String
Global $constrim = "DRIVER={" & $driver & "};SERVER=" & $server & ";DATABASE=" & $db & ";User=" & $uid & ";Password=" & $pwd & ";Option=3"
; Connect with DATABASE
$adCN.Open ($constrim)
; Update
$strSQL = "UPDATE db_name.tb_table SET CPU_REMOTE = null, RECIBO_DTHR_START_NCOB = NULL, RECIBO_DTHR_UPDAT_NCOB = NULL, RECIBO_STATUS_NCOB = 0, RES_RECIBO_NCOB = NULL, RES_PROMESSA_NCOB = NULL, RES_CODIGODECONTA_NCOB =  NULL, RECIBO_DESCR_NCOB = NULL, RECIBO_STATUS_NCOB = NULL, RES_RESPONSIBLE_NCOB = NULL, RES_BARCOD_NCOB = NULL, RES_RA_NCOB = NULL, RES_FATURA_NCOB = NULL, RES_VL_PARC_JUROS_NCOB = NULL, RES_VL_PARC_ORIG_NCOB = NULL, RES_VL_PARC_TOTAL_NCOB = NULL, RECIBO_DTHR_END_NCOB = NULL, RECIBO_STATUS_NCOB = NULL WHERE RECIBO_STATUS_NCOB in (-11) and TIMESTAMPDIFF(HOUR, RECIBO_DTHR_UPDAT_NCOB, now()) >= 1 and TIMESTAMPDIFF(HOUR, RECIBO_DTHR_UPDAT_NCOB, now()) < 32"
$adRS = $adCN.Execute($strSQL)
; Get Newer Row
$strSQL = "UPDATE db_name.tb_table SET CPU_REMOTE = '" & $input_IP & "', RECIBO_STATUS_NCOB = 1, RECIBO_DESCR_NCOB='Start', RECIBO_DTHR_START_NCOB = NOW(), RECIBO_DTHR_UPDAT_NCOB = NOW(), RES_LOGFILE = '" & $input_FILE & "', attemps=attemps+1 WHERE CPU_REMOTE is null and @tmp_id := ID_NCOB order by ID_NCOB ASC LIMIT 1"
$adRS = $adCN.Execute($strSQL)
$strSQL = "SELECT @tmp_id as NCOB_ID"
$adRS = $adCN.Execute($strSQL)
If $adRS.BOF = -1 And $adRS.EOF = -1 Then
   $adRS.close()
   $adCN.close()
   UpdateProgress('Não ha dados - VAZIO')
   ConsoleLog("Não ha dados - VAZIO")
   IEreplaceWait(1)
   Exit
EndIf
$input_NCOB_ID = $adRS.Fields('NCOB_ID').Value ; Set Id ID_NCOB
If StringLen($input_NCOB_ID)<1 Then ; Trabalhando no Vazio
   $adRS.close()
   $adCN.close()
   UpdateProgress('NAO HA ID_NOCB PARA EMULAR, VAZIO!!!')
   IEreplaceWait(1)
   Exit
EndIf
$strSQL = "SELECT DATE_FORMAT(DT_NCOB, '%d-%m-%Y') as DT_NCOB_DT, A.* FROM db_name.tb_table A WHERE ID_NCOB = " & $input_NCOB_ID & " LIMIT 1"
$adRS = $adCN.Execute($strSQL)
If $adRS.BOF = -1 And $adRS.EOF = -1 Then
   $adRS.close()
   $adCN.close()
   UpdateProgress('Não ha dados de negociacao - VAZIO')
   ConsoleLog("Não ha dados de negociacao")
   IEreplaceWait(1)
   Exit
EndIf
; GET VALUES FROM SQL
$input_NEGOCIACAO_DT = $adRS.Fields('DT_NCOB_DT').Value
$input_CPF = $adRS.Fields('CPF_NCOB').Value