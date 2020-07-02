#include <AutoItConstants.au3>
DisplayAllMessages()
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