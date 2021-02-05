unit unit1;

interface

uses
     //
     dwBase,
     cnDes,

     //
     HttpApp,
     ADODB,DB,
     Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
     Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
     Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label_Title: TLabel;
    Label_User: TLabel;
    Edit_User: TEdit;
    Label_Psd: TLabel;
    Edit_Psd: TEdit;
    Button_Login: TButton;
    Img_course: TImage;
    Panel_line: TPanel;
    CheckBox_Remember: TCheckBox;
    ADOQuery: TADOQuery;
    procedure Button_LoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;



implementation

{$R *.dfm}


function _GetADOConnection:TADOConnection;
type
     PdwGetConn   = function ():TADOConnection;StdCall;
var
     iDll      : Integer;
     //
     fGetConn  : PdwGetConn;
begin
     Result    := nil;
     //�õ�ADOConnection
     if FileExists('dwADOConnection.dll') then begin
          iDll      := LoadLibrary('dwADOConnection.dll');
          fGetConn  := GetProcAddress(iDll,'dwGetConnection');

          Result    := fGetConn;
     end;

end;


procedure TForm1.Button_LoginClick(Sender: TObject);
var
     sSalt     : string;
     sPassword : string;
     iTicks    : Integer;
     sName     : string;
     sCode     : string;
begin
     //�����ݱ�
     ADOQuery.Close;
     ADOQuery.SQL.Text   := 'SELECT * FROM member WHERE username='''+Edit_User.Text+'''';
     ADOQuery.Open;

     //
     if ADOQuery.IsEmpty then begin
          dwShowMessage('�û��������벻��ȷ��',self);
     end else begin
          //ȡ�����ݱ���salt������
          sSalt     := ADOQuery.FieldByName('salt').AsString;
          sPassword := ADOQuery.FieldByName('password').AsString;
          sName     := Edit_User.Text;

          //���SALT
          if sSalt = '' then begin
               iTicks    := GetTickCount;
               sCode     := EncryptStr(sName,iTicks mod 65536);
               //������ҳ
               dwOpenUrl(self,'/change.dw?'+sName+'&&'+IntToStr(iTicks)+'&&'+sCode,'_self');
          end else begin
               //sPassword := dwGetMD5(dwGetMD5(Edit_Psd.Text)+sSalt)

               if sPassword = dwGetMD5(dwGetMD5(Edit_Psd.Text)+sSalt) then begin
                    //����ǰ��¼�û���Ϣд��cookie��ʵ��ʹ��ʱ�����ȼ��ܣ���д�룩
                    if CheckBox_Remember.Checked then begin
                         dwSetCookie(self,'mpuser',Edit_User.Text,24*30);  //һ����
                    end else begin
                         dwSetCookie(self,'mpuser',Edit_User.Text,1);      //һСʱ
                    end;

                    //������ҳ
                    dwOpenUrl(self,'/course.dw','_self');
               end else begin
                    dwShowMessage('�û��������벻��ȷ ��',self);
               end;
          end;
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     ADOQuery.Connection := _GetADOConnection;
end;

procedure TForm1.FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
var
     sValue    : string;
begin
     sValue    := dwGetProp(self,'interactionvalue');
     sValue    := HttpDecode(sValue);
     //
     dwShowMessage('Value : '+sValue,self);
end;

end.
