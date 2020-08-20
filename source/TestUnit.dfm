object Test: TTest
  Left = 467
  Top = 233
  Caption = 'DeWeb'#27979#35797#32593#39029
  ClientHeight = 583
  ClientWidth = 784
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object Button1: TButton
    Left = 37
    Top = 128
    Width = 104
    Height = 38
    Hint = '{"type":"primary"}'
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 37
    Top = 45
    Width = 186
    Height = 28
    Date = 44063.000000000000000000
    Time = 0.652224942132306800
    TabOrder = 1
  end
  object DateTimePicker2: TDateTimePicker
    Left = 247
    Top = 45
    Width = 186
    Height = 28
    Date = 44063.000000000000000000
    Time = 0.652224942132306800
    Kind = dtkTime
    TabOrder = 2
  end
end
