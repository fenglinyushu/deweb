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
    Button76: TButton;
    Button77: TButton;
    Button78: TButton;
    Button80: TButton;
    Button81: TButton;
    CheckBox12: TCheckBox;
    SpinEdit1: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button78Click(Sender: TObject);
    procedure Button76Click(Sender: TObject);
    procedure Button77Click(Sender: TObject);
    procedure Button81Click(Sender: TObject);
    procedure Button80Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
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

procedure TTest.Button76Click(Sender: TObject);
begin
     SpinEdit1.Visible   := not SpinEdit1.Visible;

end;

procedure TTest.Button77Click(Sender: TObject);
begin
     SpinEdit1.Enabled   := not SpinEdit1.Enabled;

end;

procedure TTest.Button78Click(Sender: TObject);
begin
     with SpinEdit1 do begin
          Left      := Left + 20;
          Top       := Top + 20;
          Width     := Width + 20;
          Height    := Height + 20;
     end;


end;

procedure TTest.Button80Click(Sender: TObject);
begin
     dwShowMessage(IntToStr(SpinEdit1.Value),self);
end;

procedure TTest.Button81Click(Sender: TObject);
begin
     SpinEdit1.Value     := SpinEdit1.Value+1;

end;

procedure TTest.FormCreate(Sender: TObject);
begin
     Top  := 0;

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


procedure TTest.SpinEdit1Change(Sender: TObject);
begin
     if CheckBox12.Checked then begin
          dwShowMessage('cur val = '+IntToStr(SpinEdit1.Value),self);
     end;

end;

end.

