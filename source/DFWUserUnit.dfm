object dfw_user: Tdfw_user
  Left = 370
  Top = 190
  Width = 1033
  Height = 563
  Caption = #22823#23500#32705#35770#22363
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = 6579300
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 20
  object Panel_All: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 1060
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Panel_99_Foot: TPanel
      Left = 0
      Top = 84
      Width = 1000
      Height = 70
      Align = alTop
      Color = clWhite
      TabOrder = 0
      object Label14: TLabel
        Left = 1
        Top = 49
        Width = 998
        Height = 20
        Align = alBottom
        Alignment = taCenter
        Caption = #24863#35874#24744#30340#24800#39038','#22914#26377#20219#20309#24314#35758#21644#24847#35265','#35831#32852#31995#29256#20027'.2020.08.01'
      end
      object Label15: TLabel
        Left = 1
        Top = 29
        Width = 998
        Height = 20
        Align = alBottom
        Alignment = taCenter
        Caption = '(C) '#29256#26435#25152#26377'. '#22823#23500#32705#35770#22363' 1998-2020'
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 998
        Height = 1
        Align = alTop
        TabOrder = 0
      end
    end
    object Panel_10_Posts: TPanel
      Left = 0
      Top = 56
      Width = 1000
      Height = 28
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
    end
    object Panel_00_Title: TPanel
      Left = 0
      Top = 0
      Width = 1000
      Height = 56
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      object Label_UserName: TLabel
        Left = 8
        Top = 4
        Width = 473
        Height = 19
        Caption = #26631#39064' :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6579300
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object ZQuery_Users: TZReadOnlyQuery
    Connection = DM.ZConnection
    Params = <>
    Left = 96
    Top = 216
  end
end
