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
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Panel1: TPanel;
    Label_deweb: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Default: TDefault;

implementation

{$R *.dfm}

procedure TDefault.FormCreate(Sender: TObject);
begin
     //…Ë÷√≤Àµ•µƒLeft/Top/Width/Height
     dwSetCompLTWH(MainMenu1,0,50,200,550);
     Top  := 0;
end;

end.
