unit Unit2;

interface

uses
     //
     dwBase,

     //
     Forms, SysUtils,Windows,
     Math, StdCtrls, Graphics, ExtCtrls, Controls, Classes, Vcl.ComCtrls;

type
  Tdwsdk = class(TForm)
    Button1: TButton;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    dwsdk: Tdwsdk;

implementation

{$R *.dfm}

procedure Tdwsdk.Button1Click(Sender: TObject);
begin
     with TreeView1.Items[0] do begin
          Text           := IntToStr(GetTickCount);
          ImageIndex     := ImageIndex + 1;
     end;
     TreeView1.Items[TreeView1.Items.Count-1].Destroy;
end;

procedure Tdwsdk.TreeView1Click(Sender: TObject);
begin
     if TreeView1.Selected = nil then begin
          Exit;
     end;

     //
     Button1.Caption     := TreeView1.Selected.Text;
end;

end.
