unit DFWThreadUnit;

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
  Tdfw_thread = class(TForm)
    Panel_All: TPanel;
    Panel_99_Foot: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Panel4: TPanel;
    Panel_10_Posts: TPanel;
    Panel_Post: TPanel;
    Label_Message: TLabel;
    Panel_00_PostBase: TPanel;
    Label_CreateDate: TLabel;
    Panel_00_Title: TPanel;
    Label1: TLabel;
    Label_Room: TLabel;
    Label_ThreadTitle: TLabel;
    StaticText_Poster: TStaticText;
    ZQuery_Posts: TZReadOnlyQuery;
    Panel_Space: TPanel;
    Label_Floor: TLabel;
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
     sUper     : string;
     sSubject  : string;

     //
     iCreate   : Integer;
     iPos      : Integer;
     iItem     : Integer;

     //
     oPanel    : TPanel;
     
begin
     //清空多余
     for iItem := Panel_10_Posts.ControlCount-1 downto 0 do begin
          if TPanel(Panel_10_Posts.Controls[iItem]).Visible then begin
               TPanel(Panel_10_Posts.Controls[iItem]).Destroy;
          end;
     end;

     //tid=294&&create_date=234234&&uid=1324&&subject=还有人学delphi吗。&&uper=kevinlin

     //得到URL参数
     sParams   := dwUnescape(dwGetProp(self,'params'));

     //异常检测
     if sParams = '' then begin
          Exit;
     end;

     //得到各个参数
     //tid
     iPos      := Pos('&&',sParams);
     giTid     := StrToIntDef(Copy(sParams,5,iPos-5),-1);
     Delete(sParams,1,iPos+1);
     //uid
     iPos      := Pos('&&',sParams);
     giuid     := StrToIntDef(Copy(sParams,5,iPos-5),-1);
     Delete(sParams,1,iPos+1);
     //create_date
     iPos      := Pos('&&',sParams);
     giuid     := StrToIntDef(Copy(sParams,13,iPos-13),-1);
     Delete(sParams,1,iPos+1);
     //subject
     iPos      := Pos('&&',sParams);
     sSubject  := Copy(sParams,9,iPos-9);
     Delete(sParams,1,iPos+1+5);
     //
     sUper     := sParams;

     //显示当前主题的基本信息
     Label_ThreadTitle.Caption     := sSubject;
     //StaticText_Uper.Caption       := sUper;
     //StaticText_Uper.Hint          := '{"href":"dfw_user.dw?uid='+IntToStr(giUid)+'"}';
     Label_CreateDate.Caption      := FormatDateTime('yyyy-mm-dd',dwPHPToDate(iCreate));

     //读取post
     ZQuery_Posts.Close;
     ZQuery_Posts.SQL.Text    := 'SELECT a.uid,a.message,a.create_date,b.username'
               +' FROM bbs_post a,bbs_user b'
               +' WHERE a.uid=b.uid AND a.tid='+IntToStr(giTid)
               +' ORDER BY a.pid';
     ZQuery_Posts.Open;
     //
     for iItem := 0 to ZQuery_Posts.RecordCount-1 do begin
          oPanel    := TPanel(CloneComponent(Panel_Post));
          oPanel.Visible      := True;
          oPanel.Top          := 9000;


          //日期
          with TLabel(Self.FindComponent('Label_Floor'+IntToStr(iItem+1))) do begin
               Caption   := IntToStr(iItem+1)+' 楼';
          end;

          //答主
          with TStaticText(Self.FindComponent('StaticText_Poster'+IntToStr(iItem+1))) do begin
               Caption := UTF8ToAnsi(ZQuery_Posts.FieldByName('username').AsString);
               Hint      := '{"href":"dfw_user.dw?uid='+ZQuery_Posts.FieldByName('uid').AsString+'"}';
          end;

          //消息
          with TLabel(Self.FindComponent('Label_Message'+IntToStr(iItem+1))) do begin
               Caption   := dwLongStr(UTF8ToAnsi(ZQuery_Posts.FieldByName('message').AsString));
               AutoSize  := False;
               AutoSize  := True;
               AutoSize  := False;
               Height    := Height + 50;
          end;

          //日期
          with TLabel(Self.FindComponent('Label_CreateDate'+IntToStr(iItem+1))) do begin
               Caption   := FormatDateTime('yyyy-mm-dd hh:MM:ss',dwPHPToDate(ZQuery_Posts.FieldByName('create_date').AsInteger));
          end;
          //
          oPanel.AutoSize     := False;
          oPanel.AutoSize     := True;

          //
          ZQuery_posts.Next;
     end;

     //
     Panel_10_Posts.AutoSize  := False;
     Panel_10_Posts.AutoSize  := True;
     //
     Panel_All.AutoSize  := False;
     Panel_All.AutoSize  := True;
     //
     dwSetHeight(self,Panel_All.Height);
end;

procedure Tdfw_thread.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     Width     := Min(1000,X);
end;

end.
