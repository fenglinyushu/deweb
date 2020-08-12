library dwTPageControl;

uses
     ShareMem,

     //
     dwCtrlBase,

     //
     SynCommons,

     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     StdCtrls, Windows;

//--------------һЩ���ú���------------------------------------------------------------------------
function dwLTWHTab(ACtrl:TControl):String;  //���Ը���λ�õ��÷�
begin

     //
     with ACtrl do begin
          Result    := ' :style="{width:'+Name+'__wid,height:'+Name+'__hei}"'
                    +' style="position:absolute;left:0px;top:0px;';
     end;
end;


//��ǰ�ؼ���Ҫ����ĵ�����JS/CSS
function dwGetExtra(ACtrl:TComponent):string;stdCall;
begin
     Result    := '[]';
end;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     iTab      : Integer;
     joData    : Variant;
begin
     //����AData�ַ�����JSON����
     joData    := _json(AData);

     //�����¼�
     TPageControl(ACtrl).OnExit    := TPageControl(ACtrl).OnChange;

     //����¼�,�Է�ֹ�Զ�ִ��
     TPageControl(ACtrl).OnChange  := nil;
     //����ֵ
     for iTab := 0 to TPageControl(ACtrl).PageCount-1 do begin
          if TPageControl(ACtrl).Pages[iTab].Name = joData.value then begin
               TPageControl(ACtrl).ActivePageIndex     := iTab;
               break;
          end;
     end;
     //�ָ��¼�
     TPageControl(ACtrl).OnChange  := TPageControl(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TPageControl(ACtrl).OnChange) then begin
          TPageControl(ACtrl).OnChange(TPageControl(ACtrl));
     end;

     //���OnExit�¼�
     TPageControl(ACtrl).OnExit  := nil;
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
     iTab      : Integer;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     with TPageControl(ACtrl) do begin
          //���
          joRes.Add('<el-tabs'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' v-model="'+Name+'__apg"'        //ActivePage
                    +' :tab-position="'+Name+'__tps"'  //����λ��
                    +dwIIF(ParentBiDiMode,' type="border-card"','')   //�Ƿ������
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style ���
                    +Format(_DWEVENT,['tab-click',Name,'this.'+Name+'__apg','onchange',''])
                    +'>');
          //���ѡ�
          for iTab := 0 to PageCount-1 do begin
               //
               joRes.Add('    <el-tab-pane label="'+dwConvertStr(Pages[iTab].Caption)+'" name="'+Pages[iTab].name+'">');
               //
               joRes.Add('    </el-tab-pane>');
          end;


          //body��
          joRes.Add('<div'+dwLTWHTab(TControl(ACtrl))+'">');

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
     joRes.Add('    </div>');
     joRes.Add('</el-tabs>');
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
     //
     with TPageControl(ACtrl) do begin
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+dwIIF(Enabled,'false','true'));
          //
          joRes.Add(Name+'__apg'+ASeparator+'"'+ActivePage.Name+'"');
          //����
          if TabPosition =  (tpTop) then begin
               joRes.Add(Name+'__tps'+ASeparator+'"top"');
          end else  if TabPosition =  (tpBottom) then begin
               joRes.Add(Name+'__tps'+ASeparator+'"bottom"');
          end else  if TabPosition =  (tpLeft) then begin
               joRes.Add(Name+'__tps'+ASeparator+'"left"');
          end else  if TabPosition =  (tpRight) then begin
               joRes.Add(Name+'__tps'+ASeparator+'"right"');
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
 
