#include <IE.au3>
#include <Array.au3>
#include <Date.au3>

If Not FileExists("C:\Repos\AUTOIT_EXPERIENCE\AutoIT_ImageSearch\_ImageSearch_Tool.au3") Then
   MsgBox(0,"ARQUIVO NÃO ENCONTRADO","ATENÇÃO" & @CRLF & "Arquivo não encontrado em:" & @CRLF & "C:\Repos\AUTOIT_EXPERIENCE\AutoIT_ImageSearch\_ImageSearch_Tool.au3" & @CRLF & @CRLF & "Verifique o arquivo.")
   Exit
EndIf

If Not FileExists("C:\Repos\AUTOIT_EXPERIENCE\AutoIT_ImageSearch\_ImageSearch_UDF.au3") Then
   MsgBox(0,"ARQUIVO NÃO ENCONTRADO","ATENÇÃO" & @CRLF & "Arquivo não encontrado em:" & @CRLF & "C:\Repos\AUTOIT_EXPERIENCE\AutoIT_ImageSearch\_ImageSearch_UDF.au3" & @CRLF & @CRLF & "Verifique o arquivo.")
   Exit
EndIf

; !IMPORTANTE!!!! Os aquivos do projetos devem estar CONTIDO nessa pasta
#include "C:\Repos\AUTOIT_EXPERIENCE\AutoIT_ImageSearch\_ImageSearch_Tool.au3"
#include "C:\Repos\AUTOIT_EXPERIENCE\AutoIT_ImageSearch\_ImageSearch_UDF.au3"
Global $iBegin = TimerInit()

AdlibRegister("", 1000) ; every second
Func _WriteLogSecond()
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": still continue" &@CRLF)
EndFunc

HotKeySet("{ESC}","_Quit") ;Press ESC key to quit
Func _Quit()
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": EXIT PROGRAM by ESC" & @CRLF)
   Exit
EndFunc

HotKeySet("{F1}","_F1") ;Press ESC key to quit
Func _F1()
   MsgBox(0,"F1 foi precionado","ATENÇÃO!"& @CRLF& @CRLF &"Você acabou de pressionar a tecla F1." & @CRLF & @CRLF & "Por favor," & @CRLF & "...deixe o robô... fazer o trabalho dele")
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": F1 foi precionado" & @CRLF)
EndFunc

AutoIeImage()
Func AutoIeImage()
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": NEW EXECUTION" & @CRLF)
   IETest("LULU MUITO MACHO")
   ReturnFindColor(0xE89E10,"Laranja")
   ReturnFindColor(0xD08A4C,"Marrom")
   FindImage('IMG_BMP_0')
   FileWrite(@ScriptDir & "\logs.txt", "FINISH EXECUTION, " TimerDiff($iBegin) & " seconds" & @CRLF)
EndFunc
Func IETest($sText)
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": Start IETest('" &$sText& "')" & @CRLF)
   Local $oIE = _IECreate('google.com')
   _IELoadWait($oIE)
   Local $oSb = _IEGetObjByName($oIE, "q")
   _IEFormElementSetValue($oSb, $sText)
   Local $hWnd = _IEPropertyGet($oIE, "hwnd")
   ControlSend($hWnd, "", "", "{ENTER}")
   _IELoadWait($oIE)
   Sleep(500)
   $oIE.document.parentwindow.execScript('document.querySelector(".q.qs").click()')
   WinSetState($hWnd, "", @SW_MAXIMIZE)
   Sleep(1500)
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": Finish IETest()" & @CRLF)
EndFunc
Func ReturnFindColor($xColor,$NameColor)
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": Start ReturnFindColor('" & $xColor & "','" & $NameColor & "')" & @CRLF)
   Opt("MouseCoordMode", 1) ;1=absolute, 0=relative, 2=client
   Opt("PixelCoordMode", 1) ;1=absolute, 0=relative, 2=client
   Local $aCoord = PixelSearch(0, 0, @DesktopWidth, @DesktopHeight, $xColor,1) ;PixelSearch(0, 0, 20, 300, 0xFF0000)
   If Not @error Then
	  TrayTip( "Find Color :-)", $NameColor & " Hex(" & $xColor & ") in [" & $aCoord[0] & "," & $aCoord[1]& "]"  , -1, 1)
	  MouseMove($aCoord[0]*0.785, $aCoord[1]*0.78)
	  MsgBox(0,"Found color","'"&$NameColor&"'" & @CRLF & "...OK to Next...")
	  Sleep(2500)
	  Return $aCoord
   Else
	  TrayTip( "Not found Color!", $NameColor & " Hex(" & $xColor & ") ... not found"  , -1, 1)
	  Sleep(2500)
	  Return Null
   EndIf
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": Finish ReturnFindColor()" & @CRLF)
EndFunc
Func FindImage($imgFile)
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": Start FindImage('" & $imgFile & "')" & @CRLF)
   Local $_Image_1, $result_img
   For $x = 1 to 8
	  $_Image_1 = @ScriptDir&'\' & $imgFile & $x & '.BMP'
	  $result_img = _ImageSearch($_Image_1)
	  If $result_img[0] = 1 Then
		 TrayTip( "Imagem encontrada :-)", "Pequeno  Principe (*" & $x & ") in [" & $result_img[1] & "," & $result_img[2]& "]"  , -1, 1)
		 MouseMove($result_img[1]*.785,$result_img[2]*0.78)
		 ToolTip("Dê um OI para o Principe",$result_img[1]*.785-69,$result_img[2]*0.78-32,"Que sorte!")
		 Sleep(4000)
		 Return
	  EndIf
   Next
   TrayTip( "Imagem NÃO encontrada :-(", "Faça o cadastro de maix imagens", -1, 1)
   FileWrite(@ScriptDir & "\logs.txt", _Now() & ": Finish FindImage()" & @CRLF)
   Sleep(5000)
EndFunc