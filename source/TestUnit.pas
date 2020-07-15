unit TestUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TTest = class(TForm)
    Label1: TLabel;
    RadioButton1: TRadioButton;
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    CheckBox1: TCheckBox;
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    function FormHelp(Command: Word; Data: NativeInt;
      var CallHelp: Boolean): Boolean;
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

end.
