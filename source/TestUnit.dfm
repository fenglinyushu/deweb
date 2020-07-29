object Test: TTest
  Left = 498
  Top = 150
  Width = 867
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
  object DBGrid1: TDBGrid
    Left = 16
    Top = 16
    Width = 809
    Height = 345
    DataSource = DataSource1
    ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = #24494#36719#38597#40657
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'FOrder'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FContent'
        Width = 356
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FPicture'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FRightSolution'
        Title.Caption = 'Right'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FSolution'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FSortID'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIsFallible'
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = DM.ADOQuery_Driver
    Left = 24
    Top = 376
  end
end
