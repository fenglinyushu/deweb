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
  VCLTee.TeeProcs, VCLTee.Chart, Vcl.WinXCtrls, Vcl.Grids;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    procedure BitBtn1EndDock(Sender, Target: TObject; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.BitBtn1EndDock(Sender, Target: TObject; X, Y: Integer);
begin
     BitBtn1.Caption     := 'Uploaded!';
     Button1.Caption     := 'Uploaded123!';

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     dwRunJS('this.dwInputSubmit("BitBtn1");',self);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     dwShowMessage(BitBtn1.Caption,self);
end;

end.
