unit TestUnit;

interface

uses
     dwCore,
     dwCtrlBase,
     dwDatas,

     //
     SynCommons,

     //
     Forms, SysUtils,
     Windows, Classes, Controls, StdCtrls, Menus, ExtCtrls ;

type
  TTest = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

procedure TTest.Timer1Timer(Sender: TObject);
begin
     //
     Label1.Caption := IntToStr(GetTickCount);
end;

end.
