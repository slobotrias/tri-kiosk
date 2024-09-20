; AutoHotkey script to disable all keys except letters, numbers, and specific punctuation

#Persistent
SetTitleMatchMode, 2
SetTimer, WatchKeys, 100

; Disable Taskbar with AutoHotkey (Fully Transparent)
Gui +ToolWindow +AlwaysOnTop -Caption +LastFound
Gui, Color, FFFFFF  ; Set background to white (or any color), it will be invisible
WinSet, Transparent, 0  ; Make the window fully transparent (0% visibility)
Gui, Show, x0 y1000 w%A_ScreenWidth% h30
WinHide, ahk_class Shell_TrayWnd  ; Hide the taskbar


; Disable Windows key and other common keys
LWin::Return  ; Disable Left Windows key
RWin::Return  ; Disable Right Windows key
!Tab::Return  ; Disable Alt + Tab
!Esc::Return  ; Disable Alt + Esc
^Esc::Return  ; Disable Ctrl + Esc
^Tab::Return  ; Disable Ctrl + Tab

; Allow directional keys
Up::Return
Down::Return
Left::Return
Right::Return

WatchKeys:
    ; Disable all other keys
    Key := GetKeyState("VK")
    If (InStr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789`~!@#$%^&*()-_=+[]{};':"",<.>/?", GetKeyName(Key))) {
        ; Do nothing, allow the key
        Return
    }
    ; Block all other keys
    Send, {Blind}{Key down}{Key up}
return
