#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance force
#MaxThreadsPerHotkey 2

ProcessIdentifier := "ahk_exe helldivers.exe"
CrosshairId := ""

MainLabel:
    CrosshairPath := "crosshair.png"

    If (FileExist(CrosshairPath)) {
        GenerateCrosshair(CrosshairPath)
        SetTimer, UpdateCrosshair, 10
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

UpdateCrosshair:
    global CrosshairId

    If (WinActive(ProcessIdentifier)) {
        If (WinVisible("ahk_id " . CrosshairId) == 0) {
            WinShow, ahk_id %CrosshairId%
            WinActivate, %ProcessIdentifier%
        }

        MouseGetPos, MousePosX, MousePosY
        MousePosX := MousePosX - 32
        MousePosY := MousePosY - 32
        WinMove, ahk_id %CrosshairId%, , MousePosX, MousePosY
    }
    Else {
        WinHide, ahk_id %CrosshairId%
    }
Return

; https://autohotkey.com/board/topic/1555-determine-if-a-window-is-visible/?p=545045
WinVisible(WinTitle) {
    WinGet, Style, Style, %WinTitle%
    Transform, Result, BitAnd, %Style%, 0x10000000 ; 0x10000000 is WS_VISIBLE.
    if Result <> 0 ;Window is Visible
        Return 1
    Else  ;Window is Hidden
        Return 0
}

GuiClose:
    ExitApp
Return
