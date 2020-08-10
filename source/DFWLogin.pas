unit DFWLogin;

interface

uses
     dwCore,
     //
     Math,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TLogin = class(TForm)
    Panel_Content: TPanel;
    Panel_Logo: TPanel;
    Panel_Mail: TPanel;
    Label_MailBox: TLabel;
    Edit_MailBox: TEdit;
    Panel_Psd: TPanel;
    Label_Psd: TLabel;
    Edit_Psd: TEdit;
    Panel_Buttons: TPanel;
    Button_Login: TButton;
    procedure Button_LoginClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

procedure TLogin.Button_LoginClick(Sender: TObject);
begin
     if Edit_Psd.text = '123' then begin
          dwCreateForm('TForm4',Self.Handle);
     end else begin
          dwShowMessage('The password is 123',Self);
     end;
end;

procedure TLogin.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
     sDevice   : string;
begin
     //得到客户端设备类型
     sDevice   := dwShiftStateToPlatForm(Shift);

     //显示类型
     //Label_OS.Caption    := sDevice+' - '+IntToStr(X)+' / '+IntToStr(Y);


     //
     if  ((X>700) and (Y>700)) then begin
          //
          Width     := X;
          Height    := Y;


          //总框
          Panel_Content.Width      := 500;   //320+100
          Panel_Content.Left       := (Width - Panel_Content.Width) div 2;
          Panel_Content.Top        := 30;
          Panel_Content.Height     := 400;
          Panel_Content.BevelInner := bvRaised;

          //邮箱
          Label_MailBox.Align      := alLeft;
          Label_MailBox.Width      := 100;
          Panel_Mail.Height        := 60;

          //密码
          Label_Psd.Align          := alLeft;
          Label_Psd.Width          := 100;
          Panel_Psd.Height         := 60;


     end else begin      //Android / iPhone
          if (Button = mbLeft) and (Y>X) then begin//屏幕纵向
               //
               Width     := Min(X,Y);
               Height    := Max(X,Y);

               //总框
               Panel_Content.Width      := Width;   //320+100
               Panel_Content.Left       := 0;
               Panel_Content.Top        := 0;
               Panel_Content.Height     := Height;
               Panel_Content.BevelInner := bvNone;

               //邮箱
               Label_MailBox.Align      := alTop;
               Label_MailBox.Height     := 40;
               Panel_Mail.Height        := 100;

               //密码
               Label_Psd.Align          := alTop;
               Label_Psd.Height         := 40;
               Panel_Psd.Height         := 100;

          end else begin      //屏幕横向
               //
               Width     := Max(X,Y);
               Height    := Min(X,Y);


               //总框
               Panel_Content.Width      := Width;   //320+100
               Panel_Content.Left       := 0;
               Panel_Content.Top        := 0;
               Panel_Content.Height     := Height;
               Panel_Content.BevelInner := bvNone;

               //邮箱
               Label_MailBox.Align      := alLeft;
               Label_MailBox.Width      := 100;
               Panel_Mail.Height        := 60;

               //密码
               Label_Psd.Align          := alLeft;
               Label_Psd.Width          := 100;
               Panel_Psd.Height         := 60;
          end;
     end;

end;

end.
