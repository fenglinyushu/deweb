library dwTRadioButton;

uses
     ShareMem,      //�������

     //
     dwCtrlBase,    //һЩ��������

     //
     SynCommons,    //mormot���ڽ���JSON�ĵ�Ԫ

     //
     SysUtils,
     Classes,
     Dialogs,
     StdCtrls,
     Windows,
     Controls,
     Forms;

//��ǰ�ؼ���Ҫ����ĵ�����JS/CSS ,һ��Ϊ�����Ķ�,Ŀǰ����TChartʹ��ʱ��Ҫ�õ�
function dwGetExtra(ACtrl:TComponent):string;stdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     {
     //������TChartʱ�Ĵ���,���ο�
     joRes.Add('<script src="dist/charts/echarts.min.js"></script>');
     joRes.Add('<script src="dist/charts/lib/index.min.js"></script>');
     joRes.Add('<link rel="stylesheet" href="dist/charts/lib/style.min.css">');
     }

     //
     Result    := joRes;
end;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     joData    : Variant;
begin
     //
     joData    := _Json(AData);

     if joData.event = 'onclick' then begin
          //�����¼�
          TRadioButton(ACtrl).OnExit := TRadioButton(ACtrl).OnClick;
          //����¼�,�Է�ֹ�Զ�ִ��
          TRadioButton(ACtrl).OnClick := nil;
          //����ֵ
          TRadioButton(ACtrl).Checked := dwUnescape(joData.Value)='true';
          //�ָ��¼�
          TRadioButton(ACtrl).OnClick := TRadioButton(ACtrl).OnExit;
          //ִ���¼�
          if Assigned(TRadioButton(ACtrl).OnClick) then begin
               TRadioButton(ACtrl).OnClick(TRadioButton(ACtrl));
          end;
          //���OnExit�¼�
          TRadioButton(ACtrl).OnExit := nil;
     end else if joData.event = 'onenter' then begin
     end;

     //���OnExit�¼�
     TRadioButton(ACtrl).OnExit  := nil;
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(TControl(ACtrl));
     with TRadioButton(ACtrl) do begin
          sCode     := '<el-radio'
                    +' label="1"'       //ѡ��ֵ
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' v-model="'+Name+'__chk"'
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style ���
                    +dwIIF(Assigned(OnClick),Format(_DWEVENT,['change',Name,'(this.'+Name+'__chk)','onclick','']),'')
                    +'>{{'+Name+'__cap}}';
          //��ӵ�����ֵ����
          joRes.Add(sCode);
     end;
     //
     Result    := (joRes);
end;

//ȡ��HTMLβ����Ϣ
function dwGetTail(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //���ɷ���ֵ����
     joRes.Add('</el-radio>');          //�˴���Ҫ��dwGetHead��Ӧ
     //
     Result    := (joRes);
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TComponent;ASeparator:String):string;StdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TRadioButton(ACtrl) do begin
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          joRes.Add(Name+'__cap'+ASeparator+'"'+dwProcessCaption(Caption)+'"');
          joRes.Add(Name+'__chk'+ASeparator+'"'+dwIIF(Checked,'1','0')+'"');
     end;
     //
     Result    := (joRes);
end;


exports
     dwGetExtra,
     dwGetEvent,
     dwGetHead,
     dwGetTail,
     dwGetData;
     
begin
end.
 
