object Test: TTest
  Left = 467
  Top = 233
  Caption = 'DeWeb'#27979#35797#32593#39029
  ClientHeight = 881
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
  object DBText1: TDBText
    Left = 425
    Top = 13
    Width = 65
    Height = 17
    DataField = #24615#21035
    DataSource = DataSource1
  end
  object Label1: TLabel
    Left = 150
    Top = 16
    Width = 38
    Height = 20
    Caption = #22995#21517' :'
  end
  object Label2: TLabel
    Left = 360
    Top = 13
    Width = 38
    Height = 20
    Caption = #24615#21035' :'
  end
  object Button1: TButton
    Left = 20
    Top = 8
    Width = 104
    Height = 38
    Hint = '{"type":"primary"}'
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBEdit1: TDBEdit
    Left = 215
    Top = 13
    Width = 121
    Height = 28
    DataField = #22995#21517
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 20
    Top = 65
    Width = 736
    Height = 191
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = #24494#36719#38597#40657
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = #22995#21517
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = #24615#21035
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = #27665#26063
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = #31821#36143
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = #20986#29983#26085#26399
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = #29233#22909
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = #37038#31665
        Width = 120
        Visible = True
      end>
  end
  object Button76: TButton
    Left = 23
    Top = 271
    Width = 90
    Height = 35
    Hint = '{"type":"primary"}'
    Caption = 'Visible'
    TabOrder = 3
    OnClick = Button76Click
  end
  object Button77: TButton
    Left = 119
    Top = 271
    Width = 90
    Height = 35
    Hint = '{"type":"primary"}'
    Caption = 'Enabled'
    TabOrder = 4
    OnClick = Button77Click
  end
  object Button78: TButton
    Left = 311
    Top = 271
    Width = 90
    Height = 35
    Hint = '{"type":"primary"}'
    Caption = 'Size'
    TabOrder = 5
    OnClick = Button78Click
  end
  object Button80: TButton
    Left = 407
    Top = 271
    Width = 91
    Height = 35
    Caption = 'Get'
    TabOrder = 6
    OnClick = Button80Click
  end
  object Button81: TButton
    Left = 503
    Top = 271
    Width = 90
    Height = 35
    Caption = 'Set'
    TabOrder = 7
    OnClick = Button81Click
  end
  object CheckBox12: TCheckBox
    Left = 20
    Top = 319
    Width = 344
    Height = 22
    Caption = 'ShowMessage OnChange'
    TabOrder = 8
  end
  object SpinEdit1: TSpinEdit
    Left = 20
    Top = 370
    Width = 121
    Height = 30
    MaxValue = 5
    MinValue = -5
    TabOrder = 9
    Value = 0
    OnChange = SpinEdit1Change
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\Study\demo.mdb;P' +
      'ersist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 530
    Top = 5
  end
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'Member'
    Left = 620
    Top = 5
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 710
    Top = 5
  end
end
