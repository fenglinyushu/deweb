unit TestUnit;

interface

uses
     dwCore,
     SynCommons,
     httpApp,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,Jpeg, DB, ADODB, ComCtrls;

type
  TTest = class(TForm)
    E1: TEdit;
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
