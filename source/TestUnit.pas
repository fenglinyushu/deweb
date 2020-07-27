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
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button3: TButton;
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
     RadioButton1.Checked     := not RadioButton1.Checked;
end;

procedure TTest.Button2Click(Sender: TObject);
begin
     if RadioButton1.Checked then begin
          dwShowMessage('True','DeWeb','OK',Self);
     end else begin
          dwShowMessage('False','DeWeb','OK',Self);
     end;

end;

procedure TTest.Button3Click(Sender: TObject);
begin
     RadioButton2.Checked     := not RadioButton2.Checked;

end;

end.
