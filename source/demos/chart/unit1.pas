unit unit1;

interface

uses
     //
     dwBase,

     //
     Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
     Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.MPlayer,
     Vcl.Menus, Vcl.Buttons, Vcl.Samples.Spin, Vcl.Imaging.jpeg,
     Vcl.Imaging.pngimage, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series,
  VCLTee.TeeProcs, VCLTee.Chart;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Chart1: TChart;
    Chart2: TChart;
    Series5: TBarSeries;
    Series6: TBarSeries;
    Panel2: TPanel;
    Chart4: TChart;
    Series7: TPieSeries;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Panel_01_Tile: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Panel_02_Buttons: TPanel;
    Button5: TButton;
    Button_Update: TButton;
    Chart3: TChart;
    Series3: THorizBarSeries;
    Series4: THorizBarSeries;
    Chart5: TChart;
    Series8: TAreaSeries;
    Series9: TAreaSeries;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_UpdateClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button5Click(Sender: TObject);
begin
     Chart1.Legend.Visible   := not Chart1.Legend.Visible;
     Chart2.Legend.Visible   := not Chart2.Legend.Visible;
     Chart3.Legend.Visible   := not Chart3.Legend.Visible;
     Chart4.Legend.Visible   := not Chart4.Legend.Visible;
     Chart5.Legend.Visible   := not Chart5.Legend.Visible;

end;

procedure TForm1.Button_UpdateClick(Sender: TObject);
var
     I    : Integer;
begin

     //
     Randomize;
     Series1.Clear;
     Series2.Clear;
     Series3.Clear;
     Series4.Clear;
     Series5.Clear;
     Series6.Clear;
     Series7.Clear;
     Series8.Clear;
     Series9.Clear;
     for I:= 0 to 9 do begin
          Series1.AddY(Random(100));
          Series2.AddY(Random(100));
          Series3.AddY(Random(100));
          Series4.AddY(Random(100));
          Series5.AddY(Random(100));
          Series6.AddY(Random(100));
          Series8.AddY(Random(100));
          Series9.AddY(Random(100));
          //
          if I<4 then begin
               Series7.AddPie(Random(100),'¶þ³Ì'+IntToStr(I+1)+'²¿');
          end;
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Button_Update.OnClick(self);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
     //
     dwSetHeight(self,1600);

end;

end.
