#NoEnv  ; Рекомендуется для совместимости с будущими версиями
SetWorkingDir %A_ScriptDir%  ; Обеспечивает консистентность при запуске скрипта
SendMode Input  ; Рекомендуется для новых скриптов
SetBatchLines -1  ; Увеличивает скорость выполнения скрипта

; Группировка браузеров
GroupAdd, browser, ahk_exe firefox.exe
GroupAdd, browser, ahk_exe chrome.exe
GroupAdd, browser, ahk_exe opera.exe
GroupAdd, browser, ahk_exe edge.exe

; Горячие клавиши для управления скриптом
~+!x::ExitApp  ; Shift+Alt+X для выхода
~!+r::Reload   ; Alt+Shift+R для перезагрузки

; Поиск выделенного текста в Google (Shift+Alt+S)
~!+s::
    OldClipboard := ClipboardAll  ; Сохраняем содержимое буфера обмена
    Clipboard := ""
    Send ^c
    ClipWait, 1
    if ErrorLevel
        return
    
    if WinExist("ahk_group browser") {
        WinActivate
        Send ^t
        Sleep, 100
        Send ^v
        Send {Enter}
    }
    else {
        Run, "C:\Program Files\Google\Chrome\Application\chrome.exe"
        WinWaitActive, ahk_exe chrome.exe,, 5  ; Увеличено время ожидания
        if ErrorLevel
            return
        Sleep, 500
        Send ^v
        Send {Enter}
    }
    
    ; Восстанавливаем оригинальный буфер обмена
    Sleep, 200
    Clipboard := OldClipboard
    OldClipboard := ""
return

; Перевод выделенного текста в Яндекс (Shift+Alt+A)
~!+a::
    link := "https://translate.yandex.ru/?source_lang=auto&target_lang=ru&text=" 
    OldClipboard := ClipboardAll  ; Сохраняем содержимое буфера обмена
    Clipboard := ""
    Send ^c
    ClipWait, 1
    if ErrorLevel
        return
    
    if WinExist("ahk_group browser") {
        WinActivate
        Send ^t
        Sleep, 100 
        SendInput %link%
        Send ^v
        Send {Enter}
    }
    else {
        chrome := "C:\Program Files\Google\Chrome\Application\chrome.exe"
        Run, %chrome% "%link%%Clipboard%"  ; Напрямую открываем ссылку с текстом
        WinWaitActive, ahk_exe chrome.exe,, 5
        if ErrorLevel
            return
    }
    
    ; Восстанавливаем оригинальный буфер обмена
    Sleep, 200
    Clipboard := OldClipboard
    OldClipboard := ""
return

; Копирование/вставка с использованием средней кнопки мыши + Volume_Up/Volume_down
$MButton::
    KeyWait, MButton, T0.2
    if ErrorLevel {
        ; Длительное нажатие, комбинация с другими клавишами будет обработана ниже
    }
    else {
        Click Middle  ; Обычный клик средней кнопкой
    }
return

MButton & Volume_Up:: 
    SendInput ^c
return

MButton & Volume_Down:: 
    SendInput ^v
return

; Горячие клавиши для мыши в браузерах
#IfWinActive ahk_group browser
    ; Правая кнопка мыши с колесиком для переключения вкладок
    $RButton::
        KeyWait, RButton, T0.2
        if ErrorLevel {
            ; Длительное нажатие, подготовка к комбинации с другими клавишами
        }
        else {
            Click Right  ; Обычный правый клик
        }
    return
    
    RButton & WheelUp:: 
        SendInput ^{PgDn}  ;  PgDn для перехода к предыдущей вкладке
    return
    
    RButton & WheelDown:: 
        SendInput ^{PgUp}  ;  PgUp для перехода к следующей вкладке
    return
    
    ; Средняя кнопка мыши с колесиком для перемещения в начало/конец страницы
    ~MButton & WheelUp:: 
        SendInput {MButton up} ^{Home}
    return
    
    ~MButton & WheelDown:: 
        SendInput {MButton up} ^{End}
    return
    
    ; Левая кнопка мыши с колесиком для прокрутки страницы
    ~LButton & WheelDown:: 
        SendInput {LButton up} {PgDn}
    return
    
    ~LButton & WheelUp:: 
        SendInput {PgUp}
    return
    
    ; Комбинации кнопок мыши
    LButton & RButton:: 
        Send ^w  ; Закрыть вкладку
    return
    
    RButton & LButton:: 
        Send ^+{Click}  ; Открыть ссылку в новой вкладке и перейти к ней
    return
    
    RButton & MButton:: 
        Send ^{F5}  ; Обновить страницу, игнорируя кэш
    return
    
    LButton & MButton:: ; Alt+S хоткей для перевода (нужно расширение)
		SendInput !s
    return
	
	MButton & LButton:: ; Alt+T хоткей для перевода страницы (нужно расширение)
		SendInput !t
    return
    
    ; Навигация с помощью регуляторов громкости
    RButton & Volume_Up:: 
        SendInput {Browser_Forward}
    return
    
    RButton & Volume_Down:: 
        SendInput {Browser_Back}
    return
#IfWinActive
