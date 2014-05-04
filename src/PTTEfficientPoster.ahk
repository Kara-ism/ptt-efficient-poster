; Var:
;        Str_Article
;        Var_Control
;        Var_WinTitle
        Str_Version := "Version 1.8"
        Authorial := "�i�RҲ"
        Date := "Tuesday, November 6th, 2007"
;        Status_ESC_R := "r"

; Procedure:
;        ^F11
;        ^F12

; Function:
;        F_SendByWmImeChar

#SingleInstance IGNORE
SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.

; Tray
    Menu, Tray, NoStandard
    Menu, Tray, Click, 1 ; Specify 1 for ClickCount to allow a single-click to activate the tray menu's default menu item.
    Menu, Tray, Add, ��ܥD����, Gui_Show_Hide
    Menu, Tray, Add, �Ȱ� ( Shift + F11 ), Label_Tray_Pause
    Menu, Tray, Add, ���s���J ( Shift + F12 ), Label_Tray_Reload
    Menu, Tray, Add, ���}, Label_Tray_Exit
    Menu, Tray, Default, ��ܥD����

    TrayTip, , PTT Efficient Poster, 1, 1
    SetTimer, Label_Remove_TrayTip, 1500

; GUI ����

;    Gui, Add, Button, w74 h46 gP_Start, Start
;    Gui, Add, Button, x+6 w74 h46 gP_Stop, Stop
;    GuiControl, Disable, Stop

    Gui, Font, s18 Bold, Courier ; Consolas
    Gui, Add, Text, vMyText1, PTT Efficient Poster
    Gui, Font, s12 norm, �ө���
    Gui, Add, Edit, HwndMyEditHwnd r19 w580 ReadOnly vMyEdit, �� �n�餶��`n`nPTT Efficient Poster �O�@�䬰�F���ϥΪ̦b PTT �o��峹��A��o��X�z���Z�S�ӽϥͪ��{���C�]�� PTT �p��Z�S���覡�A���{���|�����r���@��A�N�ŶKï�����峹�A�b�I���۰ʡB�v�r�K�� PTT ���C`n`n`n�� �n��S��`n`n�E�䴩 BBS ����X�C`n�E�䴩������Φr�]�@�r����^�C`n�E�䴩 Big-5 �X�R�r���]�䴩 Unicode �ɧ��p�e�������r�^�C`n�E�䴩�I���K��C`n�E�䴩�{�ɼȰ��K��C`n�E�䴩 Windows 2000/XP/Vista/7 (x86 & x64)�C`n`n`n�� �ϥΫe�ǳ�`n`n�E�ק� PTT ���x�]�w�p�U�G`n`n�@�@(U)ser         �i �ӤH�]�w�� �j`n�@�@�@(U)Customize    �ӤH�Ƴ]�w`n�@�@�@�@i. DBCS       �۰ʰ������줸�r��(�p��������)�@�@�@�@�G�O`n�@�@�@�@j. DBCS       �����s�u�{�������줸�r���e�X�����ƫ���G�O`n�@�@�@�@k. DBCS       �T��b���줸���ϥΦ�X(�h���@�r����)�@�G�_`n`n`n�� �ϥλ���`n`n�E�K���k�G`n`n�@1. �ƻs���i�K���峹���e��ŶKï�C`n�@�@�]�i�ۦ�b�O�ƥ������ƪ��n�A�ƻs�A�]�i�ƻs PCMan ���ت� ANSI �s�边�����m���r�C�^`n�@2. �i�J�o�媬�A�C`n�@3. ���U Shift + F10 �}�l�i�K�C`n�@4. �}�l�i�K��A�i�H������O����������L�ơA�߿W���i�H�b PCMan ���t�@�@ �}�s�����C`n`n�E�i�K������{���|�۰ʼu�X���ܵ����C`n�E���Ȱ��i�K�A�Ы� Shift + F11�C�b�u�@�C�ϥܪ���椤�����Ȱ��Y�i�~��K��C`n�E�������i�K�A�Ы� Shift + F12 ���s���J���{���A���������{���C

    Gui, Font, s10, �s�ө���
    Gui, Add, Statusbar,,�@���m
    SB_SetParts(200)
;    Gui, Add, Text,, Shift + F11 : �}�l�v�r�K��
;    Gui, Add, Text,, Shift + F12 : ����
    Gui, Add, Text, y+10, %Date% - %Str_Version% -
    Gui, Font, cBlue
    Gui, Add, Text, x+5 gLink1 vURL_Link1, %Authorial%
    Gui, Font, Norm


; for change gui edit background

    EditBackgroundColor := 0xFFFFFF  ; A custom color in BGR format.
    EditBackgroundBrush := DllCall("CreateSolidBrush", UInt, EditBackgroundColor)
    Gui +LastFound
    GuiHwnd := WinExist()
    WindowProcNew := RegisterCallback("WindowProc", ""  ; Specifies "" to avoid fast-mode for subclassing.
    , 4, MyEditHwnd)  ; Must specify exact ParamCount when EventInfo parameter is present.
    WindowProcOld := DllCall("SetWindowLong", UInt, GuiHwnd, Int, -4  ; -4 is GWL_WNDPROC
    , Int, WindowProcNew, UInt)  ; Return value must be set to UInt vs. Int.


    Gui, Show, Hide, PTT Efficient Poster
    Status_Gui := 0


  ; Retrieve scripts PID
  Process, Exist
  pid_this := ErrorLevel

  ; Retrieve unique ID number (HWND/handle)
  WinGet, hw_gui, ID, ahk_class AutoHotkeyGUI ahk_pid %pid_this%

  ; Call "HandleMessage" when script receives WM_SETCURSOR message
  WM_SETCURSOR = 0x20
  OnMessage(WM_SETCURSOR, "HandleMessage")

  ; Call "HandleMessage" when script receives WM_MOUSEMOVE message
  WM_MOUSEMOVE = 0x200
  OnMessage(WM_MOUSEMOVE, "HandleMessage")

Return


Link1:
    run http://changyuheng.github.io/
Return

GuiSize:
    if ErrorLevel = 1  ; The window has been minimized.  No action needed.
    {
        Sleep, 400
        Gui, Hide
        Menu, Tray, Rename, ���åD����, ��ܥD����
        Status_Gui := 0
    }
Return

GuiClose:
    MsgBox, 4,, �T�w���� PTT Efficient Poster�H
    ifMsgBox Yes
    {
        ExitApp
    }
Return

Label_Remove_TrayTip:
    TrayTip
Return

Label_Tray_Pause:
    if A_IsPaused = 1
    {
        Menu, Tray, UnCheck, �Ȱ� ( Shift + F11 )
    }
    else
    {
        Menu, Tray, Check, �Ȱ� ( Shift + F11 )
    }
    Pause
Return

Label_Tray_Reload:
    Reload
Return

Label_Tray_Exit:
    MsgBox, 4,, �T�w���� PTT Efficient Poster�H
    ifMsgBox Yes
    {
        ExitApp
    }
Return

Gui_Show_Hide:
    if Status_Gui = 1
    {
        Gui, Hide
        Menu, Tray, Rename, ���åD����, ��ܥD����
        Status_Gui := 0
    }
    else
    {
        Gui, Show
        ControlFocus,, ahk_id %GuiHwnd%
        SendMessage, 177, -1, 0,, %hMyTextBox% ; http://msdn.microsoft.com/en-gb/library/bb761661%28VS.85%29.aspx

        Menu, Tray, Rename, ��ܥD����, ���åD����
        Status_Gui := 1
    }
Return


+F10 Up::
    KeyWait, Shift, P
    F_Get_Control_and_ahk_ID()
    InputStr := Clipboard
    F_Get_AIPR_and_Tweak_It()
    Clipboard := InputStr

    F_SendByWmImeChar()
;    ControlSend, BBS_View1, %Str_Article%, PCMan
Return

+F11 Up::
    GoSub, Label_Tray_Pause
;    SB_SetText("�@���m")
Return

+F12 Up::
    Reload
Return

F_Get_Control_and_ahk_ID()
{
    Global
    ControlGetFocus, Var_Control, A
    WinGet, Var_WinTitle, ID, A
}


F_Get_AIPR_and_Tweak_It()
{
    Global
    Send, {Alt}
    KeyWait, Alt, L
    Send, {E}
    KeyWait, E, L
    Send, {A}
    KeyWait, A, L
    Sleep, 250
    Send, {Alt}
    KeyWait, Alt, L
    Send, {E}
    KeyWait, E, L
    Send, {C}
    KeyWait, C, L
    Sleep, 250
    Transform, Var_AIPR, Unicode
;    Var_AIPR := Clipboard
    Length_Var_AIPR := StrLen(Var_AIPR)
;    AA := *(&(Var_AIPR) + Length_Var_AIPR - 14)
;    MsgBox, %AA%
    if *(&(Var_AIPR) + Length_Var_AIPR - 14) = 65 ; 65 = A
    {
        SendMessage, 0x102, 8,, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x8 = backspace
;        MsgBox, Get
    }
    if *(&(Var_AIPR) + Length_Var_AIPR - 11) = 114 ; 114 = r
    {
        ; ESC-R �����۰ʰ������줸
        ; http://www.autohotkey.com/docs/misc/PostMessageList.htm
        PostMessage, 0x102, 0x1B,, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X102 = WM_CHAR ; 0x1B = ESC
        PostMessage, 0x102, 0x52,, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X102 = WM_CHAR ; 0x52 = R
    }
}

F_SendByWmImeChar()
{
    Global
;    InputStrPtr := &InputStr
;    Transform, OutputVar, Unicode
;    InputStr := Clipboard
    InputStrPtr := &InputStr
    i := StrLen(InputStr)
    j := 0
    k := 0
    CR := 0

    Loop,
    {
        if *InputStrPtr > 127
        {
            if *InputStrPtr != *(InputStrPtr+2)
            {
                k += 2
            }
            InputStrPtr += 2
            j+=2
        }
        else if *InputStrPtr > 0 and *InputStrPtr <= 127
        {
            if *InputStrPtr = 10 or *InputStrPtr = 13
            {
                CR ++
            }
            else if *InputStrPtr != *(InputStrPtr+1)
            {
                k ++
            }
            InputStrPtr ++
            j++
        }
        else if *InputStrPtr = 0 or i = j
        {
            break
        }
    }

    Minute := (k+CR) / 2 * 1.05 / 60
    Dollar := k * 0.25
    SetFormat, float, 0.2
    Minute += 0
    SetFormat, float, 0.0
    Dollar += 0
    SetFormat, float, 6.2
    SB_SetText("�@�����o��峹���� " . Minute . " ���A���i��o " . Dollar . " P�C", 2)

    InputStrPtr := &InputStr
;    InputStrPtr := &OutputVar
    j := 0

    Loop,
    {
        Random, Delay125, 100, 150
        Random, Delay525, 500, 550
        Random, Delay1050, 1000, 1100

        if *InputStrPtr > 127
        {
            if *(InputStrPtr+1) = 27
            {
                n := 0
                while *(InputStrPtr+n) != 109
                {
                    n := A_Index
                }
                OutputStr := ((*InputStrPtr << 8) | *(InputStrPtr+n+1))
                PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle%
                Sleep, %Delay1050%
                PostMessage, 0x100, 0x25, 0x00000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x100 = WM_KEYDOWN ; 0x25 = Left
                PostMessage, 0x101, 0x25, 0xC0000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X101 = WM_KEYUP
                Sleep, %Delay125%
                InputStrPtr := InputStrPtr + n + 2
                j := j + n + 2

                while n > 0
                {
                    if *(InputStrPtr-n-1) = 27 ; ESC
                    {
                        OutputStr := 3
                        PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x3 = ^c (only in pcman)
                        Sleep, %Delay1050%
                        PostMessage, 0x100, 0x25, 0x00000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x100 = WM_KEYDOWN
                                                                                                    ; 0x25 = Left
                        PostMessage, 0x101, 0x25, 0xC0000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X101 = WM_KEYUP
                        Sleep, %Delay125%
                    }
                    else if (*(InputStrPtr-n-1) != 91 and *(InputStrPtr-n-1) != 109) ; 91=[ 109= m
                    {
                        OutputStr := *(InputStrPtr-n-1)
                        PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle%
                        Sleep, %Delay525%
                    }
                    else if *(InputStrPtr-n-1) = 109
                    {
                        PostMessage, 0x100, 0x27, 0x00000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x27 = Right
                        PostMessage, 0x101, 0x27, 0xC0000000, %Var_Control%, ahk_ID %Var_WinTitle%
                        Sleep, %Delay525%
                    }
                    n --
                }
                PostMessage, 0x100, 0x27, 0x00000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x100 = WM_KEYDOWN ; 0x27 = Right
                PostMessage, 0x101, 0x27, 0xC0000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X101 = WM_KEYUP
            }
            else if *InputStrPtr != *(InputStrPtr+2)
            {
                Delay := 1050
                OutputStr := ((*InputStrPtr << 8) | *(InputStrPtr+1))
                InputStrPtr += 2
                j += 2
                PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x286 WM_IME_CHAR
            }
            else
            {
                Delay := 0
                OutputStr := ((*InputStrPtr << 8) | *(InputStrPtr+1))
                InputStrPtr += 2
                j += 2
                PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x286 WM_IME_CHAR
            }
        }
        else if *InputStrPtr > 0 and *InputStrPtr <= 127
        {
/*
            if *InputStrPtr = 10 or *InputStrPtr = 13 ; PCMan �n #13 �~�ഫ��C
            {
                OutputStr := 13
                InputStrPtr ++
                j++
                Delay := 525
                PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x286 WM_IME_CHAR
            }
*/
;            else if *InputStrPtr = 27
            if *InputStrPtr = 27
            {
                OutputStr := 3
                PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x3 = ^c (only in pcman)
                InputStrPtr ++
                j++
                Sleep, %Delay1050%
                PostMessage, 0x100, 0x25, 0x00000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x100 = WM_KEYDOWN ; 0x25 = Left
                PostMessage, 0x101, 0x25, 0xC0000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X101 = WM_KEYUP
                Random, Delay525, 500, 550
                Sleep, %Delay525%
                while *InputStrPtr != 109 ; 109 = m
                {
                    if *InputStrPtr = 91
                    {
                        InputStrPtr ++
                        j++
                    }
                    else
                    {
                    OutputStr := *InputStrPtr
                    PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x286 WM_IME_CHAR
                    InputStrPtr ++
                    j++
                    Random, Delay525, 500, 550
                    Sleep, %Delay525%
                    }
                }
                PostMessage, 0x100, 0x27, 0x00000000, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x27 = Right
                PostMessage, 0x101, 0x27, 0xC0000000, %Var_Control%, ahk_ID %Var_WinTitle%
                InputStrPtr ++
                j++
            }
            else
            {
                if *InputStrPtr != *(InputStrPtr+1)
                {
                    Delay := 525
                }
                else
                {
                    Delay := 0
                }
                OutputStr := *(InputStrPtr)
                InputStrPtr ++
                j++
                PostMessage, 0x286, OutputStr, 0, %Var_Control%, ahk_ID %Var_WinTitle% ; 0x286 WM_IME_CHAR
            }
        }
        else if ( j = i or  *InputStrPtr = 0 )
        {
            PostMessage, 0x102, 0x1B,, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X102 = WM_CHAR ; 0x1B = ESC
            PostMessage, 0x102, 0x52,, %Var_Control%, ahk_ID %Var_WinTitle% ; 0X102 = WM_CHAR ; 0x52 = R
            SB_SetText("�@���m")
            MsgBox, �����C
            break
        }

        p := j/i*100
        SetFormat, float, 0.2
        p += 0
        SetFormat, float, 6.2
        SB_SetText("�@�w���� " . p . " %", 1)

        if Delay = 1050
        {
            Sleep, %Delay1050%
        }
        else if Delay = 525
        {
            Sleep, %Delay525%
        }
    }

    return
}


/*
F_SendASC(String)
{
    Global
    i := StrLen(String)
    ControlGet, h1, hWnd,, �x�j�����~�{ - PCMan
    if i = 0
      return
    loop,
    {
        tmp1 := NumGet(String, 0, "UChar")
        if tmp1 < 128
        {
          i--
          StringTrimLeft, String, String, 1
            DllCall("PostMessage", %h1%, Word(%tmp1%), 0,)
        }
        else
        {
            tmp1 := ( tmp1 << 8) | NumGet(String, 1, "UChar")
            i-= 2
            StringTrimLeft, String, String, 2
            PostMessage, 0x286, %tmp1%, 0, , PCMan
        }



        WinActivate, PCMan
        Send, {ASC %tmp1%}

;        ControlSend, BBS_View1, {ASC %tmp1%}, PCMan
;        NumPut(46330, tmp2, 0, "UChar")
;        msgbox, %str_article%
;        ControlSend, BBS_View1, %tmp2%, PCMan

        if i = 0
            Break
    }
}
*/

;for HyperLink Hover
HandleMessage(p_w, p_l, p_m, p_hw)
  {
    global   WM_SETCURSOR, WM_MOUSEMOVE,
    static   URL_hover, h_cursor_hand, h_old_cursor, CtrlIsURL, LastCtrl

    If (p_m = WM_SETCURSOR)
      {
        If URL_hover
          Return, true
      }
    Else If (p_m = WM_MOUSEMOVE)
      {
        ; Mouse cursor hovers URL text control
        StringLeft, CtrlIsURL, A_GuiControl, 3
        If (CtrlIsURL = "URL")
          {
            If URL_hover=
              {
                Gui, Font, cBlue underline
                GuiControl, Font, %A_GuiControl%
                LastCtrl = %A_GuiControl%

                h_cursor_hand := DllCall("LoadCursor", "uint", 0, "uint", 32649)

                URL_hover := true
              }
              h_old_cursor := DllCall("SetCursor", "uint", h_cursor_hand)
          }
        ; Mouse cursor doesn't hover URL text control
        Else
          {
            If URL_hover
              {
                Gui, Font, norm cBlue
                GuiControl, Font, %LastCtrl%

                DllCall("SetCursor", "uint", h_old_cursor)

                URL_hover=
              }
          }
      }
}


; for change gui edit background

WindowProc(hwnd, uMsg, wParam, lParam)
{
    Critical
    global EditBackgroundColor, EditBackgroundBrush, WindowProcOld
    if (uMsg = 0x138 && lParam = A_EventInfo)  ; 0x138 is WM_CTLCOLORSTATIC.
    {
        DllCall("SetBkColor", UInt, wParam, UInt, EditBackgroundColor)
        return EditBackgroundBrush  ; Return the HBRUSH to notify the OS that we altered the HDC.
    }
    ; Otherwise (since above didn't return), pass all unhandled events to the original WindowProc.
    return DllCall("CallWindowProcA", UInt, WindowProcOld, UInt, hwnd, UInt, uMsg, UInt, wParam, UInt, lParam)
}
