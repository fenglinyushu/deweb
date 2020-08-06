unit TestUnit;

interface

uses
     dwCore,
     dwCtrlBase,
     dwDatas,

     //
     SynCommons,

     //
     Forms,
     Windows, Classes, Controls, StdCtrls, Menus ;

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
    procedure FormCreate(Sender: TObject);
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
     dwSetCompLTWH(MainMenu1,10,10,Width-20,40);
end;

end.
