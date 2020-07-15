unit dwDatas;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM = class(TDataModule)
    ADOConnection_Driver: TADOConnection;
    ADOQuery_Driver: TADOQuery;
    ADOTable1: TADOTable;
  private
    { Private declarations }
  public
     procedure ExeAQ(AQ: TADOQuery; S: String);
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.ExeAQ(AQ: TADOQuery; S: String);
begin
     //
     try
          AQ.Close;
          AQ.SQL.Text    := S;
          if Copy(Lowercase(S),1,7)='select ' then begin
               AQ.Open;
          end else begin
               AQ.ExecSQL;
          end;
     except
          //ShowMessage(S);
     end;

end;


end.
