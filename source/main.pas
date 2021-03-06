unit Main;


interface

uses
     //
     dwVars,
     dwBase,

     //
     Unit1,Unit2,Unit3,Unit4,Unit5,
     DemosUnit,
     TestUnit,
     DriverUnit,
     //
     DFWUnit,  //大富翁论坛
     DFWThreadUnit,
     DFWUserUnit,
     DFWLoginUnit,


     //
     SynCommons,


     OverbyteIcsWinSock,  OverbyteIcsWSocket, OverbyteIcsWndControl,
     OverbyteIcsHttpSrv, OverbyteIcsUtils, OverbyteIcsFormDataDecoder, OverbyteIcsMimeUtils,

     //
     HTTPApp,XpMan,
     Windows, Messages, SysUtils, Classes, Controls, Forms,
     StdCtrls, ExtCtrls, StrUtils,
     IniFiles,  jpeg, Menus,  ShellAPI,  Spin;


type
  TMainForm = class(TForm)
    Panel_Buttons: TPanel;
    Button_Start: TButton;
    Button_Stop: TButton;
    Button1: TButton;
    Label3: TLabel;
    Panel_WebXone: TPanel;
    Timer_Hide: TTimer;
    PopupMenu: TPopupMenu;
    PopItem_Show: TMenuItem;
    N2: TMenuItem;
    PopItem_Exit: TMenuItem;
    CheckBox_AutoHide: TCheckBox;
    Label2: TLabel;
    SpinEdit_Port: TSpinEdit;
    Timer_FormCount: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_StartClick(Sender: TObject);
    procedure Button_StopClick(Sender: TObject);
    procedure PopItem_ExitClick(Sender: TObject);
    procedure PopItem_ShowClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Timer_FormCountTimer(Sender: TObject);
  private
    FInitialized   : Boolean;
  public
    procedure Display(const Msg : String);
  protected
  end;

var
     MainForm            : TMainForm;

implementation

{$R *.DFM}



procedure TMainForm.FormShow(Sender: TObject);
var
     IniFile   : TIniFile;
     bAutoHide : Boolean;
begin
     if not FInitialized then begin
          FInitialized := TRUE;

          //从INI中恢复
          IniFile   := TIniFile.Create(gsMainDir+'deweb.ini');
          giPort    := IniFile.ReadInteger('Config', 'Port',8080);
          bAutoHide := IniFile.ReadBool('Config','AutoHide',False);
          IniFile.Destroy;

          //ClientCountLabel.Caption := '0 clients';
          //
          CheckBox_AutoHide.Checked  := bAutoHide;
          if bAutoHide then begin
               Timer_Hide.Enabled  := True;
          end;
          SpinEdit_Port.Value := giPort;


          //自动启动
          Button_Start.OnClick(Self);
     end;
end;


procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    IniFile : TIniFile;
begin
    //保存配置
    IniFile := TIniFile.Create(gsMainDir+'deweb.ini');
    IniFile.WriteInteger('Config',    'Port', giPort);
    IniFile.Destroy;
end;



procedure TMainForm.FormCreate(Sender: TObject);
begin
     gsMainDir := ExtractFilePath(Application.ExeName);
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     //

end;

{ Display a message in display memo box, making sure we don't overflow it.  }
procedure TMainForm.Display(const Msg : String);
begin
end;



procedure TMainForm.Button_StartClick(Sender: TObject);
begin
     giPort    := SpinEdit_Port.Value;
     if dwStart(giPort) = 0 then begin
          Button_Start.Enabled     := False;
          Button_Stop.Enabled      := not Button_Start.Enabled;
          SpinEdit_Port.Enabled    := Button_Start.Enabled;
     end;
end;



procedure TMainForm.Button_StopClick(Sender: TObject);
begin
     dwStop;
     //
     Button_Start.Enabled     := True;
     Button_Stop.Enabled      := not Button_Start.Enabled;
     SpinEdit_Port.Enabled    := Button_Start.Enabled;
end;



procedure TMainForm.PopItem_ExitClick(Sender: TObject);
begin
     Close;

end;

procedure TMainForm.PopItem_ShowClick(Sender: TObject);
begin
     Self.Visible   := True;
end;

procedure TMainForm.Timer_FormCountTimer(Sender: TObject);
var
     I    : Integer;
begin
     Caption   := 'DeWeb --- Count : '+ IntToStr(Screen.FormCount-2);
     //隐藏窗体
     for I:=2 to Screen.FormCount-1 do begin
          Screen.Forms[I].Left     := 13000;
     end;
end;

initialization
    RegisterClass(TDFW);
    RegisterClass(TDFW_Thread);
    RegisterClass(TDFW_User);
    RegisterClass(TDFW_Login);
    //
    RegisterClass(TDriver);
    RegisterClass(TTest);
    RegisterClass(TDWSDK);
    RegisterClass(TDefault);
    RegisterClass(TForm_OnlineTestSystem);
    RegisterClass(TForm4);
    RegisterClass(TLogin);
    RegisterClass(TDemos);

finalization
    UnRegisterClass(TDFW);
    UnRegisterClass(TDFW_Thread);
    UnRegisterClass(TDFW_User);
    UnRegisterClass(TDFW_Login);
    //
    UnRegisterClass(TDriver);
    UnRegisterClass(TTest);
    UnRegisterClass(TDWSDK);
    UnRegisterClass(TDefault);
    UnRegisterClass(TForm_OnlineTestSystem);
    UnRegisterClass(TForm4);
    UnRegisterClass(TLogin);
    UnRegisterClass(TDemos);


end.

