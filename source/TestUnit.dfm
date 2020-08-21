object Test: TTest
  Left = 467
  Top = 233
  Caption = 'DeWeb'#27979#35797#32593#39029
  ClientHeight = 861
  ClientWidth = 784
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object DBText1: TDBText
    Left = 450
    Top = 133
    Width = 65
    Height = 17
    DataField = #24615#21035
    DataSource = DataSource1
  end
  object Label1: TLabel
    Left = 175
    Top = 136
    Width = 38
    Height = 20
    Caption = #22995#21517' :'
  end
  object Label2: TLabel
    Left = 385
    Top = 133
    Width = 38
    Height = 20
    Caption = #24615#21035' :'
  end
  object Button1: TButton
    Left = 510
    Top = 53
    Width = 104
    Height = 38
    Hint = '{"type":"primary"}'
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBEdit1: TDBEdit
    Left = 240
    Top = 133
    Width = 121
    Height = 28
    DataField = #22995#21517
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 305
    Top = 180
    Width = 436
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
    Left = 245
    Top = 250
  end
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'Member'
    Left = 185
    Top = 280
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 180
    Top = 375
  end
  object MainMenu: TMainMenu
    AutoHotkeys = maManual
    Left = 120
    Top = 176
    object MenuItem_File: TMenuItem
      Tag = 1
      Caption = 'File'
      object MenuItem_Open: TMenuItem
        Tag = 10
        Caption = 'Open'
        Hint = 'Open '
        ImageIndex = 0
        ShortCut = 16463
      end
      object MenuItem_Reload: TMenuItem
        Caption = 'Reload source file'
        ImageIndex = 1
        ShortCut = 116
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MenuItem_Save: TMenuItem
        Tag = 11
        Caption = 'Save'
        Hint = 'Save'
        ImageIndex = 7
        ShortCut = 16467
      end
      object MenuItem_SaveAs: TMenuItem
        Tag = 12
        Caption = 'Save as'
        Visible = False
      end
      object MenuItem_SaveAll: TMenuItem
        Tag = 13
        Caption = 'Save &all'
        Hint = 'Save all'
        ImageIndex = 8
      end
      object Sep: TMenuItem
        Caption = '-'
        Visible = False
      end
      object MenuItem_PrintChart: TMenuItem
        Caption = 'Print chart'
        ImageIndex = 19
        Visible = False
      end
      object MenuItem_PrintCode: TMenuItem
        Caption = 'Print code'
        Visible = False
      end
      object MenuItem_Pro0: TMenuItem
        Caption = '-'
      end
      object MenuItem_Close: TMenuItem
        Tag = 17
        Caption = 'Close'
      end
      object MenuItem_CloseAll: TMenuItem
        Tag = 18
        Caption = 'Close All'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MenuItem_Exit: TMenuItem
        Tag = 19
        Caption = '&Exit'
      end
    end
    object MenuItem_Edit: TMenuItem
      Tag = 2
      Caption = 'Edit'
      object MenuItem_ZoomIn: TMenuItem
        Caption = 'Zoom in'
        Hint = 'Zoom in'
        ImageIndex = 4
        ShortCut = 16457
      end
      object MenuItem_ZoomOut: TMenuItem
        Caption = 'Zoom out'
        Hint = 'Zoom out'
        ImageIndex = 5
        ShortCut = 16469
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MenuItem_ExpandAll: TMenuItem
        Caption = 'Full expand'
        Hint = 'Full expand the selected node'
        ImageIndex = 2
        ShortCut = 16453
      end
      object MenuItem_ShrinkAll: TMenuItem
        Caption = 'Full collapse'
        Hint = 'Full collapse the selected node'
        ImageIndex = 3
        ShortCut = 16466
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MenuItem_ShowLineNumbers: TMenuItem
        AutoCheck = True
        Caption = 'Show line numbers'
        ImageIndex = 12
      end
    end
    object MenuItem_Search: TMenuItem
      Caption = 'Search'
      object MenuItem_Find: TMenuItem
        Caption = 'Find ..'
        Hint = 'Find ..'
        ImageIndex = 6
        ShortCut = 16454
      end
      object MenuItem_SearchAgain: TMenuItem
        Caption = 'Search Again'
        Hint = 'Search Again'
        ShortCut = 114
      end
    end
    object MenuItem_Option: TMenuItem
      Caption = 'Tool'
      object MenuItem_ExportWord: TMenuItem
        Tag = 16
        Caption = 'Export chart as Ms Word file'
        Hint = 'Export chart as Ms Word file'
        ImageIndex = 9
      end
      object MenuItem_ExportVisio: TMenuItem
        Tag = 14
        Caption = 'Export chart as Visio file'
        Hint = 'Export chart as Visio file'
        ImageIndex = 10
      end
      object MenuItem_ExportBitmap: TMenuItem
        Tag = 15
        Caption = 'Export chart as Bitmap file'
        Hint = 'Export chart as Bitmap file'
        ImageIndex = 11
      end
      object MenuItem_ExportSVG: TMenuItem
        Caption = 'Export chart as SVG file'
        Hint = 'Export chart as SVG file'
        ImageIndex = 20
      end
      object MenuItem_ExportXML: TMenuItem
        Caption = 'Export chart as XML file'
        Hint = 'Export chart as XML file'
        ImageIndex = 45
      end
      object MenuItem_SimulateExec: TMenuItem
        Caption = 'Simulate execute'
        ImageIndex = 22
        Visible = False
      end
      object MenuItem_Pro1: TMenuItem
        Caption = '-'
      end
      object MenuItem_Options: TMenuItem
        Tag = 21
        Caption = 'Options'
        Hint = 'Options'
        ImageIndex = 13
      end
    end
    object Windows1: TMenuItem
      Caption = 'Windows'
      object N6: TMenuItem
        Caption = '-'
      end
      object MenuItem_NextWindow: TMenuItem
        Caption = 'Next Window'
        ShortCut = 32803
      end
    end
    object MenuItem_Help: TMenuItem
      Tag = 3
      Caption = 'Help'
      object MenuItem_Content: TMenuItem
        Tag = 30
        Caption = 'Content'
        Hint = 'Help'
        ImageIndex = 17
        ShortCut = 112
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MenuItem_HomePage: TMenuItem
        Tag = 31
        Caption = 'Home Page'
        ImageIndex = 18
      end
      object MenuItem_OrderNow: TMenuItem
        Tag = 32
        Caption = 'Order Now'
      end
      object MenuItem_Pro2: TMenuItem
        Caption = '-'
      end
      object MenuItem_Register: TMenuItem
        Caption = 'Register'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MenuItem_About: TMenuItem
        Tag = 33
        Caption = 'About'
      end
    end
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    OwnerDraw = True
    Left = 120
    Top = 241
    object MenuItem1: TMenuItem
      Tag = 1
      Caption = #31995#32479#31649#29702
      object MenuItem2: TMenuItem
        Tag = 10
        Caption = 'Open'
        Hint = 'Open '
        ImageIndex = 0
        ShortCut = 16463
      end
      object MenuItem3: TMenuItem
        Caption = 'Reload source file'
        ImageIndex = 1
        ShortCut = 116
      end
      object MenuItem5: TMenuItem
        Tag = 11
        Caption = 'Save'
        Hint = 'Save'
        ImageIndex = 7
        ShortCut = 16467
      end
      object MenuItem6: TMenuItem
        Tag = 12
        Caption = 'Save as'
        Visible = False
      end
      object MenuItem12: TMenuItem
        Tag = 17
        Caption = 'Close'
      end
      object MenuItem13: TMenuItem
        Tag = 18
        Caption = 'Close All'
      end
      object MenuItem14: TMenuItem
        Caption = '-'
      end
      object MenuItem15: TMenuItem
        Tag = 19
        Caption = '&Exit'
      end
    end
    object MenuItem16: TMenuItem
      Tag = 2
      Caption = #39033#30446#26696#20363
      object MenuItem17: TMenuItem
        Caption = 'Zoom in'
        Hint = 'Zoom in'
        ImageIndex = 4
        ShortCut = 16457
      end
      object MenuItem18: TMenuItem
        Caption = 'Zoom out'
        Hint = 'Zoom out'
        ImageIndex = 5
        ShortCut = 16469
      end
      object MenuItem19: TMenuItem
        Caption = '-'
      end
      object MenuItem20: TMenuItem
        Caption = 'Full expand'
        Hint = 'Full expand the selected node'
        ImageIndex = 2
        ShortCut = 16453
      end
      object MenuItem21: TMenuItem
        Caption = 'Full collapse'
        Hint = 'Full collapse the selected node'
        ImageIndex = 3
        ShortCut = 16466
      end
      object MenuItem22: TMenuItem
        Caption = '-'
      end
      object MenuItem23: TMenuItem
        AutoCheck = True
        Caption = 'Show line numbers'
        ImageIndex = 12
      end
    end
    object MenuItem24: TMenuItem
      Caption = #25968#25454#20998#26512
      object MenuItem25: TMenuItem
        Caption = 'Find ..'
        Hint = 'Find ..'
        ImageIndex = 6
        ShortCut = 16454
      end
      object MenuItem26: TMenuItem
        Caption = 'Search Again'
        Hint = 'Search Again'
        ShortCut = 114
      end
    end
    object MenuItem27: TMenuItem
      Caption = #37096#32626#24037#20855
      object MenuItem28: TMenuItem
        Tag = 16
        Caption = 'Export chart as Ms Word file'
        Hint = 'Export chart as Ms Word file'
        ImageIndex = 9
      end
      object MenuItem29: TMenuItem
        Tag = 14
        Caption = 'Export chart as Visio file'
        Hint = 'Export chart as Visio file'
        ImageIndex = 10
      end
      object MenuItem30: TMenuItem
        Tag = 15
        Caption = 'Export chart as Bitmap file'
        Hint = 'Export chart as Bitmap file'
        ImageIndex = 11
      end
      object MenuItem31: TMenuItem
        Caption = 'Export chart as SVG file'
        Hint = 'Export chart as SVG file'
        ImageIndex = 20
      end
      object MenuItem32: TMenuItem
        Caption = 'Export chart as XML file'
        Hint = 'Export chart as XML file'
        ImageIndex = 45
      end
      object MenuItem33: TMenuItem
        Caption = 'Simulate execute'
        ImageIndex = 22
        Visible = False
      end
      object MenuItem34: TMenuItem
        Caption = '-'
      end
      object MenuItem35: TMenuItem
        Tag = 21
        Caption = 'Options'
        Hint = 'Options'
        ImageIndex = 13
      end
    end
    object MenuItem39: TMenuItem
      Tag = 3
      Caption = #24110#21161
      ImageIndex = 45
    end
  end
end
