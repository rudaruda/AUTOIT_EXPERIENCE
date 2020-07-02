HotKeySet("{ESC}", "_exit")
#include <Array.au3>
ListAllWindows()
Func ListAllWindows()
    Local $aWinList = WinList("[REGEXPTITLE:(?i)([a-zA-Z].*)]")
    _ArrayDisplay($aWinList)
 EndFunc

Exit

















; IF
Local $var = 0
If $var = 1 Then
   ; Your commands HERE
Else
   ; Or then HERE
EndIf

; WHILE
Local $var = 0
While $var < 10
   ; Your commands HERE AGAIN
   $var += 1
   ConsoleWrite($var & " - ")
WEnd

; FOR
For $var = 0 to 10 Step 2
   ; Your commands HERE RELOAD
   $var += 1
   If $var < 5 Then ContinueLoop
   If $var = 8 Then ExitLoop
Next

; FUNCTION
Func SumMoreOne($value)
   If StringLen($value)=0 or _
	  Not IsNumber($value) _
	  Then Return Null
   Return ($value+1)
EndFunc

#include <Date.au3>
ConsoleWrite(_NowDate()&@CRLF) ; prints: 01/07/2020
ConsoleWrite(_NowTime()&@CRLF) ; prints: 14:07:45

#include <Array.au3>
Local $arrayData[1] = ["Data"]
;_ArrayDisplay($arrayData)


HotKeySet("{ESC}", "_exit")
;InfiniteCircleMouse()
Func InfiniteCircleMouse()
   Local $cX = @DesktopWidth / 2, $cY = @DesktopHeight / 2
   Local $rD = 150, $i = 0
   While 1
	   MouseMove($cX + ($rD * Cos($i)), $cY + ($rD * Sin($i)),1)
	   $i += 0.03
	   Sleep(5)
	WEnd
 EndFunc
Func _exit()
    Exit
EndFunc

#include <Array.au3>
;AutoNotepad()
Func AutoNotepad()
   Run("notepad.exe")
   Local $hWnd = WinGetHandle("[CLASS:Notepad]","")
   WinWaitActive("[CLASS:Notepad]")
   Send("Algum texto aqui...{ENTER}{TAB}")
   Sleep(1000)
   Send("Novamente... ")
   Opt("SendKeyDelay", 50)
   Send("Algum texto aqui...")
   Sleep(1000)
   Opt("SendKeyDelay", 100)
   Send("{BS 20}")
   Sleep(1000)
   Send("^n")
   Sleep(500)
   $hWnd = WinGetHandle("[CLASS:#32770]")
   Local $aPos = WinGetPos($hWnd)
   Local $bPos = ControlGetPos($hWnd, "", "[CLASS:Button; INSTANCE:3]")
   MouseMove($aPos[0]+$bPos[0]+$bPos[2]/2,$aPos[1]+$bPos[1]+$bPos[3]/2+30)
EndFunc

;DisplayAllMessages()
Func DisplayAllMessages()
   MsgBox(0,"ATENÇÃO","Click em OK para COMEÇAR!")
   ProgressOn("Checking ...", "ProgressOn", "0 %", -1, -1, 16)
   TrayTip( "TrayTip", "Checking...", -1, 1)
   SplashTextOn("Check...", "SplashTextOn", -1, -1, 0, 0, $DLG_TEXTLEFT, "", 24)
   Local $sMessage = ""
   For $p = 0 to 100 Step 20
	  ProgressSet($p, $p & " %")
	  ;TraySetToolTip("10 %")
	  ;TraySetToolTip("An example of a tray menu tooltip.")
	  $sMessage = $sMessage & "Information with text: " & $p & @CRLF
	  ControlSetText("Check...", "", "Static1", $sMessage)
	  Sleep(1000)
   Next
   Sleep(1000)
   ProgressOff()
   SplashOff()
EndFunc


; 4286f4
; 4b8bf5
; $oIE.document.parentwindow.execScript('document.querySelector(".gLFyf.gsfi").value = "LULU MUITO MACHO"')
; $oIE.document.parentwindow.execScript('document.dispatchEvent(new KeyboardEvent("keydown", {key: "e"})');

;$oIE.document.parentwindow.execScript("document.querySelector('.gLFyf.gsfi').dispatchEvent(new KeyboardEvent('keypress',{'key':'a'}))")

;$result = $oIE.document.parentwindow.eval('var x = 9; x * 12;') ;execScript
;Local $oText = _IEGetObjByName($oIE, "q")
;$oText.text = "Teste"
;MemoryReadPixel



Exit


$sText = WinGetTitle("[ACTIVE]")



