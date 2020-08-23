unit Unit1;

interface

uses
     dwBase,

     //
     Math,
  Windows, Messages, SysUtils, Variants, StdCtrls, Graphics, ExtCtrls,
  Controls, Forms, Dialogs, Classes, Vcl.Menus ;

type
  TDefault = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    Panel1: TPanel;
    Label6: TLabel;
    Panel2: TPanel;
    Panel_Line: TPanel;
    Img: TImage;
    Label_Title: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Default: TDefault;

implementation

{$R *.dfm}

procedure TDefault.FormCreate(Sender: TObject);
begin
     Top  := 0;
end;

end.
