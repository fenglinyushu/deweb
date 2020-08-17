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
  object Label1: TLabel
    Left = 64
    Top = 32
    Width = 48
    Height = 20
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 57
    Top = 268
    Width = 104
    Height = 38
    Hint = '{"type":"primary"}'
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 64
    Top = 85
    Width = 121
    Height = 28
    ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
    TabOrder = 1
    Text = 'Edit1'
  end
  object CheckBox1: TCheckBox
    Left = 64
    Top = 157
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 2
  end
  object RadioButton1: TRadioButton
    Left = 63
    Top = 216
    Width = 113
    Height = 17
    Caption = 'RadioButton1'
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 290
    Top = 45
    Width = 206
    Height = 68
    Caption = 'Panel1'
    TabOrder = 4
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 290
    Top = 245
  end
end
