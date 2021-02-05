object Form1: TForm1
  Left = 0
  Top = 0
  Hint = '{"type":"primary"}'
  Caption = 'Form1'
  ClientHeight = 525
  ClientWidth = 623
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Button3: TButton
    Left = 24
    Top = 14
    Width = 100
    Height = 40
    Hint = '{"type":"primary"}'
    Caption = 'Play'
    TabOrder = 0
    OnClick = Button3Click
  end
  object MediaPlayer1: TMediaPlayer
    Left = 24
    Top = 70
    Width = 532
    Height = 321
    EnabledButtons = []
    DoubleBuffered = True
    FileName = '/ocean.mp4'
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 130
    Top = 14
    Width = 100
    Height = 40
    Hint = '{"type":"primary"}'
    Caption = 'Pause'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 236
    Top = 14
    Width = 100
    Height = 40
    Hint = '{"type":"primary"}'
    Caption = 'Switch'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 342
    Top = 14
    Width = 100
    Height = 40
    Hint = '{"type":"primary"}'
    Caption = 'Loop'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 456
    Top = 14
    Width = 100
    Height = 40
    Hint = '{"type":"primary"}'
    Caption = 'To 5s'
    TabOrder = 5
    OnClick = Button5Click
  end
end
