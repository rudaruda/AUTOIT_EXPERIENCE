HotKeySet("{ESC}", "_exit")
InfiniteCircleMouse()
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