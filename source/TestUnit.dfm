object Test: TTest
  Left = 500
  Top = 177
  Width = 336
  Height = 920
  Caption = 'Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 45
    Top = 30
    Width = 221
    Height = 41
    AutoSize = False
    Caption = 'Hello,De'#20013#25991'Web!'
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentColor = False
    ParentFont = False
  end
  object RadioButton1: TRadioButton
    Left = 56
    Top = 88
    Width = 113
    Height = 17
    Caption = 'Radio'#20013#25991'Button1'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 40
    Top = 200
    Width = 121
    Height = 41
    Caption = 'Get Params'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 40
    Top = 152
    Width = 121
    Height = 29
    ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 40
    Top = 280
    Width = 121
    Height = 41
    Caption = 'New URL'
    TabOrder = 3
    OnClick = Button2Click
  end
end
