unit TestUnit;

interface

uses
     dwCore,
     SynCommons,
     httpApp,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,Jpeg, DB, ADODB, ComCtrls,
  Spin, Grids;

type
  TTest = class(TForm)
    Button1: TButton;
    Button2: TButton;
    TreeView1: TTreeView;
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
