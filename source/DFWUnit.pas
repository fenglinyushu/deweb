unit DFWUnit;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     CloneComponents,
     ZAbstractRODataset, ZDataset,ZConnection,

     //
     Math,
     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, jpeg, ExtCtrls, StdCtrls, DB;

type
  TDFW = class(TForm)
    Panel_00_Head: TPanel;
    Img_dfw: TImage;
    Panel_10_Content: TPanel;
    Panel_99_Foot: TPanel;
    Panel_01_Menu: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    Panel_Search: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Panel4: TPanel;
    Panel_All: TPanel;
    Label13: TLabel;
    Label12: TLabel;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    Button3: TButton;
    Label11: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label10: TLabel;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    Panel_Subjects: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Panel_Thread: TPanel;
    Label_Score: TLabel;
    Label_ReplyRead: TLabel;
    Label_LastPostTime: TLabel;
    Panel12: TPanel;
    Panel_ThreadTitle: TPanel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Panel_Pages: TPanel;
    Edit_PageNo: TEdit;
    ZConnection: TZConnection;
    ZReadOnlyQuery_Threads: TZReadOnlyQuery;
    StaticText_Subject: TStaticText;
    StaticText_Uper: TStaticText;
    StaticText_LastPost: TStaticText;
    Label_New: TLabel;
    Button_Next: TButton;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Button_NextClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
     giPageNo:Integer;
     procedure UpdateThreads;

    { Public declarations }
  end;

var
     DFW  : TDFW;

const
     _WEBSITE  = 'http://127.0.0.1/';

implementation

{$R *.dfm}

function dfwPHPToDate(ADate:Integer):TDateTime;
begin
     Result    := ((ADate+28800)/86400+25569);
end;


procedure TDFW.FormCreate(Sender: TObject);
var
     iItem     : Integer;
     oPanel    : TPanel;
begin
     //设置TOP, 以修正编辑时的更改
     Top  := 0;

     //
     giPageNo  := 0;

     //打开数据表
     ZConnection.Connect;
     ZReadOnlyQuery_Threads.SQL.Text:='Set Names GB2312';
     ZReadOnlyQuery_Threads.ExecSQL;

     //显示
     for iItem := 0 to 19 do begin
          oPanel    := TPanel(CloneComponent(Panel_Thread));
          oPanel.Visible := True;
          oPanel.Top     := 9900+iItem;
     end;
     Panel_Pages.Top     := 9999;
     
     //
     UpdateThreads;

end;

procedure TDFW.UpdateThreads;
var
     iItem     : Integer;
begin
     //打开数据表
     ZReadOnlyQuery_Threads.Close;
     ZReadOnlyQuery_Threads.SQL.Text    := 'SELECT a.last_date,a.tid,a.subject,a.posts,a.views,a.lastpid,a.uid,b.username,c.username lastname '
               +'FROM bbs_thread a,bbs_user b,bbs_user c '
               +'WHERE a.uid=b.uid and a.lastuid=c.uid '
               +'ORDER BY last_date DESC '
               +'LIMIT '+IntToStr(giPageNo*20)+',20';
     ZReadOnlyQuery_Threads.Open;


     //更新显示
     for iItem := 0 to 19 do begin
          if ZReadOnlyQuery_Threads.Eof then begin
               //积分
               TLabel(Self.FindComponent('Label_Score'+IntToStr(iItem+1))).Caption := '';
               //主题
               with TStaticText(Self.FindComponent('StaticText_Subject'+IntToStr(iItem+1))) do begin
                    Caption   := '';
                    Hint      := '{"href":""}';
               end;

               //题主
               with TStaticText(Self.FindComponent('StaticText_Uper'+IntToStr(iItem+1))) do begin
                    Caption   := '';
                    Hint      := '{"href":""}';
               end;
          
               //回复/阅读
               TLabel(Self.FindComponent('Label_ReplyRead'+IntToStr(iItem+1))).Caption := '';

               //提问
               with TStaticText(Self.FindComponent('StaticText_LastPost'+IntToStr(iItem+1))) do begin
                    Caption   := '';
                    Hint      := '{"href":""}';
               end;

               //最后回复时间
               TLabel(Self.FindComponent('Label_LastPostTime'+IntToStr(iItem+1))).Caption := '';

          end else begin
               //积分
               TLabel(Self.FindComponent('Label_Score'+IntToStr(iItem+1))).Caption := '';
               //主题
               with TStaticText(Self.FindComponent('StaticText_Subject'+IntToStr(iItem+1))) do begin
                    Caption   := Trim(ZReadOnlyQuery_Threads.FieldByName('subject').AsString);
                    Hint      := '{"href":"'+_WEBSITE+'dfw_thread.dw?tid='+ZReadOnlyQuery_Threads.FieldByName('tid').AsString
                              +'&&subject='+dwEscape(ZReadOnlyQuery_Threads.FieldByName('subject').AsString)
                              +'&&uper='+dwEscape(ZReadOnlyQuery_Threads.FieldByName('username').AsString)
                              +'"}';
               end;

               //题主
               with TStaticText(Self.FindComponent('StaticText_Uper'+IntToStr(iItem+1))) do begin
                    Caption := ZReadOnlyQuery_Threads.FieldByName('username').AsString;
                    Hint      := '{"href":"'+_WEBSITE+'dfw_user.dw?uid='+ZReadOnlyQuery_Threads.FieldByName('uid').AsString+'"}';
               end;
          
               //回复/阅读
               TLabel(Self.FindComponent('Label_ReplyRead'+IntToStr(iItem+1))).Caption := ZReadOnlyQuery_Threads.FieldByName('posts').AsString
                    +'/'+ZReadOnlyQuery_Threads.FieldByName('views').AsString;

               //提问
               with TStaticText(Self.FindComponent('StaticText_LastPost'+IntToStr(iItem+1))) do begin
                    Caption := ZReadOnlyQuery_Threads.FieldByName('lastname').AsString;
                    Hint      := '{"href":"'+_WEBSITE+'dfw_user.dw?uid='+ZReadOnlyQuery_Threads.FieldByName('lastpid').AsString+'"}';
               end;

               //最后回复时间
               TLabel(Self.FindComponent('Label_LastPostTime'+IntToStr(iItem+1))).Caption :=
                    FormatDateTime('yyyy-mm-dd',dfwPHPToDate(ZReadOnlyQuery_Threads.FieldByName('last_date').AsInteger));

               //
               ZReadOnlyQuery_Threads.Next;
          end;
     end;

     //
     Edit_PageNo.Text    := IntToSTr(giPageNo+1);

end;

procedure TDFW.Button_NextClick(Sender: TObject);
begin
     Inc(giPageNo);
     UpdateThreads;
end;

procedure TDFW.Button1Click(Sender: TObject);
begin
     giPageNo  := 0;
     UpdateThreads;

end;

procedure TDFW.Button2Click(Sender: TObject);
begin
     giPageNo  := Max(0,giPageNo-1);
     UpdateThreads;

end;

procedure TDFW.Button4Click(Sender: TObject);
begin
     //
end;

procedure TDFW.Button5Click(Sender: TObject);
begin
     giPageNo  := StrToIntDef(Edit_PageNo.Text,giPageNo+1);
     giPageNo  := giPageNo-1;
     UpdateThreads;
end;

end.
