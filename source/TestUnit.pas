unit TestUnit;

interface

uses
     dwCore,
     dwCtrlBase,
     dwDatas,

     //
     SynCommons,

     //
     Forms, SysUtils,
     Windows, Classes, Controls, StdCtrls, Menus, ExtCtrls, 
     Series, TeeProcs, Chart, TeEngine, ComCtrls ;

type
  TTest = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Edit7: TEdit;
    Edit1: TEdit;
    Button2: TButton;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
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

procedure TTest.Button1Click(Sender: TObject);
begin
     //dwShowMessage('dwOK!',self);
     Button1.Caption     := 'ÖÐ'+IntToStr(GetTickCount mod 1000);
     Edit7.Text          := '±à¼­'+IntToStr(GetTickCount mod 1000);
end;

procedure TTest.Edit7Change(Sender: TObject);
begin
     //
     dwShowMessage(Edit7.Text,self);
end;

procedure TTest.Edit1Enter(Sender: TObject);
begin
     Button2.Caption     := '½øÈë';
end;

end.

