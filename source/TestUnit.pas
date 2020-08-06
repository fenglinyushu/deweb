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
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    Undo1: TMenuItem;
    reado1: TMenuItem;
    N1: TMenuItem;
    Other1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    A1: TMenuItem;
    B1: TMenuItem;
    AB1: TMenuItem;
    N2: TMenuItem;
    MainMenu2: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    Timer1: TTimer;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
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

procedure TTest.FormCreate(Sender: TObject);
begin
     dwSetCompLTWH(MainMenu1,10,10,Width-20,41);
     dwSetCompLTWH(MainMenu2,10,300,200,300);
end;

procedure TTest.Timer1Timer(Sender: TObject);
begin
     //
     Label1.Caption := IntToStr(GetTickCount);
end;

end.
