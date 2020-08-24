object dwsdk: Tdwsdk
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'DeWeb'
  ClientHeight = 720
  ClientWidth = 360
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object ComboBox1: TComboBox
    Left = 20
    Top = 60
    Width = 145
    Height = 28
    TabOrder = 0
    Text = 'ComboBox1'
  end
  object Button1: TButton
    Left = 20
    Top = 8
    Width = 91
    Height = 36
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end
