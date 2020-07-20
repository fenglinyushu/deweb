unit TestUnit;

interface

uses
     dwCore,
     SynCommons,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,Jpeg, DB, ADODB;

type
  TTest = class(TForm)
    Label1: TLabel;
    RadioButton1: TRadioButton;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    function FormHelp(Command: Word; Data: NativeInt;
      var CallHelp: Boolean): Boolean;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

function TTest.FormHelp(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;
begin
     Label1.Top     := Data +10;
end;


procedure TTest.Button1Click(Sender: TObject);
begin
     Edit1.Text     := dwGetProp(Self,'params');
end;

procedure TTest.Button2Click(Sender: TObject);
begin
     dwNavigate('http://127.0.0.1/test.dw?deweb',True,Self);
end;

end.
