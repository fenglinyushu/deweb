unit TestUnit;

interface

uses
     dwBase,
     dwDatas,

     //
     SynCommons, ZAbstractRODataset, ZDataset,

     //
     Forms, SysUtils,
     Windows, Classes, Controls, StdCtrls, Menus, ExtCtrls, 
      ComCtrls, jpeg,  Grids, DBGrids, DB, Data.Win.ADODB, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Samples.Spin ;

type
  TTest = class(TForm)
    Button1: TButton;
    DBEdit1: TDBEdit;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    DBCheckBox1: TDBCheckBox;
    StringGrid1: TStringGrid;
    Button2: TButton;
    StaticText1: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
     ZQuery: TZReadOnlyQuery;
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

procedure TTest.Button1Click(Sender: TObject);
begin
{     With StaticText1 do begin
          Left      := Left + 20;
          Top       := Top + 20;
          Width     := Width + 20;
          Height    := Height + 20;
          //
          //Checked        := not Checked;
          //
          Caption   := '÷–—‘-'+IntToStr(GetTickCount mod 1000);
     end;
}
     ADOTable1.Next;
{
     Label1.Caption           := '±Í«©  '+IntToStr(GetTickCount mod 1000);
     Edit1.Text               := '±‡º≠  '+IntToStr(GetTickCount mod 999);
     CheckBox1.Checked        := not CheckBox1.Checked;
     RadioButton1.Checked     := checkBox1.Checked;
     //
     dwShowMessage('Hello, DeWeb!',self);
}end;

procedure TTest.Button2Click(Sender: TObject);
begin
     //
     StringGrid1.Cells[StringGrid1.Row,0]    := IntToStr(GetTickCount mod 100);
     StringGrid1.Cells[2,StringGrid1.Row]    := IntToStr(GetTickCount mod 10000);
     StringGrid1.Row     := StringGrid1.Row+1;
end;

procedure TTest.FormCreate(Sender: TObject);
var
     iR,iC     : Integer;
begin
     Top  := 0;

     //
     with StringGrid1 do begin
          for iR := 0 to RowCount-1 do begin
               for iC := 0 to ColCount-1 do begin
                    Cells[iC,iR]   := Format('∫∫%d,%d',[iR,iC]);
               end;
          end;
     end;



{


     Series1.Add(1393);
     Series1.Add(3530);
     Series1.Add(2923);
     Series1.Add(1723);
     Series1.Add(3792);
     Series1.Add(4593);
     //
     Series2.Add(1093);
     Series2.Add(3230);
     Series2.Add(2623);
     Series2.Add(1423);
     Series2.Add(3492);
     Series2.Add(4293);
}

end;


end.

