object Test: TTest
  Left = 498
  Top = 150
  Width = 606
  Height = 622
  Caption = 'Test'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object Button1: TButton
    Left = 32
    Top = 32
    Width = 100
    Height = 35
    Caption = 'Set'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 32
    Width = 100
    Height = 35
    Caption = 'Get'
    TabOrder = 1
    OnClick = Button2Click
  end
  object RadioButton1: TRadioButton
    Left = 32
    Top = 96
    Width = 329
    Height = 17
    Caption = 'RadioButton1'
    TabOrder = 2
  end
  object RadioButton2: TRadioButton
    Left = 32
    Top = 136
    Width = 329
    Height = 17
    Caption = 'RadioButton2'
    Checked = True
    TabOrder = 3
    TabStop = True
  end
  object Button3: TButton
    Left = 40
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
  end
end
