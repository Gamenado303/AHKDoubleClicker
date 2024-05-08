#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
SendMode Input
SetTitleMatchMode, 2

; Alt is !, windows key is #, Shift is + and Control is ^2d
gui, font, s10
gui, Add, Text, x10 y5,Auto Clicker
gui, Add, Text, x70 y28,Threshold
Gui, Add, Edit, x10 y25 w50 number vthreshold,
gui, Add, Text, x70 y58,Percentage
Gui, Add, Edit, x10 y55 w50 number vpercent,
gui, Add, Text, x10 y90,Alt F to toggle left click
gui, Add, Text, x10 y+0,Alt G to toggle right click
gui, Add, Text, x10 y+0,Ctrl N to start
gui, Add, Text, x10 y+0,Ctrl E to end

gui, Color, AFAFAF
gui, Show, w200 h160, Clicker
left := 1
right := 1

recency := 16
Lclicks := []
Rclicks := []

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
				if (Lclicks.Count() = recency) {
					Lclicks.RemoveAt(1)
				}
				if (A_Now - Lclicks[-1] > 3) {
					Lclicks := []
				}
				Lclicks.Push(A_Now)
				seconds := A_now - Lclicks[1]
				cps := Max(1, Round(Lclicks.Count() / seconds))
				if (cps >= threshold) {
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
	}
	if (right = 1) {
		if (GetKeyState("RButton") = 1) {
			Sleep, 5
			if (GetKeyState("RButton") = 0) {
				if (Rclicks.Count() = recency) {
					Rclicks.RemoveAt(1)
				}
				if (A_Now - Rclicks[-1] > 3) {
					Rclicks := []
				}
				Rclicks.Push(A_Now)
				seconds := A_now - Rclicks[1]
				cps := Rclicks.Count() / seconds
				if (cps >= threshold) {
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
}
return
