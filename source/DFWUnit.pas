unit DFWUnit;

interface

uses
     SynCommons,
     //SynDB,SynDBZeos,

     //
     CloneComponents,

     //
     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, jpeg, ExtCtrls, StdCtrls, DB, ZAbstractRODataset, ZDataset,
  ZConnection;

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
    Label_ReplyTime: TLabel;
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
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Edit6: TEdit;
    ZConnection: TZConnection;
    ZReadOnlyQuery_Threads: TZReadOnlyQuery;
    StaticText_Subject: TStaticText;
    StaticText_Uper: TStaticText;
    StaticText_LastPost: TStaticText;
    Label_New: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
     DFW  : TDFW;

implementation

{$R *.dfm}

procedure TDFW.FormCreate(Sender: TObject);
var
     iItem     : Integer;
     oPanel    : TPanel;
begin
     //设置TOP, 以修正编辑时的更改
     Top  := 0;

     //打开数据表
     ZConnection.Connect;
     ZReadOnlyQuery_Threads.SQL.Text:='Set Names GB2312';
     ZReadOnlyQuery_Threads.ExecSQL;
     ZReadOnlyQuery_Threads.SQL.Text    := 'SELECT a.tid,a.subject,a.posts,a.views,a.lastpid,a.uid,b.username,c.username lastname '
               +'FROM bbs_thread a,bbs_user b,bbs_user c '
               +'WHERE a.uid=b.uid and a.uid=c.uid '
               +'ORDER BY last_date DESC '
               +'LIMIT 0,20';
     ZReadOnlyQuery_Threads.Open;


     //显示
     for iItem := 0 to 19 do begin
          oPanel    := TPanel(CloneComponent(Panel_Thread));
          oPanel.Visible := True;
          oPanel.Top     := 9900+iItem;
          //积分
          TLabel(Self.FindComponent('Label_Score'+IntToStr(iItem+1))).Caption := '';//ZReadOnlyQuery_Threads.FieldByName('subject').AsString;
          //主题
          with TStaticText(Self.FindComponent('StaticText_Subject'+IntToStr(iItem+1))) do begin
               Caption   := Trim(ZReadOnlyQuery_Threads.FieldByName('subject').AsString);
               Hint      := '{"href":"http://www.web0000.com:8080/dfw_thread.dw?tid='+ZReadOnlyQuery_Threads.FieldByName('tid').AsString+'"}';
          end;

          //题主
          with TStaticText(Self.FindComponent('StaticText_Uper'+IntToStr(iItem+1))) do begin
               Caption := ZReadOnlyQuery_Threads.FieldByName('username').AsString;
               Hint      := '{"href":"http://www.web0000.com:8080/dfw_user.dw?uid='+ZReadOnlyQuery_Threads.FieldByName('uid').AsString+'"}';
          end;
          
          //回复/阅读
          TLabel(Self.FindComponent('Label_ReplyRead'+IntToStr(iItem+1))).Caption := ZReadOnlyQuery_Threads.FieldByName('posts').AsString
               +'/'+ZReadOnlyQuery_Threads.FieldByName('views').AsString;

          //提问
          with TStaticText(Self.FindComponent('StaticText_LastPost'+IntToStr(iItem+1))) do begin
               Caption := ZReadOnlyQuery_Threads.FieldByName('lastname').AsString;
               Hint      := '{"href":"http://www.web0000.com:8080/dfw_user.dw?uid='+ZReadOnlyQuery_Threads.FieldByName('lastpid').AsString+'"}';
          end;

          //
          ZReadOnlyQuery_Threads.Next;
     end;
     Panel_Pages.Top     := 9999;
end;
{var
     gProps    : TSQLDBConnectionProperties;
     rows      : ISQLDBRows;
begin
     Top  := 0;
     //
     gProps    := TSQLDBZEOSConnectionProperties.Create(
          'zdbc:mysql://qdm165429402.my3w.com/qdm165429402_db?username=qdm165429402;'+
          'password=wghcgljt2210459;LibLocation=libmysql.dll', '', '', '');

     if gProps.
     rows := gProps.ExecuteInlined('select top 5 * from bbs_thread',  True);
     if rows<>nil then
          while rows.Step() do
               showmessage(rows.ColumnString('subject'));
const
  MYSQL_CONSTR = 'zdbc:mysql://%s:%d/%s?username=%s;password=%s;LibLocation=libmysql.dll';
var
  constr, dbserver, dbdatabase, dbusername, dbpassword: string;
  dbport: Integer;
    fProps: TSQLDBConnectionProperties;
     rows      : ISQLDBRows;
begin
  // 连接数据库
  dbserver     := 'qdm165429402.my3w.com';
  dbdatabase   := 'qdm165429402_db';
  dbusername   := 'qdm165429402';
  dbpassword   := 'wghcgljt2210459';
  dbport       := 3306;
  constr       := Format(MYSQL_CONSTR, [dbserver, dbport, dbdatabase, dbusername, dbpassword]);
  try
    fProps := TSQLDBZEOSConnectionProperties.Create(constr, '', '', '');
     rows := fProps.ExecuteInlined('select top 5 * from bbs_thread',  True);
     if rows<>nil then
          while rows.Step() do
               showmessage(rows.ColumnString('subject'));
  except
    raise Exception.Create('数据连接失败,请检数据库查配置参数!');
  end;

end;
}

end.
