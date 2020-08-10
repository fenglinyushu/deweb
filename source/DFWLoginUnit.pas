unit DFWLoginUnit;

interface

uses
     dwCore,
     dwCtrlBase,

     //
     ZAbstractRODataset, ZDataset,

     
     //
     Math,
     Windows, Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, StdCtrls, ExtCtrls, jpeg, DB ;

type
  TDFW_Login = class(TForm)
    Panel_Mail: TPanel;
    Label_MailBox: TLabel;
    Edit_UserName: TEdit;
    Panel_Psd: TPanel;
    Label_Psd: TLabel;
    Edit_Psd: TEdit;
    Panel_Buttons: TPanel;
    Button_Login: TButton;
    Panel_00_Head: TPanel;
    Img_dfw: TImage;
    Panel6: TPanel;
    Panel_All: TPanel;
    ZQuery: TZReadOnlyQuery;
    procedure Button_LoginClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DFW_Login: TDFW_Login;

implementation

{$R *.dfm}

procedure TDFW_Login.Button_LoginClick(Sender: TObject);
var
     sSalt     : string;
     sPsd      : string;
begin
     if (Trim(Edit_Psd.text) = '') or (Trim(Edit_UserName.text) = '') then begin
          dwShowMessage('用户名/密码不能为空',Self);
          Exit;
     end;

     ZQuery.Close;
     ZQuery.SQL.Text     := 'SELECT uid,salt,password FROM bbs_user WHERE username='''+AnsiToUtf8(Edit_UserName.Text)+'''';
     ZQuery.Open;

     //
     if ZQuery.IsEmpty then begin
          dwShowMessage('用户名或密码不正确!',Self);
     end else begin
          sSalt     := ZQuery.FieldByName('salt').AsString;
          sPsd      := ZQuery.FieldByName('password').AsString;
          //
          if dwGetMD5(dwGetMD5(Edit_Psd.text)+sSalt)=sPsd then begin
               //dwShowMessage('感谢惠顾!',Self);
               dwNavigate('dfw.dw?uid=' + ZQuery.FieldByName('uid').AsString+'&&name='+dwescape(Edit_UserName.text),False,self);
          end else begin
               dwShowMessage('用户名或密码不正确!',Self);
          end;
     end;

end;

procedure TDFW_Login.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     //
     if  ((X>700) and (Y>700)) then begin
          Panel_All.BorderStyle    := bsSingle;
          Panel_All.Top            := 20;

     end else begin      
          Panel_All.BorderStyle    := bsNone;
          Panel_All.Top            := 0;
          Width     := X;
          Height    := 457;
     end;
end;

end.
