#NoEnv
SendMode Input

GroupAdd, browser, ahk_exe firefox.exe
GroupAdd, browser, ahk_exe chrome.exe
GroupAdd, browser, ahk_exe opera.exe

#IfWinActive, ahk_group browser

	$rbutton::
	keywait, rbutton, t0.2
	if (errorlevel)
	{
		rbutton & wheelup:: sendinput ^{pgdn}	
		rbutton & wheeldown:: sendinput ^{pgup}
	}
	else
	{
		click right
	}

	
	lbutton & Volume_Up:: 	sendinput ^{home}
	lbutton & Volume_down:: sendinput ^{end} 
	~lbutton & wheelup:: 	 sendinput  {right} 
	~lbutton & wheeldown:: 	 sendinput  {left} 
	Volume_Up & wheelup:: 	 sendinput  {pgup} 
	Volume_Up & wheeldown:: 	 sendinput  {pgdn}
	lbutton & rbutton:: send ^w 
	rbutton & lbutton:: send ^+{click} 
	rbutton & mbutton:: send ^{F5} 
	lbutton & mbutton:: send ^v {enter} 
	rbutton & Volume_Up:: sendinput {Browser_Forward} 
	rbutton & Volume_down:: sendinput {Browser_Back}
	Media_Stop & Volume_down:: send ^#{left} 
	Media_Stop & Volume_up:: send ^#{right}

#ifWinActive, ahk_exe notepad++.exe

	$rbutton::
	keywait, rbutton, t0.2
	if errorlevel
	{
		rbutton & wheelup:: sendinput ^{pgdn}
		rbutton & wheeldown:: sendinput ^{pgup}
		
	}
	else
	{	
		click right
	}
	
	lbutton & Volume_Up:: 	sendinput ^{home} 
	lbutton & Volume_down:: sendinput ^{end} 
	lbutton & wheelup:: sendinput {pgup}
	lbutton & wheeldown:: sendinput {pgdn}
	lbutton & rbutton:: send ^w
	rbutton & mbutton:: send ^n
	mbutton & rbutton:: send ^w
	rbutton & Volume_Up:: send ^y
	rbutton & Volume_down:: send ^z
return	
