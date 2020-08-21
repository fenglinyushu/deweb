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
  object DBText1: TDBText
    Left = 85
    Top = 378
    Width = 65
    Height = 17
    DataField = #24615#21035
    DataSource = DataSource1
  end
  object Label1: TLabel
    Left = 20
    Top = 338
    Width = 38
    Height = 20
    Caption = #22995#21517' :'
  end
  object Label2: TLabel
    Left = 20
    Top = 378
    Width = 38
    Height = 20
    Caption = #24615#21035' :'
  end
  object Button1: TButton
    Left = 20
    Top = 18
    Width = 104
    Height = 38
    Hint = '{"type":"primary"}'
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBEdit1: TDBEdit
    Left = 85
    Top = 335
    Width = 121
    Height = 28
    DataField = #22995#21517
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 20
    Top = 80
    Width = 736
    Height = 231
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
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\Study\demo.mdb;P' +
      'ersist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 240
    Top = 10
  end
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'Member'
    Left = 320
    Top = 10
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 390
    Top = 10
  end
end
