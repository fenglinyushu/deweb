object dfw_thread: Tdfw_thread
  Left = 411
  Top = 136
  Width = 979
  Height = 563
  Caption = #22823#23500#32705#35770#22363
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_All: TPanel
    Left = 0
    Top = 0
    Width = 946
    Height = 1060
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Panel_99_Foot: TPanel
      Left = 0
      Top = 990
      Width = 946
      Height = 70
      Align = alBottom
      Color = clWhite
      TabOrder = 0
      object Label14: TLabel
        Left = 1
        Top = 49
        Width = 944
        Height = 20
        Align = alBottom
        Alignment = taCenter
        Caption = #24863#35874#24744#30340#24800#39038','#22914#26377#20219#20309#24314#35758#21644#24847#35265','#35831#32852#31995#29256#20027'.2020.08.01'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 1
        Top = 29
        Width = 944
        Height = 20
        Align = alBottom
        Alignment = taCenter
        Caption = '(C) '#29256#26435#25152#26377'. '#22823#23500#32705#35770#22363' 1998-2020'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 944
        Height = 1
        Align = alTop
        TabOrder = 0
      end
    end
    object Panel_10_Content: TPanel
      Left = 0
      Top = 0
      Width = 946
      Height = 990
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 946
        Height = 990
        Align = alClient
        Color = clWhite
        TabOrder = 0
        object Panel_Subjects: TPanel
          Left = 1
          Top = 1
          Width = 944
          Height = 988
          Align = alClient
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Panel_Thread: TPanel
            Left = 1
            Top = 89
            Width = 942
            Height = 232
            Align = alTop
            BevelOuter = bvNone
            BorderWidth = 10
            Color = clWhite
            TabOrder = 0
            object Label_Score: TLabel
              Left = 10
              Top = 10
              Width = 922
              Height = 60
              Align = alTop
              Caption = 
                #22823#23478#30475#30475#65292#20026#20160#20040#25105#30340'jsp'#39029#38754#20013#30340#27721#23383#22312#31243#24207#25191#34892#21518#21464#25104#20102#20081#30721'<p align="center"><fontolor="#0000' +
                'FF">&Icirc;&Ograve;&micro;&Auml;&sup1;'#164#215#247'&Igrave;'#168'</font></p>'#65292#25105#30693 +
                #36947#26159#23383#31526#38598#30340#38382#39064#65292#21487#26159#25105#29992#30340#26159'GBK'#21568#65292#20026#20160#20040#36824#26159#26377#38382#39064#21602#65311#35831#37027#20301#26379#21451#24110#24110#24537#65292#32473#20010#26368#31616#21333#30340#26041#27861' '
              WordWrap = True
            end
          end
          object Panel_ThreadTitle: TPanel
            Left = 1
            Top = 57
            Width = 942
            Height = 32
            Align = alTop
            BevelOuter = bvNone
            Color = 16771553
            TabOrder = 1
            object Label106: TLabel
              Left = 196
              Top = 4
              Width = 94
              Height = 20
              Caption = '(2020-08-05)'
            end
            object StaticText_Uper: TStaticText
              Left = 8
              Top = 0
              Width = 177
              Height = 32
              Hint = '{"type":"default"}'
              AutoSize = False
              Caption = 'StaticText_Subject'
              TabOrder = 0
            end
          end
          object Panel1: TPanel
            Left = 1
            Top = 1
            Width = 942
            Height = 56
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            TabOrder = 2
            object Label1: TLabel
              Left = 8
              Top = 4
              Width = 38
              Height = 20
              Caption = #26631#39064' :'
            end
            object Label2: TLabel
              Left = 8
              Top = 23
              Width = 30
              Height = 20
              Caption = #20998#31867
            end
            object Label_ThreadTitle: TLabel
              Left = 56
              Top = 4
              Width = 30
              Height = 20
              Caption = #20998#31867
            end
          end
        end
      end
    end
  end
end
