library dwTEdit;

uses
     ShareMem,

     //
     dwCtrlBase,

     //
     SynCommons,

     //
     SysUtils,
     Classes,
     Dialogs,
     StdCtrls,
     Windows,
     Controls,
     Forms;

//��ǰ�ؼ���Ҫ����ĵ�����JS/CSS
function dwGetExtra(ACtrl:TComponent):string;stdCall;
begin
     Result    := '[]';
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
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +dwIIF(PasswordChar=#0,'',' show-password')
                    +' v-model="'+Name+'__txt"'
                    +dwGetHintValue(joHint,'placeholder','placeholder','')         //placeholder
                    +dwGetHintValue(joHint,'prefix-icon','prefix-icon','')         //Icon
                    +dwGetHintValue(joHint,'suffix-icon','suffix-icon','')         //Icon
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style ���
                    +Format(_DWEVENT,['input',Name,'(this.'+Name+'__txt)','onchange',''])
                    +Format(_DWEVENT,['focus',Name,'(this.'+Name+'__txt)','onenter',''])
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
     joRes.Add('</el-input>');
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
 
