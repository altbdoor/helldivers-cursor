#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance force
#MaxThreadsPerHotkey 2

ProcessIdentifier := "ahk_exe helldivers.exe"
CrosshairId := ""
MouseHook := ""

MainLabel:
    CrosshairPath := "crosshair.png"

    If (FileExist(CrosshairPath)) {
        GenerateCrosshair(CrosshairPath)
        MouseHook := SetWindowsHookEx(14, RegisterCallback("UpdateCrosshair"))
    }
    Else {
        MsgBox, 0x10, Crosshair File Not Found, Please ensure that there is an image file named "%CrosshairPath%" in the same path as the script!
    }
Return

GenerateCrosshair(CrosshairPath) {
    global CrosshairId

    Gui, New, +E0x20 -Caption +LastFound +ToolWindow +AlwaysOnTop -DPIScale
    Gui, Color, FFFFFF
    WinSet, TransColor, FFFFFF
    Gui, Margin, 0, 0

    Gui, Add, Picture, w64 h64 +BackgroundTrans, %CrosshairPath%
    Gui, Show, w64 h64 x-64 y-64

    CrosshairId := WinExist()
    WinHide, ahk_id %CrosshairId%
    SetWinDelay, 0
    CoordMode, Mouse, Screen
}

UpdateCrosshair(nCode, wParam, lParam) {
    global ProcessIdentifier, CrosshairId

    If (WinActive(ProcessIdentifier) && nCode >= 0) {
        If (WinVisible("ahk_id " . CrosshairId) == 0) {
            WinShow, ahk_id %CrosshairId%
            WinActivate, %ProcessIdentifier%
        }

        MousePosX := NumGet(lParam + 0, 0, "Int")
        MousePosY := NumGet(lParam + 0, 4, "Int")
        MousePosX := MousePosX - 32
        MousePosY := MousePosY - 32
        WinMove, ahk_id %CrosshairId%, , MousePosX, MousePosY
    }
    Else {
        WinHide, ahk_id %CrosshairId%
    }

    Return CallNextHookEx(nCode, wParam, lParam)
}

; https://autohotkey.com/board/topic/1555-determine-if-a-window-is-visible/?p=545045
WinVisible(WinTitle) {
    WinGet, Style, Style, %WinTitle%
    Transform, Result, BitAnd, %Style%, 0x10000000 ; 0x10000000 is WS_VISIBLE.
    if Result <> 0 ;Window is Visible
        Return 1
    Else  ;Window is Hidden
        Return 0
}

; https://www.autohotkey.com/boards/viewtopic.php?p=75116#p75116
SetWindowsHookEx(idHook, pfn) {
    Return DllCall("SetWindowsHookEx", "int", idHook, "Ptr", pfn, "Ptr", DllCall("GetModuleHandle", "Ptr", 0, "Ptr"), "UInt", 0)
}
CallNextHookEx(nCode, wParam, lParam, hHook = 0) {
    Return DllCall("CallNextHookEx", "Ptr", hHook, "int", nCode, "Ptr", wParam, "Ptr", lParam)
}
UnhookWindowsHookEx(hHook) {
    Return DllCall("UnhookWindowsHookEx", "Ptr", hHook)
}

GuiClose:
    UnhookWindowsHookEx(MouseHook)
    ExitApp
Return
