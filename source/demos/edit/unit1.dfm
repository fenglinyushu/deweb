object Form1: TForm1
  Left = 0
  Top = 0
  Hint = '{"type":"primary"}'
  BorderStyle = bsNone
  Caption = 'DeWeb - Edit'
  ClientHeight = 685
  ClientWidth = 360
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Panel_02_Buttons: TPanel
    Left = 0
    Top = 63
    Width = 360
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    Color = 16119285
    ParentBackground = False
    TabOrder = 0
    object Button_Enabled: TButton
      AlignWithMargins = True
      Left = 235
      Top = 5
      Width = 70
      Height = 35
      Hint = '{"type":"success"}'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Enabled'
      TabOrder = 0
      OnClick = Button_EnabledClick
      ExplicitLeft = 230
    end
    object Button5: TButton
      AlignWithMargins = True
      Left = 85
      Top = 5
      Width = 70
      Height = 35
      Hint = '{"type":"success"}'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Size'
      TabOrder = 1
      OnClick = Button5Click
      ExplicitLeft = 80
    end
    object Button6: TButton
      AlignWithMargins = True
      Left = 10
      Top = 5
      Width = 70
      Height = 35
      Hint = '{"type":"success"}'
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Position'
      TabOrder = 2
      OnClick = Button6Click
      ExplicitLeft = 5
    end
    object Button_Visible: TButton
      AlignWithMargins = True
      Left = 160
      Top = 5
      Width = 70
      Height = 35
      Hint = '{"type":"success"}'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alLeft
      Caption = 'Visible'
      TabOrder = 3
      OnClick = Button_VisibleClick
      ExplicitLeft = 155
    end
  end
  object Panel_03_Control: TPanel
    Left = 0
    Top = 108
    Width = 360
    Height = 519
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 111
    object Label_Event: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 472
      Width = 352
      Height = 43
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Event Info'
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 24
      Top = 8
      Width = 54
      Height = 20
      Caption = 'Normal'
    end
    object Label4: TLabel
      Left = 201
      Top = 6
      Width = 86
      Height = 20
      Caption = 'Placeholder'
    end
    object Label5: TLabel
      Left = 22
      Top = 78
      Width = 79
      Height = 20
      Caption = 'prefix-icon'
    end
    object Label6: TLabel
      Left = 202
      Top = 78
      Width = 75
      Height = 20
      Caption = 'suffix-icon'
    end
    object Label7: TLabel
      Left = 20
      Top = 220
      Width = 43
      Height = 20
      Caption = 'demo'
    end
    object Label8: TLabel
      Left = 22
      Top = 147
      Width = 70
      Height = 20
      Caption = 'password'
    end
    object Edit1: TEdit
      Left = 20
      Top = 30
      Width = 121
      Height = 35
      AutoSize = False
      TabOrder = 0
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 200
      Top = 32
      Width = 121
      Height = 35
      Hint = '{"placeholder":"username"}'
      AutoSize = False
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 20
      Top = 102
      Width = 121
      Height = 35
      Hint = '{"prefix-icon":"el-icon-eleme"}'
      AutoSize = False
      TabOrder = 2
    end
    object Edit4: TEdit
      Left = 200
      Top = 102
      Width = 121
      Height = 35
      Hint = '{"suffix-icon":"el-icon-eleme"}'
      AutoSize = False
      TabOrder = 3
    end
    object Edit5: TEdit
      Left = 20
      Top = 246
      Width = 121
      Height = 35
      AutoSize = False
      TabOrder = 4
      OnChange = Edit5Change
      OnEnter = Edit5Enter
      OnExit = Edit5Exit
      OnMouseEnter = Edit5MouseEnter
      OnMouseLeave = Edit5MouseLeave
    end
    object Edit6: TEdit
      Left = 20
      Top = 173
      Width = 121
      Height = 35
      Hint = '{"placeholder":"password"}'
      AutoSize = False
      PasswordChar = '*'
      TabOrder = 5
      Text = '12345'
    end
  end
  object Panel_01_Tile: TPanel
    Left = 0
    Top = 0
    Width = 360
    Height = 63
    Align = alTop
    BorderWidth = 5
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      AlignWithMargins = True
      Left = 182
      Top = 9
      Width = 169
      Height = 43
      Margins.Bottom = 5
      Align = alClient
      AutoSize = False
      Caption = 'Edit'
      Font.Charset = ANSI_CHARSET
      Font.Color = 3289650
      Font.Height = -24
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 266
      ExplicitTop = 12
      ExplicitWidth = 725
      ExplicitHeight = 60
    end
    object Image1: TImage
      Left = 6
      Top = 6
      Width = 48
      Height = 51
      Hint = '{"src":"/media/images/logo.png"}'
      Align = alLeft
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D494844520000002B0000
        0028080600000067C9036E000000097048597300000EC400000EC401952B0E1B
        00000A4D6943435050686F746F73686F70204943432070726F66696C65000078
        DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A21092
        006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A88
        5A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F8011122691
        E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C500
        00F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA502657002091
        00E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C42
        2200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D0100992847240240
        BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD0500768E
        58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F70
        85B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB142611729
        106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E666
        E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D60370
        C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E9E
        A150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB7A
        F000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857FFD
        8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32F1
        1F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407EF3
        2D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE8185C
        A894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC0170261064440
        0C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4C1
        31380DE7E0125C81EB70170660189EC218BC86090441C8081361213A8811628E
        D822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D48
        23F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9A8
        1F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D8A
        8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D5837
        76151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC23
        B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE21
        1E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA453
        A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4B7
        143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED408
        AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A6967
        69F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C748
        6228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F55
        582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550FAB
        5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515FA3
        BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D67256
        03EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE671
        CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37DA
        7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51BA
        85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EFD1
        1F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91C4
        68A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C61626932
        DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D59C
        6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC9856
        3E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9BAD
        C4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625F6
        6DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E957
        671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEEBA
        D2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4F0
        F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306DC8
        DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE23
        7ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD811A
        81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC017
        F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF107E
        6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B45374
        7174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC9B
        B880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A33
        9CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B23F
        E5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92E6
        9D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644D6
        DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE479
        E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B785B
        185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859F1
        E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E25852
        55F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB96315619564
        55EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796DDA
        DADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE51B
        5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A9D
        7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B7857
        6BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F645
        EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B5705A
        2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD23A
        BF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F57
        9EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515DBD
        6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3DAE
        3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D573
        D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC5D
        7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E09
        879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7B2
        A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F372
        EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC40
        FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F3300000D01494441
        5478DAB599097414451A80FFEEB9679299CC249949420E02099984108E700818
        C2A120B710445F00D705DC755116F7C14358105804310F451745458207282CC8
        C30806149EEC2A020209875C4908210799DCC7DC6777ED5F9349C8454270B7F2
        EA4D777575F557FF557F55184208F4B43C17913C6492B93A7784B311C29D3690
        121E586C27BECA60B5B32CD81816AECA5470461EB46D6355DEF21E7FA85D611E
        0696D14F65495E369F111CB36A71E3BD2D811E27B8B1DD8CD58695A7904C1329
        4154827F149EC5367F6C53F826715EAE8137026394274ACF9BFF2FB04CFC54F6
        BDBAFCF5CB6AEEACA33D0D148E61BC80F8B2578A42AC721F102D1EDF2438A425
        3CC1FE088E3DA5D83F0CDBF345528873D999FF396C9ECCBF5CEFB08455D08FFB
        20C5F80E85936175A0AAEB4412C8134A6A851C1FC40131F98944D2589B49ACE0
        3DC0611F3B560B9D0CC2233B4A9B801AEF770446672DAF2D9AF5BB6099F869EC
        6457A3F658D1990AAA2FA357062825EC1BE1952CC0F77EBAA2CFD4E1B3BE2EC9
        F98D3E95EAA788B199A3F2B5E71DE79AC75AA78D5B936E2CDBA477D9A112EF4D
        D809E78C6331108BE36507845966EA06057079D9DC23C12EEB9534EB9F866B87
        2B7DD2A47D82F09A45A759151CF7E2479A3E7B1CC02AC9CD23B50F2591FE4F6B
        C98DACEA53720D19636F807BD8E6428DF038B1301CBB412082288FAB5BB3E800
        3BB7F788C4832517AE957B9F368186E3E5717F5DF1645365B42C6EB2C09E7FBC
        5B29745658FD34D5D3F6EAF0DD65B9D7ED1841CC1418C70F44E87A3425BDCBD1
        257047C9320CA9C21F0F82A2FD41243E5E15120F198A7039293C617F14C8CE4A
        85484CC41E3754D3EF604DE479784DDB776B4655E1CA6E619984E9427B5EB6DB
        8EF7367C99F179EEE290C439BB15614749E10FAEF8B4B57A029C4B8893903084
        CF3D9451FCA8B06CFF999AD32567EAE2AC75A0C4FB5DEA7078459AEC4F0C5996
        61B3C786F36E0C280CD04F7918212F174904E216D80C6DECCAD76A0A33EE518F
        C7B6486C5BADD3AF7C4B13B393DC3C6AF27B79DF3AEB93E9FF008F03142A29E8
        43A02C6780B75BB72579DE86A4DCAF36FCD6D9B31A96251F86E8DF5A5D716B55
        CA94F1FED1CF9BF6B93DE042C834AF108504C43216F6CDBCC0DC3703BCA4764A
        63A816DB4EF96B0D532246C4931B474CF4B16A71E612D398677680DB024A9502
        6282E5B77353C5FDBA034DFD262FDB9577EDC773AB9FD9F6A03E22CD6471E200
        8F3369450358AB58F0B89B421C4A1464C104FE352B87693183BDAAB0DDE9A68A
        8515082AC27B2D0DE2F13334E4C6B70DCD03AA16EF5E6A1A3367BB1736C0073B
        A66BD8D4833789342501EADEC94CCF797BF1FE07F57B3C6D7C68C262A3C16840
        87E359E030981304158A59F87AC1F916A7F3C236A0B13BD1D8E9CAA3C3BA3E38
        76ED9BD5059B5B0FD853D8C7779E6E948C4E5159D025ED073F7FE1B7AD2F7CD1
        59BF5133C76B1217990ED91B99711C0278109617F02040D003F3CEB7890ECCC2
        D0014F64565C3B499751BA9ECB5921A838778710D213D8315FE410367928184B
        EBC0E61F087064CFA2FCADCF7FDA59DF653F265F3256B083790F46059A5BB03C
        480219F86CDAC50E0CCC2F0A0D1960AD874634011AA07769A2B296E812E7939B
        DF591F0536E5E0AD03AED8F8B9E6F23A702080451100B21FF62F2D797BDE07AD
        FB8D7D6E5CD4D0971AB38D06E10D8E63E6F2741D1761F62664E1D3B9173A8DB7
        4C9D4040788EF3AEDFBDB0CE89183AF070E9C50E9EFB30B0C33F39BFC33578C4
        748BA12EC2896272780818E56A704D13B6F978EA9C71A1C3FF6CFE066534C2C3
        A133D1F55BC87F89AA17EF9C7DE159DAE7B6584A0E2A7B3DB6A6F6CEF9FB368B
        922F6F5AAC412E1082DAE3EE74565DC1468B22C481BBB3773BF449A9E6F21A04
        65C1EEE1C18A36C8C90280A4895AC61CF9D404F1C4F50DB71A0C6C1F6A6D54F5
        2024FBE58110B66D7CCE58DAE7B2C28FF4B75921531DFECA92FAB21D6D604B11
        96665216891FC438CCDDC3D2D0A55314E5A688FAD267830EDECD3685464FB157
        56831DA5644389BAB17ADD5AA104F2ACC23BE6C4E7C7E9C72C359E6C2865C339
        4C64A84331122E8B4521BD37E38237FB32B20CA9C1575D78DD88FE33AA95FF78
        614B103600617FF20B2A9B61AE89EC16360027A516DE70A6250F746FF9F2635B
        FCD0E908AAB3A34AED282A8252056A841E4C21E408BB40E5FDE0E6B3C9C45CCB
        80873A13B551219F2594B0D2AD932F4EA6CFD3C2070DDF557EF57C09264C727C
        BF4A2C87314E6B475825C2FE2253574DB7D587740D6B0595520631323758ABAB
        A13E22011CB53560E505C0E1D2E34D78A9C8282CE7C42C3C16C80A60B69F0E27
        55C61040F7C080CFD0387A0C7D3B74C3A84B435A7FA7962E4E98F78A7055B0C8
        1430DC66690B5BEC93ECBFE5EAB259D6FAC8EE60354A31C8310E1A3921386D0E
        7051C3F320A054091A2B4E00DBC1838AB4C4C0FCD8D59012F8319459F5388A1B
        78943E23E54E318CC8F5C6C40B935B7F635CC4B0A003F7726A28AC04611BA40A
        186DEF045681B0797E1A2EC55C277C206CCA9CED02DE0681FE62B0B83182E046
        8C5009BAF1C23F08B40567A16ADD0486D96B255086E966EC367842FB0154DA23
        BCDB1B6AA7B8849E144858D9EB637352DA7F6352F8B0883DE539A506E4916272
        50C54A60ACC7D116B69469BA10092510E2EE3CA7542ECC5C6A1EFBCC763555BF
        9B80CBE5D527AA9A82EA40577C293378CBFC95D78C771A980F80CC087A0F9E8B
        7C1D8A2D71DEBD19355F56C4FFA4D040D8DF865CEA743159AED3BFBAAC3AFFDD
        5AB459050AE18ECCDF34C56652B5C0A2B208DD1150530BC62A27A473D845BB96
        38D25EDCE1AEA96AF272AF44F16DA516744539EF07652CD87CDD525AA54A78A9
        F7EC4F623F9A2ADAF05491391EB33C0F2EA198EB49794C9B84DC8A948BA33A1B
        9F8D9FA6D863C83D35D25439BC1161C370FC2FD4511356D5179F6A81BD255190
        20A715B7D50C2E0A04568724BCFCBE2A6AA72BEF589BDD806EFDB14DD5494FAE
        817A9A9AA3ACA833F90582F66E2E54AD1FD76682474AFA92BB45185F515D34E8
        B342FE82402A102D1B91D3C6991886198CB9C9E5E6FB024C17E916DF8166108E
        B02B42074AF61AAEB85AFAEFD0449205F5A5D40BBD11215FA682D1D1A96D322E
        5A82D7FFF0766DBFD1CBC18CDB2EEAD254F5A5B950B936B583260EDE1D68AB2C
        11CAA8F00512FEB2420DBA8509977BB507A5BFCDB0A9512315474B7FB514A254
        69E21F4437A7EDB4CC0C894E61CFDD3DCD797359946E244A6D7E6852CA01C3D5
        5FDAC0FEFDBB4DB5718FAF81C66A547D308414E740E03B2F465DB71497B6873D
        543CD056512C9489155C1EC308B83F0DCD4D6C0FD95C9A61B3FC83EE2658EA7A
        5B105682B3BC27555A27D98D7E6D60698A784E117036D6661C49B7C972D470A3
        4806F13113547487D002FBDAB7FFA88D796C1D3DD2D096E442F0C7CBD8EBB5B7
        3A3D74385C9CE4ACAF668B046281E08F8372FB75073A297244D8676517CA693E
        4D65D91B1DF7A55E038587EE5DE13AC02E084D8ADD5B79ADE00EED8C8D31D846
        F75E7B941159AEFC26DB0D5E7E68556DF2EC2DDABC53EF546D7C620574518ED7
        24129B59644AEB7359D51D28933053FD6BE1897AB5DB0154AA42DCF5D297A2F8
        8E8EDEB2ADB925F52B5039ADB176BADBC436BAE88FED3D4A72FAEE19AF81076C
        FCF9739140C8EB36CF5D7BDD76CFD015ECC98641E449F595FBF1F141A0180132
        0DB947708B3FDE80A094843AD6BAD044C52EC3355B0758ACB81E10EB5391C3FC
        BF2FCB31DDC6265CF140EA3D0E64F165CEFBD17EE99B8716EC5B93030F515227
        4E14FC74E204D715A8287EAA7891B97C7A46F9D543B7A953619B12418BA4FEF6
        497693BCB371DB9C1B1C566ABF9A62AE492FF5A68CF832DD7263BBFA01B1F761
        4A6BD8D6AA7FC5583463BDE1FAE7254C9350688A1A8D55D3C5B73A1C72FC2C0F
        F8CF20BB31B5826DCA71A984E962B13474C0AC4F03A24EB576BA472D5FA97417
        6798AA8716783959EFA98F1EABA21BA1747AD6552C9656C8DCCE8006969152F7
        94A0D1D3B3AEA3CA909C7463C5B047859CDB6BD0C895B50567435C765CF7D966
        69D3780A3BD4BD87BCD1507C15EFF91EC1D2522E96D6F9B99D9A72B42601341D
        1607F9FA7EAD8938FA97BAD21982F869321ED32721C759DDF96D573CEA3C2836
        01B979C434277CF0F0BFD6149ED7BB2C508FCF2C3E1B65902B1E87DCA8E913B7
        A5EE4E417793EDF27CF6909F76EF6C6BCDFC22862677ACEF741BA58CAFE09E15
        4A59015C92A9A148E29F795616F0A198F328315B74F98B85AAE1A6EAA5714EF3
        A444874920C5BE988481C307494FC635184BE9F96E480FFCA1DBC3E4A5BAFE4F
        AFA9B9B95F40806D0046EC627CE7F158681A27C24B2A7921DC3FF9A67A74FB2A
        0D851E866951B9D4777C7A46117825CD5A3784F4E09F1A0FF53F055A3255BDDE
        9D6732BC4A754D4FC19DDED5C6775CEFADC4BB5C378D4680B4C8101319D486BF
        CF51CB042248E4DC6C4F207B0CDB5C966BF5E9734DE5AFF6755A06D30D347D9B
        6EE39D3EE86678A94FDAB49810F09C5CF3E11F4C952FF714F077C1B62F9B82FA
        9258A719344E0BAA5BE0952DC656C853044115DEBF595BF8C831BA7DF92F088F
        6BFF548302070000000049454E44AE426082}
      ExplicitLeft = 14
      ExplicitTop = 12
      ExplicitHeight = 68
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 57
      Top = 9
      Width = 119
      Height = 43
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'DeWeb -'
      Font.Charset = ANSI_CHARSET
      Font.Color = 3289650
      Font.Height = -24
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 60
    end
  end
end
