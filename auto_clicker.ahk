#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
SendMode Input
SetTitleMatchMode, 2

; Alt is !, windows key is #, Shift is + and Control is ^2d
gui, font, s10
gui, Add, Text, x10 y5,Auto Clicker
gui, Add, Text, x70 y30,Percentage
Gui, Add, Edit, x10 y27 w50 number vpercent,
gui, Add, Text, x10 y60,Alt F to toggle left click
gui, Add, Text, x10 y+0,Alt G to toggle right click
gui, Add, Text, x10 y+0,Ctrl N to start
gui, Add, Text, x10 y+0,Ctrl E to end

gui, Color, AFAFAF
gui, Show, w200 h130, Clicker
left := 1
right := 1

return

GuiClose:
ExitApp

^p::
Pause

^e::
ExitApp

!f::
left := 1 - left
return

!g::
right := 1 - right
return

^n::
gui, submit, nohide
while True {
	if (left = 1) {
		if (GetKeyState("Lbutton") = 1) {
			Sleep, 5
			if (GetKeyState("Lbutton") = 0) {
				temp = %percent%
				while temp >= 0	{
					Random, rand, 0, 100
					if (temp >= rand) {
						Click, Left
						Sleep, 5
					}
					temp -= 100
				}
			}
		}
	}
	if (right = 1) {
		if (GetKeyState("RButton") = 1) {
			Sleep, 5
			if (GetKeyState("RButton") = 0) {
				temp = %percent%
				while temp >= 0	{
					Random, rand, 0, 100
					if (temp >= rand) {
						Click, Right
						Sleep, 5
					}
					temp -= 100
				}
			}
		}
	}
}
return