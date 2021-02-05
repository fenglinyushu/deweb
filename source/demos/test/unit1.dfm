object Form1: TForm1
  Left = 0
  Top = 0
  Hint = '{"type":"primary"}'
  BorderStyle = bsNone
  Caption = 'DeWeb - TChart'
  ClientHeight = 720
  ClientWidth = 1001
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = 16448250
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    1001
    720)
  PixelsPerInch = 96
  TextHeight = 20
  object BitBtn1: TBitBtn
    Left = 40
    Top = 88
    Width = 273
    Height = 41
    Hint = '{"type":"primary"}'
    Anchors = [akTop]
    Caption = 'File'
    TabOrder = 0
    OnEndDock = BitBtn1EndDock
  end
  object Button1: TButton
    Left = 40
    Top = 151
    Width = 273
    Height = 41
    Hint = '{"type":"success"}'
    Anchors = [akTop]
    Caption = 'UPLOAD'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 232
    Width = 129
    Height = 41
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 40
    Top = 296
    Width = 129
    Height = 41
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object TrackBar1: TTrackBar
    Left = 448
    Top = 72
    Width = 353
    Height = 45
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object TrackBar2: TTrackBar
    Left = 432
    Top = 160
    Width = 45
    Height = 353
    Orientation = trVertical
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
end
