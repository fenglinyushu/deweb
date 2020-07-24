unit TestUnit;

interface

uses
     dwCore,
     SynCommons,
     httpApp,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,Jpeg, DB, ADODB;

type
  TTest = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

procedure TTest.Button1Click(Sender: TObject);
begin
     Edit1.Text     := Edit1.Text+'1';//dwGetProp(Self,'params');
end;

procedure TTest.Button2Click(Sender: TObject);
begin
     dwNavigate('http://127.0.0.1/test.dw?dewebÖÐÎÄweb123',True,Self);
end;

procedure TTest.Button3Click(Sender: TObject);
begin
     RadioButton1.Checked     := not RadioButton1.Checked;
end;

end.
