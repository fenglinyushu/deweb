unit DFWUserUnit;

interface

uses
     //
     dwBase,

     
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
    Image_User: TImage;
    Panel_00_Head: TPanel;
    Img_dfw: TImage;
    Panel6: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    StaticText_Create_Date: TStaticText;
    StaticText_Login_Date: TStaticText;
    StaticText_Logins: TStaticText;
    StaticText_Threads: TStaticText;
    StaticText_Posts: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
     giTid : Integer;
     giUid : Integer;
     ZQuery    : TZReadOnlyQuery;
  public

    { Public declarations }
  end;

var
  dfw_user: Tdfw_user;

implementation

uses dwDatas;

{$R *.dfm}

procedure Tdfw_user.FormCreate(Sender: TObject);
begin
     Top  := 0;
     //
     ZQuery    := TZReadOnlyQuery.Create(self);
     ZQuery.Connection   := DM.ZConnection;
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

          //�õ�URL����
          sParams   := dwUnescape(dwGetProp(self,'params'));

          //�쳣���
          if sParams = '' then begin
               Exit;
          end;

          //�õ���������
          //uid
          Delete(sParams,1,4);
          giUid     := StrToIntDef(sParams,-1);

          //�����ݱ�
          ZQuery.Close;
          ZQuery.SQL.Text    := 'SELECT uid,username,create_date,login_date,logins,threads,posts '
                    +'FROM bbs_user '
                    +'WHERE uid='+IntToStr(giUid)+' ';
          ZQuery.Open;

          //
          if not ZQuery.IsEmpty then begin
               Label_UserName.Caption   := (ZQuery.FieldByName('username').AsString);
               with StaticText_Create_Date do begin
                    Caption   := FormatDateTime('yyyy-mm-dd',dwPHPToDate(ZQuery.FieldByName('create_date').AsInteger));
                    Hint      := '';//{"href":"dfw_user.dw?uid='+ZQuery.FieldByName('lastuid').AsString+'"}';
               end;
               with StaticText_login_Date do begin
                    Caption   := FormatDateTime('yyyy-mm-dd',dwPHPToDate(ZQuery.FieldByName('login_date').AsInteger));
                    Hint      := '';//{"href":"dfw_user.dw?uid='+ZQuery.FieldByName('lastuid').AsString+'"}';
               end;
               with StaticText_logins do begin
                    Caption   := IntToStr(ZQuery.FieldByName('logins').AsInteger);
                    Hint      := '';//{"href":"dfw_user.dw?uid='+ZQuery.FieldByName('lastuid').AsString+'"}';
               end;
               with StaticText_threads do begin
                    Caption   := IntToStr(ZQuery.FieldByName('threads').AsInteger);
                    Hint      := '{"href":"dfw_userthreads.dw?uid='+ZQuery.FieldByName('uid').AsString+'"}';
               end;
               with StaticText_posts do begin
                    Caption   := IntToStr(ZQuery.FieldByName('posts').AsInteger);
                    Hint      := '{"href":"dfw_userposts.dw?uid='+ZQuery.FieldByName('uid').AsString+'"}';
               end;
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
