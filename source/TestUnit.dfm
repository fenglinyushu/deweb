object Test: TTest
  Left = 498
  Top = 150
  Width = 377
  Height = 597
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
    Left = 32
    Top = 16
    Width = 62
    Height = 13
    Caption = 'ABC'#20013#25991'123'
  end
  object Button1: TButton
    Left = 32
    Top = 96
    Width = 297
    Height = 41
    Hint = '{"type":"success","icon":"el-icon-home"}'
    Caption = 'Get Params'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 40
    Width = 297
    Height = 21
    Hint = '{"placeholder":"'#29992#25143#21517'","prefix-icon":"el-icon-search"}'
    ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 32
    Top = 160
    Width = 297
    Height = 41
    Hint = '{"type":"primary","icon":"el-icon-upload"}'
    Caption = 'New URL'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 32
    Top = 232
    Width = 297
    Height = 49
    Hint = '{"type":"danger","icon":"el-icon-help"}'
    Caption = 'Button3'
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 40
    Top = 328
    Width = 289
    Height = 129
    Caption = 'Panel1'
    Color = clInfoBk
    TabOrder = 4
    object Label2: TLabel
      Left = 32
      Top = 16
      Width = 62
      Height = 13
      Caption = 'ABC'#20013#25991'123'
    end
    object CheckBox1: TCheckBox
      Left = 32
      Top = 64
      Width = 97
      Height = 17
      Caption = 'CheckBox1'
      TabOrder = 0
    end
  end
end
