library dwTImage;

uses
     ShareMem,      //�������

     //
     dwCtrlBase,    //һЩ��������

     //
     SynCommons,    //mormot���ڽ���JSON�ĵ�Ԫ

     //
     SysUtils,DateUtils,ComCtrls, ExtCtrls,
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
          //
          if Assigned(TImage(ACtrl).OnClick) then begin
               TImage(ACtrl).OnClick(TImage(ACtrl));
          end;
     end else if joData.event = 'onenter' then begin
     end;

end;


//ȡ��HTMLͷ����Ϣ
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     sSize     : string;
     sName     : string;
     sRadius   : string;
     //
     joHint    : Variant;
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     //
     sRadius   := dwGetHintValue(joHint,'radius','border-radius','');
     sRadius   := StringReplace(sRadius,'=',':',[]);
     sRadius   := Trim(StringReplace(sRadius,'"','',[rfReplaceAll]));

     with TImage(ACtrl) do begin
          //���û���ֶ�����ͼƬԴ�����Զ����浱ǰͼƬ��������ΪͼƬԴ
          if dwGetProp(TControl(ACtrl),'src')='' then begin
               sName     := 'dist\webimages\'+Name+'.jpg';
               //����ͼƬ������
               if not FileExists(sName) then begin
                    Picture.SaveToFile(sName);
               end;
          end;

          if Proportional then begin
               joRes.Add('<el-image :src="'+Name+'__src" fit="contain"'
                         +dwVisible(TControl(ACtrl))
                         +dwDisable(TControl(ACtrl))
                         +dwLTWH(TControl(ACtrl))
                         +sRadius
                         +'"'
                         +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +'>');
          end else begin
               if Stretch then begin
                    joRes.Add('<el-image :src="'+Name+'__src" fit="fill"'
                              +dwVisible(TControl(ACtrl))
                              +dwDisable(TControl(ACtrl))
                              +dwLTWH(TControl(ACtrl))
                              +sRadius
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +'>');
               end else begin
                    joRes.Add('<el-image :src="'+Name+'__src" fit="none"'
                              +dwVisible(TControl(ACtrl))
                              +dwDisable(TControl(ACtrl))
                              +dwLTWH(TControl(ACtrl))
                              +sRadius
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +'>');
               end;
          end;
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
     joRes.Add('</el-Image>');          //�˴���Ҫ��dwGetHead��Ӧ

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
     with TImage(ACtrl) do begin
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+dwIIF(Enabled,'false','true'));
          //
          if dwGetProp(TControl(ACtrl),'src')='' then begin
               joRes.Add(Name+'__src'+ASeparator+'"dist/webimages/'+Name+'.jpg"');
          end else begin
               joRes.Add(Name+'__src'+ASeparator+'"'+dwGetProp(TControl(ACtrl),'src')+'"');
          end;
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
 
