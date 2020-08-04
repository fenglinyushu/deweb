unit TestUnit;

interface

uses
     dwCore,
     dwDatas,

     //
     SynCommons,

     //
     Forms,
     Windows, Classes, Controls, StdCtrls ;

type
  TTest = class(TForm)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

end.
