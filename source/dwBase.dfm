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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Forms: TPanel
    Left = 24
    Top = 128
    Width = 10000
    Height = 65535
    BevelInner = bvLowered
    TabOrder = 0
  end
  object Timer_Manager: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = Timer_ManagerTimer
    Left = 232
    Top = 24
  end
end
