unit TestUnit;

interface

uses
     dwCore,
     dwDatas,

     //
     SynCommons,

     //
     httpApp,
     Windows, Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, StdCtrls, ExtCtrls,Jpeg, DB, ADODB, ComCtrls,
     Spin, Grids, DBGrids;

type
  TTest = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
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
