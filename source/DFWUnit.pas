unit DFWUnit;

interface

uses
     //
     dwDatas,
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
    Panel_99_Foot: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Panel4: TPanel;
    Panel_All: TPanel;
    Panel_10_Content: TPanel;
    Panel_Thread: TPanel;
    Panel_ThreadTitle: TPanel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Panel_Pages: TPanel;
    Edit_PageNo: TEdit;
    ZQuery_Threads: TZReadOnlyQuery;
    Button_Next: TButton;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel1: TPanel;
    Panel3: TPanel;
    StaticText_Subject: TStaticText;
    Panel5: TPanel;
    StaticText_Uper: TStaticText;
    Label_ReplyRead: TLabel;
    StaticText_LastPost: TStaticText;
    Label_LastPostTime: TLabel;
    Panel6: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Button_NextClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
     _WEBSITE  = '';//http://127.0.0.1/';

implementation

{$R *.dfm}



procedure TDFW.FormCreate(Sender: TObject);
var
     iItem     : Integer;
     oPanel    : TPanel;
begin
     //设置TOP, 以修正编辑时的更改
     Top  := 0;

     //默认为第1页
     giPageNo  := 0;

     //动态生成主题贴
     for iItem := 0 to 19 do begin
          oPanel    := TPanel(CloneComponent(Panel_Thread));
          oPanel.Visible := True;
          oPanel.Top     := 9900+iItem;
     end;
     Panel_Pages.Top     := 9999;

     //
     Panel_10_Content.Height  := Panel_Thread.Height*20 + Panel_ThreadTitle.Height;

     //
     Panel_All.Height    := Panel_10_Content.Height + Panel_00_Head.Height + Panel_99_Foot.Height
          +2*Panel_All.BorderWidth+50;
   

     //
     dwSetHeight(Self,Panel_All.Height);

     //
     UpdateThreads;

end;

procedure TDFW.UpdateThreads;
var
     iItem     : Integer;
begin
     try
          //打开数据表
          ZQuery_Threads.Close;
          ZQuery_Threads.SQL.Text    := 'SELECT a.last_date,a.tid,a.subject,a.posts,a.views,'
                    +'a.lastpid,a.uid,a.create_date'
                    +',b.username'
                    +',c.username lastname'
                    +' FROM bbs_thread a LEFT JOIN bbs_user b ON a.uid=b.uid LEFT JOIN bbs_user c ON a.lastuid=c.uid '
                    +' ORDER BY a.last_date DESC '
                    +' LIMIT 20 OFFSET '+IntToStr(giPageNo*20)
                    ;

          ZQuery_Threads.Open;


          //更新显示
          for iItem := 0 to 19 do begin
               if ZQuery_Threads.Eof then begin
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
                         //Caption   := UTF8ToAnsi(Trim(ZQuery_Threads.FieldByName('subject').AsString));
                         Caption   := dwGetText(UTF8ToAnsi(Trim(ZQuery_Threads.FieldByName('subject').AsString)),90);
                         Hint      := '{"href":"'+_WEBSITE+'dfw_thread.dw?'
                                   +'tid='+ZQuery_Threads.FieldByName('tid').AsString
                                   +'&&uid='+ZQuery_Threads.FieldByName('uid').AsString
                                   +'&&create_date='+ZQuery_Threads.FieldByName('create_date').AsString
                                   +'&&subject='+dwEscape(UTF8ToAnsi(ZQuery_Threads.FieldByName('subject').AsString))
                                   +'&&uper='+dwEscape(UTF8ToAnsi(ZQuery_Threads.FieldByName('username').AsString))
                                   +'"}';
                    end;

                    //题主
                    with TStaticText(Self.FindComponent('StaticText_Uper'+IntToStr(iItem+1))) do begin
                         Caption := UTF8ToAnsi(ZQuery_Threads.FieldByName('username').AsString);
                         Hint      := '{"href":"'+_WEBSITE+'dfw_user.dw?uid='+ZQuery_Threads.FieldByName('uid').AsString+'"}';
                    end;

                    //回复/阅读
                    TLabel(Self.FindComponent('Label_ReplyRead'+IntToStr(iItem+1))).Caption := ZQuery_Threads.FieldByName('posts').AsString
                         +'/'+ZQuery_Threads.FieldByName('views').AsString;

                    //提问
                    with TStaticText(Self.FindComponent('StaticText_LastPost'+IntToStr(iItem+1))) do begin
                         Caption := UTF8ToAnsi(ZQuery_Threads.FieldByName('lastname').AsString);
                         Hint      := '{"href":"'+_WEBSITE+'dfw_user.dw?uid='+ZQuery_Threads.FieldByName('lastpid').AsString+'"}';
                    end;

                    //最后回复时间
                    TLabel(Self.FindComponent('Label_LastPostTime'+IntToStr(iItem+1))).Caption :=
                         FormatDateTime('yyyy-mm-dd',dwPHPToDate(ZQuery_Threads.FieldByName('last_date').AsInteger));

                    //
                    ZQuery_Threads.Next;
               end;
          end;

          //
          Edit_PageNo.Text    := IntToSTr(giPageNo+1);
     except
     end;
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

procedure TDFW.FormMouseUp(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
var
     iComp     : Integer;
     oPanel    : TPanel;
     bLarge    : Boolean;
begin
     {
     X,Y分别表示当前设备的Width/Height；
     Button : mbLeft : 屏幕纵向, mbRight:屏幕横向；
     Shift：ssShift, ssAlt, ssCtrl,ssLeft, ssRight,
     分别对应0:未知/1:PC/2:Android/3:iPhone/4:Tablet
     另外，浏览窗体的
     screenWidth可以通过dwGetProp(Self,'screenwidth')得到；
     screenHeight可以通过dwGetProp(Self,'screenheight')得到；
     innerWidth可以通过dwGetProp(Self,'innerwidth')得到；
     innerHeight可以通过dwGetProp(Self,'innerheight')得到；
     clientWidth可以通过dwGetProp(Self,'clientwidth')得到；
     clientHeight可以通过dwGetProp(Self,'clientheight')得到；
     }

     //是否为大屏显示
     bLarge    := (X>700)and(Y>700);


     Width     := Min(1000,X);
     Panel_ThreadTitle.Visible     := bLarge;

     //
     for iComp := 0 to Self.ComponentCount-1 do begin
          if Components[iComp].ClassType = TPanel then begin
               oPanel    := TPanel(Components[iComp]);
               if not oPanel.ParentBiDiMode then begin
                    dwRealignPanel(oPanel,bLarge);
               end;
          end;
     end;
     
     //
     Panel_10_Content.Height  := Panel_Thread.Height*20 + Panel_ThreadTitle.Height;

     //
     Panel_All.Height    := Panel_10_Content.Height + Panel_00_Head.Height + Panel_99_Foot.Height
          +2*Panel_All.BorderWidth+50;
     //
     dwSetHeight(Self,Panel_All.Height);
end;

end.
