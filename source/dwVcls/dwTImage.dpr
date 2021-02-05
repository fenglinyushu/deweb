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
          //
          if Assigned(TImage(ACtrl).OnMouseEnter) then begin
               TImage(ACtrl).OnMouseEnter(TImage(ACtrl));
          end;
     end else if joData.event = 'onexit' then begin
          //
          if Assigned(TImage(ACtrl).OnMouseLeave) then begin
               TImage(ACtrl).OnMouseLeave(TImage(ACtrl));
          end;
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

     //�õ�Բ�ǰ뾶��Ϣ
     sRadius   := dwGetHintValue(joHint,'radius','border-radius','');
     sRadius   := StringReplace(sRadius,'=',':',[]);
     sRadius   := Trim(StringReplace(sRadius,'"','',[rfReplaceAll]));
     if sRadius<>'' then begin
          sRadius   := sRadius + ';';
     end;

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
                         +dwIIF(Assigned(OnClick),'cursor: pointer;','')
                         +'"'
                         +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +dwIIF(Assigned(OnMouseEnter),Format(_DWEVENT,['mouseenter.native',Name,'0','onenter','']),'')
                         +dwIIF(Assigned(OnMOuseLeave),Format(_DWEVENT,['mouseleave.native',Name,'0','onexit','']),'')
                         +'>');
          end else begin
               if Stretch then begin
                    joRes.Add('<el-image :src="'+Name+'__src" fit="fill"'
                              +dwVisible(TControl(ACtrl))
                              +dwDisable(TControl(ACtrl))
                              +dwLTWH(TControl(ACtrl))
                              +sRadius
                              +dwIIF(Assigned(OnClick),'cursor: pointer;','')
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                              +dwIIF(Assigned(OnMouseEnter),Format(_DWEVENT,['mouseenter.native',Name,'0','onenter','']),'')
                              +dwIIF(Assigned(OnMOuseLeave),Format(_DWEVENT,['mouseleave.native',Name,'0','onexit','']),'')
                         +'>');
               end else begin
                    joRes.Add('<el-image :src="'+Name+'__src" fit="none"'
                              +dwVisible(TControl(ACtrl))
                              +dwDisable(TControl(ACtrl))
                              +dwLTWH(TControl(ACtrl))
                              +sRadius
                              +dwIIF(Assigned(OnClick),'cursor: pointer;','')
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                              +dwIIF(Assigned(OnMouseEnter),Format(_DWEVENT,['mouseenter.native',Name,'0','onenter','']),'')
                              +dwIIF(Assigned(OnMOuseLeave),Format(_DWEVENT,['mouseleave.native',Name,'0','onexit','']),'')
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

//ȡ��Data
function dwGetData(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TImage(ACtrl) do begin
          joRes.Add(Name+'__lef:"'+IntToStr(Left)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(Top)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Width)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Height)+'px",');
          //
          joRes.Add(Name+'__vis:'+dwIIF(Visible,'true,','false,'));
          joRes.Add(Name+'__dis:'+dwIIF(Enabled,'false,','true,'));
          //
          if dwGetProp(TControl(ACtrl),'src')='' then begin
               joRes.Add(Name+'__src:"dist/webimages/'+Name+'.jpg",');
          end else begin
               joRes.Add(Name+'__src:"'+dwGetProp(TControl(ACtrl),'src')+'",');
          end;
     end;
     //
     Result    := (joRes);
end;

function dwGetMethod(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TImage(ACtrl) do begin
          joRes.Add('this.'+Name+'__lef="'+IntToStr(Left)+'px";');
          joRes.Add('this.'+Name+'__top="'+IntToStr(Top)+'px";');
          joRes.Add('this.'+Name+'__wid="'+IntToStr(Width)+'px";');
          joRes.Add('this.'+Name+'__hei="'+IntToStr(Height)+'px";');
          //
          joRes.Add('this.'+Name+'__vis='+dwIIF(Visible,'true;','false;'));
          joRes.Add('this.'+Name+'__dis='+dwIIF(Enabled,'false;','true;'));
          //
          if dwGetProp(TControl(ACtrl),'src')='' then begin
               joRes.Add('this.'+Name+'__src="dist/webimages/'+Name+'.jpg";');
          end else begin
               joRes.Add('this.'+Name+'__src="'+dwGetProp(TControl(ACtrl),'src')+'";');
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
     dwGetMethod,
     dwGetData;
     
begin
end.
 
