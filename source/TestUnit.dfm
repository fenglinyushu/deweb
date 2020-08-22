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
    Left = 8
    Top = 105
    Width = 736
    Height = 506
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
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = #24615#21035
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = #31821#36143
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = #20986#29983#26085#26399
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = #29233#22909
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = #37038#31665
        Width = 110
        Visible = True
      end>
  end
  object DBCheckBox1: TDBCheckBox
    Left = 150
    Top = 60
    Width = 156
    Height = 17
    Caption = #30007
    DataField = #24615#21035
    DataSource = DataSource1
    TabOrder = 3
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
