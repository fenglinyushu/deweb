object MsgMonitor: TMsgMonitor
  Left = 0
  Top = 0
  Caption = 'MsgMonitor'
  ClientHeight = 420
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  DesignSize = (
    771
    420)
  PixelsPerInch = 96
  TextHeight = 13
  object ListView: TListView
    Left = 0
    Top = 0
    Width = 771
    Height = 220
    Align = alClient
    Columns = <
      item
        Caption = 'Time'
        Width = 100
      end
      item
        Caption = 'Code'
        Width = 600
      end>
    HideSelection = False
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnClick = ListViewClick
  end
  object Memo_Msg: TMemo
    Left = 0
    Top = 220
    Width = 771
    Height = 200
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Memo_Msg')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button1: TButton
    Left = 666
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    TabOrder = 1
    OnClick = Button1Click
  end
end
