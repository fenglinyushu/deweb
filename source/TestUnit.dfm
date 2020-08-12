object Test: TTest
  Left = 464
  Top = 154
  Width = 867
  Height = 622
  Caption = 'Test'
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
  object PageControl1: TPageControl
    Left = 40
    Top = 16
    Width = 425
    Height = 345
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #39318#39029
      object Edit1: TEdit
        Left = 129
        Top = 15
        Width = 160
        Height = 42
        Hint = 
          '{"placeholder":"'#29992#25143#21517'","prefix-icon":"el-icon-refresh","suffix-ico' +
          'n":"el-icon-search"}'
        AutoSize = False
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 0
        Text = 'AB'#32534#36753'123'
        OnChange = Edit7Change
        OnEnter = Edit1Enter
      end
      object Button2: TButton
        Left = 16
        Top = 16
        Width = 105
        Height = 41
        Caption = #20013#25991#25353#38062
        TabOrder = 1
        OnClick = Button1Click
      end
      object CheckBox1: TCheckBox
        Left = 24
        Top = 80
        Width = 97
        Height = 17
        Caption = #22810#36873#26694
        TabOrder = 2
      end
      object ComboBox1: TComboBox
        Left = 24
        Top = 128
        Width = 145
        Height = 28
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        ItemHeight = 20
        TabOrder = 3
        Text = 'ComboBox1'
        Items.Strings = (
          #24352#20846
          #38472#23569#36149
          'CSDF')
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object Button1: TButton
        Left = 16
        Top = 16
        Width = 105
        Height = 41
        Caption = #20013#25991#25353#38062
        TabOrder = 0
        OnClick = Button1Click
      end
      object Edit7: TEdit
        Left = 17
        Top = 71
        Width = 160
        Height = 42
        Hint = 
          '{"placeholder":"'#29992#25143#21517'","prefix-icon":"el-icon-refresh","suffix-ico' +
          'n":"el-icon-search"}'
        AutoSize = False
        ImeName = #20013#25991'('#31616#20307') - '#26497#28857#20116#31508
        TabOrder = 1
        Text = 'AB'#32534#36753'123'
        OnChange = Edit7Change
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      object Panel1: TPanel
        Left = 40
        Top = 21
        Width = 289
        Height = 185
        BorderStyle = bsSingle
        Caption = 'Panel1'
        Color = clInactiveCaption
        TabOrder = 0
      end
    end
  end
end
