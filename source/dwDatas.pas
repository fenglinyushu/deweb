unit dwDatas;

interface

uses
  SysUtils, Classes, DB, ADODB, ZConnection;

type
  TDM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    ZConnection: TZConnection;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}



procedure TDM.DataModuleCreate(Sender: TObject);
begin

     ZConnection    := TZConnection.Create(self);
     with ZConnection do begin
          DataBase       := 'deweb.db';
          port           := 3306;
          Protocol       := 'sqlite-3';
          Connect;
     end;
end;

end.
