library dwTEdit;

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

     if joData.event = 'onchange' then begin
          //�����¼�
          TEdit(ACtrl).OnExit    := TEdit(ACtrl).OnChange;
          //����¼�,�Է�ֹ�Զ�ִ��
          TEdit(ACtrl).OnChange  := nil;
          //����ֵ
          TEdit(ACtrl).Text    := dwUnescape(joData.value);
          //�ָ��¼�
          TEdit(ACtrl).OnChange  := TEdit(ACtrl).OnExit;

          //ִ���¼�
          if Assigned(TEdit(ACtrl).OnChange) then begin
               TEdit(ACtrl).OnChange(TEdit(ACtrl));
          end;
     end else if joData.event = 'onenter' then begin
          //�����¼�
          TEdit(ACtrl).OnExit    := TEdit(ACtrl).OnEnter;
          //����¼�,�Է�ֹ�Զ�ִ��
          TEdit(ACtrl).OnEnter  := nil;
          //����ֵ
          TEdit(ACtrl).Text    := dwUnescape(joData.value);
          //�ָ��¼�
          TEdit(ACtrl).OnEnter  := TEdit(ACtrl).OnExit;

          //ִ���¼�
          if Assigned(TEdit(ACtrl).OnEnter) then begin
               TEdit(ACtrl).OnEnter(TEdit(ACtrl));
          end;
     end;

     //���OnExit�¼�
     TEdit(ACtrl).OnExit  := nil;
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
     with TEdit(ACtrl) do begin
          sCode     := '<el-input'
                    +dwVisible(TControl(ACtrl))                            //���ڿ��ƿɼ���Visible
                    +dwDisable(TControl(ACtrl))                            //���ڿ��ƿ�����Enabled(���ֿؼ���֧��)
                    +dwIIF(PasswordChar=#0,'',' show-password')            //�Ƿ�Ϊ����
                    +' v-model="'+Name+'__txt"'                            //ǰ��
                    +dwGetHintValue(joHint,'placeholder','placeholder','') //placeholder,��ʾ��
                    +dwGetHintValue(joHint,'prefix-icon','prefix-icon','') //ǰ��Icon
                    +dwGetHintValue(joHint,'suffix-icon','suffix-icon','') //����Icon
                    +dwLTWH(TControl(ACtrl))                               //Left/Top/Width/Height
                    +'"' // ���style
                    +Format(_DWEVENT,['input',Name,'(this.'+Name+'__txt)','onchange','']) //��OnChange�¼�
                    +Format(_DWEVENT,['focus',Name,'(this.'+Name+'__txt)','onenter',''])  //��OnEnter�¼�
                    +'>';
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
     joRes.Add('</el-input>');          //�˴���Ҫ��dwGetHead��Ӧ
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
     with TEdit(ACtrl) do begin
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          joRes.Add(Name+'__txt'+ASeparator+'"'+(Text)+'"');
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
 
