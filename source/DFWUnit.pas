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
    Panel_10_Content: TPanel;
    Panel_99_Foot: TPanel;
    Panel_01_Menu: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Panel4: TPanel;
    Panel_All: TPanel;
    Panel_Subjects: TPanel;
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
     //����TOP, �������༭ʱ�ĸ���
     Top  := 0;

     //
     giPageNo  := 0;

     //�����ݱ�
     //ZReadOnlyQuery_Threads.SQL.Text:='Set Names GB2312';
     //ZReadOnlyQuery_Threads.ExecSQL;

     //��ʾ
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
     try
          //�����ݱ�
          ZQuery_Threads.Close;
          //ZQuery_Threads.SQL.Text    := 'SELECT a.last_date,a.tid,a.subject,a.posts,a.views,'
          //          +'a.lastpid,a.uid,a.create_date,b.username,c.username lastname '
          //          +'FROM bbs_thread a,bbs_user b,bbs_user c '
          //          +'WHERE a.uid=b.uid and a.lastuid=c.uid '
                    //+'ORDER BY last_date DESC '
                    //+'LIMIT 20 OFFSET '+IntToStr(giPageNo*20)
          //          ;
          ZQuery_Threads.SQL.Text    := 'SELECT a.last_date,a.tid,a.subject,a.posts,a.views,'
                    +'a.lastpid,a.uid,a.create_date'
                    +',b.username'
                    +',c.username lastname'
                    +' FROM bbs_thread a LEFT JOIN bbs_user b ON a.uid=b.uid LEFT JOIN bbs_user c ON a.lastuid=c.uid '
                    +' ORDER BY a.last_date DESC '
                    +' LIMIT 20 OFFSET '+IntToStr(giPageNo*20)
                    ;

          ZQuery_Threads.Open;


          //������ʾ
          for iItem := 0 to 19 do begin
               if ZQuery_Threads.Eof then begin
                    //����
                    TLabel(Self.FindComponent('Label_Score'+IntToStr(iItem+1))).Caption := '';
                    //����
                    with TStaticText(Self.FindComponent('StaticText_Subject'+IntToStr(iItem+1))) do begin
                         Caption   := '';
                         Hint      := '{"href":""}';
                    end;

                    //����
                    with TStaticText(Self.FindComponent('StaticText_Uper'+IntToStr(iItem+1))) do begin
                         Caption   := '';
                         Hint      := '{"href":""}';
                    end;

                    //�ظ�/�Ķ�
                    TLabel(Self.FindComponent('Label_ReplyRead'+IntToStr(iItem+1))).Caption := '';

                    //����
                    with TStaticText(Self.FindComponent('StaticText_LastPost'+IntToStr(iItem+1))) do begin
                         Caption   := '';
                         Hint      := '{"href":""}';
                    end;

                    //���ظ�ʱ��
                    TLabel(Self.FindComponent('Label_LastPostTime'+IntToStr(iItem+1))).Caption := '';

               end else begin
                    //����
                    TLabel(Self.FindComponent('Label_Score'+IntToStr(iItem+1))).Caption := '';
                    //����
                    with TStaticText(Self.FindComponent('StaticText_Subject'+IntToStr(iItem+1))) do begin
                         Caption   := UTF8ToAnsi(Trim(ZQuery_Threads.FieldByName('subject').AsString));
                         Hint      := '{"href":"'+_WEBSITE+'dfw_thread.dw?'
                                   +'tid='+ZQuery_Threads.FieldByName('tid').AsString
                                   +'&&uid='+ZQuery_Threads.FieldByName('uid').AsString
                                   +'&&create_date='+ZQuery_Threads.FieldByName('create_date').AsString
                                   +'&&subject='+dwEscape(UTF8ToAnsi(ZQuery_Threads.FieldByName('subject').AsString))
                                   +'&&uper='+dwEscape(UTF8ToAnsi(ZQuery_Threads.FieldByName('username').AsString))
                                   +'"}';
                    end;

                    //����
                    with TStaticText(Self.FindComponent('StaticText_Uper'+IntToStr(iItem+1))) do begin
                         Caption := UTF8ToAnsi(ZQuery_Threads.FieldByName('username').AsString);
                         Hint      := '{"href":"'+_WEBSITE+'dfw_user.dw?uid='+ZQuery_Threads.FieldByName('uid').AsString+'"}';
                    end;

                    //�ظ�/�Ķ�
                    TLabel(Self.FindComponent('Label_ReplyRead'+IntToStr(iItem+1))).Caption := ZQuery_Threads.FieldByName('posts').AsString
                         +'/'+ZQuery_Threads.FieldByName('views').AsString;

                    //����
                    with TStaticText(Self.FindComponent('StaticText_LastPost'+IntToStr(iItem+1))) do begin
                         Caption := UTF8ToAnsi(ZQuery_Threads.FieldByName('lastname').AsString);
                         Hint      := '{"href":"'+_WEBSITE+'dfw_user.dw?uid='+ZQuery_Threads.FieldByName('lastpid').AsString+'"}';
                    end;

                    //���ظ�ʱ��
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
begin
     {
     X,Y�ֱ��ʾ��ǰ�豸��Width/Height��
     Button : mbLeft : ��Ļ����, mbRight:��Ļ����
     Shift��ssShift, ssAlt, ssCtrl,ssLeft, ssRight,
     �ֱ��Ӧ0:δ֪/1:PC/2:Android/3:iPhone/4:Tablet
     ���⣬��������
     screenWidth����ͨ��dwGetProp(Self,'screenwidth')�õ���
     screenHeight����ͨ��dwGetProp(Self,'screenheight')�õ���
     innerWidth����ͨ��dwGetProp(Self,'innerwidth')�õ���
     innerHeight����ͨ��dwGetProp(Self,'innerheight')�õ���
     clientWidth����ͨ��dwGetProp(Self,'clientwidth')�õ���
     clientHeight����ͨ��dwGetProp(Self,'clientheight')�õ���
     }

     if (X>700)and(Y>700) then begin
          Width     := X;
          Panel_ThreadTitle.Visible     := True;

          //
          for iComp := 0 to Self.ComponentCount-1 do begin
               if Components[iComp].ClassType = TPanel then begin
                    oPanel    := TPanel(Components[iComp]);
                    if not oPanel.ParentBiDiMode then begin
                         dwRealignPanel(oPanel,True);
                    end;
               end;
          end;
     end else begin
          Width     := X;
          Panel_ThreadTitle.Visible     := False;
          //
          for iComp := 0 to Self.ComponentCount-1 do begin
               if Components[iComp].ClassType = TPanel then begin
                    oPanel    := TPanel(Components[iComp]);
                    if not oPanel.ParentBiDiMode then begin
                         dwRealignPanel(oPanel,False);
                    end;
               end;
          end;
     end;
end;

end.
