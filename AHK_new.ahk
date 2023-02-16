#NoEnv
SendMode Input

GroupAdd, browser, ahk_exe firefox.exe
GroupAdd, browser, ahk_exe chrome.exe
GroupAdd, browser, ahk_exe opera.exe

;reload and exit this script
~+!x::ExitApp
~!+r::Reload

;Double-click on the middle mouse button to switch Scroll Lock (Scroll Lock is responsible for switching mouse modes)
#UseHook, On
mbutton:: Gosub, PressCount
mbutton(1):
	Click Down middle
	KeyWait, mbutton
	Click Up middle
	if GetKeyState("ScrollLock", "T") = 0
	{
		ToolTip, Copy.
	}	
	else
	{
		ToolTip, New table.
	}
	Sleep, 1000
	ToolTip
return
mbutton(2):
	if GetKeyState("ScrollLock", "T") = 0 
	ToolTip, New table.
	if GetKeyState("ScrollLock", "T") = 1 
	ToolTip, Copy.
	Send {ScrollLock}
	Sleep, 1000
	ToolTip
return
#UseHook, Off
PressCount:
	Pause_=350
	if not Second
	{
		Second=1
		SetTimer, DoublePress, -%Pause_%
	}
	else
	{
		Second=0
		SetTimer, %A_ThisHotkey%(2), -1
	}
return
DoublePress:
	if not Second
		return
	Second=0
	SetTimer, %A_ThisHotkey%(1), -1
return

;Search in Google selected text (Shift+LAlt+S)
~!+s::
	clipboard := "Select the text!"
	Send ^c
	ClipWait, 1
	if WinExist("ahk_group chrome") {
	WinActivate
	Send ^t
	Send ^v
	Send {Enter}
	}
	else {
	Run, "C:\Program Files\Google\Chrome\Application\chrome.exe"
	WinWaitActive, New Tab - Google Chrome, , 2
	Send ^v
	Send {Enter}
	}
return

;Translate selected text in Yandex (Shift+LAlt+A)
~!+a::
	link := "https://translate.yandex.ru/?source_lang=en&target_lang=ru&text="
	clipboard := ""
	Send ^c
	ClipWait, 1
	if WinExist("ahk_group chrome") {
	WinActivate	
	Send ^t
	Send %link%
	Send ^v
	Send {Enter}
	}
	else {
	param := "https://translate.yandex.ru/"
	chrome := "C:\Program Files\Google\Chrome\Application\chrome.exe"
	Run, %chrome% %param%
	WinWaitActive, , , 3
	Send ^v
	Send {Enter}
	}
return

;Hotkey for mouse in browser
#ifWinActive, ahk_group browser
	$rbutton::
	keywait, rbutton, t0.2
	if errorlevel
	{
		rbutton & wheelup:: SendInput ^{pgdn}
		return
		rbutton & wheeldown:: SendInput ^{pgup}
		return
	}
	else
	{
		click right
	}
	return

	lbutton & Volume_Up:: 	SendInput ^{home}
	lbutton & Volume_down:: SendInput ^{end}
	~lbutton & wheelup:: 	 SendInput  {pgup}
	~lbutton & wheeldown:: 	 SendInput  {pgdn}
	lbutton & rbutton:: Send ^w
	rbutton & lbutton:: Send ^+{click}
	rbutton & mbutton:: Send ^{F5}
	lbutton & mbutton:: Send ^v {enter}
	rbutton & Volume_Up:: SendInput {Browser_Forward}
	rbutton & Volume_down:: SendInput {Browser_Back}
	Media_Stop & Volume_down:: Send ^#{left}
	Media_Stop & Volume_up:: Send ^#{right}
return

;Hotkey for mouse in Notepad++
#ifWinActive, ahk_exe notepad++.exe
	$rbutton::
	keywait, rbutton, t0.2
	if errorlevel
	{
		rbutton & wheelup:: SendInput ^{pgdn}
		return
		rbutton & wheeldown:: SendInput ^{pgup}
		return
	}
	else
	{
		click right
	}
	return
	lbutton & Volume_Up:: 	SendInput ^{home}
	lbutton & Volume_down:: SendInput ^{end}
	lbutton & wheelup:: SendInput {pgup}
	lbutton & wheeldown:: SendInput {pgdn}
	lbutton & rbutton:: Send ^w
	rbutton & mbutton:: Send ^n
	mbutton & rbutton:: Send ^w
	rbutton & Volume_Up:: Send ^y
	rbutton & Volume_down:: Send ^z
return
