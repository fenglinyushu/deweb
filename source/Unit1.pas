unit Unit1;

interface

uses
     dwBase,

     //
     Math,
  Windows, Messages, SysUtils, Variants, StdCtrls, Graphics, ExtCtrls,
  Controls, Forms, Dialogs, Classes, Vcl.Menus ;

type
  TDefault = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Default: TDefault;

implementation

{$R *.dfm}

procedure TDefault.Button1Click(Sender: TObject);
begin
     if Timer1.DesignInfo = 1 then begin
          Timer1.DesignInfo   := 0;
     end else begin
          Timer1.DesignInfo   := 1;
     end;
end;

procedure TDefault.FormCreate(Sender: TObject);
begin
     Top  := 0;
end;

procedure TDefault.Timer1Timer(Sender: TObject);
begin
     Button1.caption     := IntToStr(GetTickCount mod 10000);
end;

end.
