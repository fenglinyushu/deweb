unit DFWThreadUnit;

interface

uses
     //
     dwCtrlBase,

     
     //
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  Tdfw_thread = class(TForm)
    Panel_All: TPanel;
    Panel_99_Foot: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Panel4: TPanel;
    Panel_10_Content: TPanel;
    Panel2: TPanel;
    Panel_Subjects: TPanel;
    Panel_Thread: TPanel;
    Label_Score: TLabel;
    Panel_ThreadTitle: TPanel;
    Label106: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label_ThreadTitle: TLabel;
    StaticText_Uper: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dfw_thread: Tdfw_thread;

implementation

{$R *.dfm}

procedure Tdfw_thread.FormCreate(Sender: TObject);
begin
     Top  := 0;
     //

end;

procedure Tdfw_thread.FormShow(Sender: TObject);
var
     sParams   : String;
     
begin

     //得到URL参数
     sParams   := dwUnescape(dwGetProp(self,'params'));

     //

     Label_Score.Caption := sParams;
end;

end.
