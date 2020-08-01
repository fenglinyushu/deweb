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
     Spin, Grids, DBGrids, Mask, DBCtrls;

type
  TTest = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBText1: TDBText;
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
