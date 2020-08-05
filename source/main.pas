unit Main;


interface

uses
     //
     dwVars,
     dwCore,
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

     //
     SynCommons,
     OverbyteIcsWinSock,  OverbyteIcsWSocket, OverbyteIcsWndControl,
     OverbyteIcsHttpSrv, OverbyteIcsUtils, OverbyteIcsFormDataDecoder, OverbyteIcsMimeUtils,

     //
     HTTPApp,
     Windows, Messages, SysUtils, Classes, Controls, Forms,
     StdCtrls, ExtCtrls, StrUtils,
     IniFiles,  jpeg, Menus,  ShellAPI,  Spin;


type
  TMainForm = class(TForm)
    DisplayMemo: TMemo;
    Panel_Buttons: TPanel;
    Button_Start: TButton;
    Button_Stop: TButton;
    ClearButton: TButton;
    Button1: TButton;
    Label3: TLabel;
    Panel_WebXone: TPanel;
    Timer_Hide: TTimer;
    PopupMenu: TPopupMenu;
    PopItem_Show: TMenuItem;
    N2: TMenuItem;
    PopItem_Exit: TMenuItem;
    Label1: TLabel;
    CheckBox_AutoHide: TCheckBox;
    Label2: TLabel;
    SpinEdit_Port: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_StartClick(Sender: TObject);
    procedure Button_StopClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure PopItem_ExitClick(Sender: TObject);
    procedure PopItem_ShowClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    FInitialized   : Boolean;
    FCountRequests : Integer;
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
var
    I : Integer;
begin
     if DisplayMemo.Lines.Count > 200 then begin
          with TStringList.Create do begin
               try
                    BeginUpdate;
                    Assign(DisplayMemo.Lines);
                for I := 1 to 50 do
                    Delete(0);
                    DisplayMemo.Lines.Text := Text;
               finally
                    Free;
               end;
          end;
     end;
     DisplayMemo.Lines.Add(Msg);
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



procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
     DisplayMemo.Clear;
end;



procedure TMainForm.PopItem_ExitClick(Sender: TObject);
begin
     Close;

end;

procedure TMainForm.PopItem_ShowClick(Sender: TObject);
begin
     Self.Visible   := True;
end;

initialization
    RegisterClass(TDFW);
    RegisterClass(TDFW_Thread);
    RegisterClass(TDFW_User);
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

