GroupAdd, browser, ahk_exe firefox.exe
GroupAdd, browser, ahk_exe chrome.exe

#IfWinActive, ahk_group browser
{
	$rbutton::
	keywait, rbutton, t0.2
	if errorlevel
	{
		rbutton & wheelup:: sendinput ^{pgdn}
		return
	
		rbutton & wheeldown:: sendinput ^{pgup}
		return
	}
	click right
	return

	~lbutton & wheelup:: sendinput {pgup}
	~lbutton & wheeldown:: sendinput {pgdn}
	~lbutton & rbutton:: send ^w
	rbutton & lbutton:: send ^+{click}
	rbutton & mbutton:: send ^r
	lbutton & mbutton:: send ^t
	rbutton & Volume_down:: sendinput {Browser_Back} 
	rbutton & Volume_Up:: sendinput {Browser_Forward}
	lbutton & Volume_Up:: send ^{home}
	lbutton & Volume_down:: send ^{end}
	return
}

#ifWinActive, ahk_exe notepad++.exe
{
	$rbutton::
	keywait, rbutton, t0.2
	if errorlevel
	{
		rbutton & wheelup:: sendinput ^{pgdn}
		return
		
		rbutton & wheeldown:: sendinput ^{pgup}
		return
	}
	click right
	return
	
	lbutton & wheelup:: sendinput {pgup}
	lbutton & wheeldown:: sendinput {pgdn}
	lbutton & rbutton:: send ^w 
	rbutton & mbutton:: send ^n
	mbutton & rbutton:: send ^s
	rbutton & Volume_Up:: send ^y
	rbutton & Volume_down:: send ^z
	lbutton & Volume_Up:: send ^{home}
	lbutton & Volume_down:: send ^{end}
	return
}
