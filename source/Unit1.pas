unit Unit1;

interface

uses
     dwCore,

     //
     Math,
  Windows, Messages, SysUtils, Variants, StdCtrls, Graphics, ExtCtrls,
  Controls, Forms, Dialogs, Classes ;

type
  TDefault = class(TForm)
    Panel_Content: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel_Banner: TPanel;
    Panel1: TPanel;
    Img: TImage;
    Label_deweb: TLabel;
    Label_DWP: TLabel;
    Panel_Space1: TPanel;
    Panel3: TPanel;
    Button_Next: TButton;
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button_NextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Default: TDefault;

implementation

{$R *.dfm}

procedure TDefault.Button_NextClick(Sender: TObject);
begin
     dwCreateForm('TDWSDK',Self.Handle);
end;

procedure TDefault.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     //
     if (X>700) and (Y>700) then begin
          //PC等高分辨率

          //
          Panel_Content.Top        := 30;
          Panel_Content.Height     := Height-60;


          Width     := X;
          Height    := Y;

          Label1.AutoSize       := False;
          Label1.AutoSize       := True;
          Label1.Height         := Label1.Height +20;

          //
          Label2.AutoSize       := False;
          Label2.AutoSize       := True;
          Label2.Height         := Label2.Height +20;

          //
          Label3.AutoSize       := False;
          Label3.AutoSize       := True;
          Label3.Height         := Label3.Height +20;

     end else begin
          if (Button = mbLeft) and (Y>X) then begin//屏幕纵向
               ////移动设备 纵向
               Width     := X;
               Height    := Y;

               //
               Panel_Content.Top        := 30;
               Panel_Content.Height     := Height-60;



               Label1.AutoSize       := False;
               Label1.AutoSize       := True;
               Label1.Height         := Label1.Height +20;

               //
               Label2.AutoSize       := False;
               Label2.AutoSize       := True;
               Label2.Height         := Label2.Height +20;

               //
               Label3.AutoSize       := False;
               Label3.AutoSize       := True;
               Label3.Height         := Label3.Height +20;
          end else begin
               ////移动设备 横向

               Width     := Max(X,Y);
               Height    := Min(X,Y);

               //
               Panel_Content.Top        := 0;
               Panel_Content.Height     := Height;

               //
               Label1.AutoSize       := False;
               Label1.AutoSize       := True;
               Label1.Height         := Label1.Height +10;

               //
               Label2.AutoSize       := False;
               Label2.AutoSize       := True;
               Label2.Height         := Label2.Height +10;

               //
               Label3.AutoSize       := False;
               Label3.AutoSize       := True;
               Label3.Height         := Label3.Height +10;
          end;

     end;
end;

end.
