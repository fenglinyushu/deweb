unit DFWUserUnit;

interface

uses
     //
     dwCtrlBase,

     
     //
     CloneComponents,
     ZAbstractRODataset, ZDataset,

     //
     Math,
     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, StdCtrls, jpeg, ExtCtrls, DB;

type
  Tdfw_user = class(TForm)
    Panel_All: TPanel;
    Panel_99_Foot: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Panel4: TPanel;
    Panel_00_Title: TPanel;
    Label_UserName: TLabel;
    ZQuery_Users: TZReadOnlyQuery;
    Image_User: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
     giTid : Integer;
     giUid : Integer;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  dfw_user: Tdfw_user;

implementation

{$R *.dfm}

procedure Tdfw_user.FormCreate(Sender: TObject);
begin
     Top  := 0;
     //

end;

procedure Tdfw_user.FormShow(Sender: TObject);
var
     sParams   : String;
     sUper     : string;
     sSubject  : string;

     //
     iCreate   : Integer;
     iPos      : Integer;
     iItem     : Integer;

     
begin
     try

          //得到URL参数
          sParams   := dwUnescape(dwGetProp(self,'params'));

          //异常检测
          if sParams = '' then begin
               Exit;
          end;

          //得到各个参数
          //uid
          Delete(sParams,1,4);
          giUid     := StrToIntDef(sParams,-1);

          //打开数据表
          ZQuery_Users.Close;
          ZQuery_Users.SQL.Text    := 'SELECT username '
                    +'FROM bbs_user '
                    +'WHERE uid='+IntToStr(giUid)+' ';
          ZQuery_Users.Open;

          //
          if not ZQuery_Users.IsEmpty then begin
               Label_UserName.Caption   := UTF8ToAnsi(ZQuery_Users.FieldByName('username').AsString);
          end;
     except

     end;


end;

procedure Tdfw_user.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     Width     := Min(1000,X);

end;

end.
