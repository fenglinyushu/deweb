library dwTComboBox;

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
          TComboBox(ACtrl).OnExit    := TComboBox(ACtrl).OnChange;
          //����¼�,�Է�ֹ�Զ�ִ��
          TComboBox(ACtrl).OnChange  := nil;
          //����ֵ
          TComboBox(ACtrl).Text    := dwUnescape(joData.value);
          //�ָ��¼�
          TComboBox(ACtrl).OnChange  := TComboBox(ACtrl).OnExit;

          //ִ���¼�
          if Assigned(TComboBox(ACtrl).OnChange) then begin
               TComboBox(ACtrl).OnChange(TComboBox(ACtrl));
          end;

          //���OnExit�¼�
          TComboBox(ACtrl).OnExit  := nil;
     end;
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

     with TComboBox(ACtrl) do begin
          //
          joRes.Add('<el-select'
                    +' v-model="'+Name+'__txt"'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style ���
                    +Format(_DWEVENT,['change',Name,'this.'+Name+'__txt','onchange',''])
                    +'>');
          joRes.Add('    <el-option v-for="item in '+Name+'__options" :key="item.value" :label="item.value" :value="item.value"/>');

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
     joRes.Add('</el-select>');
     //
     Result    := (joRes);
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TComponent;ASeparator:String):string;StdCall;
var
     joRes     : Variant;
     sCode     : string;
     iItem     : Integer;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TComboBox(ACtrl) do begin
          //����ѡ��
          sCode     := Name+'__options'+ASeparator+'[';
          for iItem := 0 to Items.Count-1 do begin
               sCode     := sCode + '{value:'''+Items[iItem]+'''},';
          end;
          Delete(sCode,Length(sCode),1);
          sCode     := sCode + ']';
          joRes.Add(sCode);
          //
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          if dwGetProp(TControl(ACtrl),'height')='' then begin
               joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          end else begin
               joRes.Add(Name+'__hei'+ASeparator+'"'+dwGetProp(TControl(ACtrl),'height')+'px"');
          end;
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          joRes.Add(Name+'__txt'+ASeparator+'"'+Text+'"');
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
 