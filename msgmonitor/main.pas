unit main;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, StdCtrls, ComCtrls;

type
TMsgMonitor = class(TForm)
    Memo_Msg: TMemo;
    Button1: TButton;
    ListView: TListView;
    procedure Button1Click(Sender: TObject);
    procedure ListViewClick(Sender: TObject);

private
    { Private declarations }
public
    procedure MyCopyDataMsg(Var Msg : TMessage); Message WM_COPYDATA;
end;

var
MsgMonitor: TMsgMonitor;

implementation

{$R *.dfm}

procedure TMsgMonitor.Button1Click(Sender: TObject);
begin
     ListView.Items.Clear;
     Memo_Msg.Lines.Clear;
end;

procedure TMsgMonitor.ListViewClick(Sender: TObject);
begin
     if ListView.Selected <> nil then begin
          Memo_Msg.Text  := ListView.Selected.SubItems[0];
     end;

end;

procedure TMsgMonitor.MyCopyDataMsg(var Msg: TMessage);
var
     cdds      : TcopyDataStruct;
     sCaption  : string;
     slError   : TStringList;
     iItem     : Integer;
begin
     if msg.Msg = WM_COPYDATA then begin
          cdds := PcopyDataStruct(Msg.LParam)^;
          //Memo_Msg.Lines.Add(Pchar(cdds.lpData));
          with ListView.Items.Add do begin
               Caption   := FormatDateTime('hh:mm:ss',Now);
               SubItems.Add(Pchar(cdds.lpData));
               sCaption  := SubItems[0];
          end;
          //
          ListView.ItemIndex  := ListView.Items.Count-1;
          ListView.Selected.MakeVisible(True);

          //
          if Copy(sCaption,1,7)='[ERROR]' then begin
               slError   := TStringList.Create;
               for iItem := 0 to ListView.Items.Count-1 do begin
                    slError.Add(ListView.Items[iItem].Caption+' , '+ListView.Items[iItem].SubItems[0] );
               end;
               slError.SaveToFile('c:\'+IntToStr(gettickCount)+'.csv');
               slError.Destroy;
          end;
     end;
end;



end.
