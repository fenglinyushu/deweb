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
      ComCtrls, jpeg,  Grids, DBGrids, DB ;

type
  TTest = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
     Label1.Caption := '��ǩ  '+IntToStr(GetTickCount mod 1000);
end;

procedure TTest.FormCreate(Sender: TObject);
begin
     Top  := 0;

     //
     ZQuery    := TZReadOnlyQUery.Create(Self);
     ZQuery.Connection   := DM.ZConnection;

     //
     ZQuery.SQL.Text     := 'SELECT * FROM Member';  //����,�Ա�,����,����,����,��ַ
     ZQuery.Open;


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

