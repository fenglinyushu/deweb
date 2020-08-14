object Form_Base: TForm_Base
  Left = 430
  Top = 139
  Width = 605
  Height = 403
  Caption = 'Form_Base'
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
  object Timer_Manager: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = Timer_ManagerTimer
    Left = 232
    Top = 24
  end
end
