object Test: TTest
  Left = 498
  Top = 150
  Width = 867
  Height = 622
  Caption = 'Test'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 56
    Top = 40
    object File1: TMenuItem
      Caption = 'File'
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Undo1: TMenuItem
        Caption = 'Undo'
      end
      object reado1: TMenuItem
        Caption = 'reado'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Other1: TMenuItem
        Caption = 'Other'
        object Copy1: TMenuItem
          Caption = 'Copy'
        end
        object Cut1: TMenuItem
          Caption = 'Cut'
        end
        object Paste1: TMenuItem
          Caption = 'Paste'
        end
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
    end
    object A1: TMenuItem
      Caption = 'A'#20013#25991
    end
    object B1: TMenuItem
      Caption = 'B'#20013#25991
      object AB1: TMenuItem
        Caption = 'AB'#20013
        object N2: TMenuItem
          Caption = #31995#32479#31649#29702
        end
      end
    end
  end
end
