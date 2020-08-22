object Form_Base: TForm_Base
  Left = 430
  Top = 139
  Caption = 'Form_Base'
  ClientHeight = 364
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Forms: TPanel
    Left = 0
    Top = 175
    Width = 589
    Height = 189
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
  end
  object FileListBox_Vcls: TFileListBox
    Left = 380
    Top = 50
    Width = 145
    Height = 97
    ItemHeight = 13
    Mask = '*.dll'
    TabOrder = 1
  end
  object Timer_Manager: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = Timer_ManagerTimer
    Left = 232
    Top = 24
  end
end
