unit dwPageControls;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Spin, Grids,
     Math,typinfo,
     DateUtils, StdCtrls, Menus,
     Windows,Types;



//����ֵ˵�� : ����һ���ַ�������(ÿ��Ԫ�ش���һ��,�Դ���ǰ����)

//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TControl;AData:Variant):String;


implementation

function dwLTWHTab(ACtrl:TControl):String;  //���Ը���λ�õ��÷�
begin

     //
     with ACtrl do begin
          Result    := ' :style="{width:'+Name+'__wid,height:'+Name+'__hei}"'
                    +' style="position:absolute;left:0px;top:0px;';
     end;
end;


//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TControl;AData:Variant):String;
var
     iTab      : Integer;
begin
     //�����¼�
     TPageControl(ACtrl).OnExit    := TPageControl(ACtrl).OnChange;
     //����¼�,�Է�ֹ�Զ�ִ��
     TPageControl(ACtrl).OnChange  := nil;
     //����ֵ
     for iTab := 0 to TPageControl(ACtrl).PageCount-1 do begin
          if TPageControl(ACtrl).Pages[iTab].Name = AData.value then begin
               TPageControl(ACtrl).ActivePageIndex     := iTab;
               break;
          end;
     end;
     //�ָ��¼�
     TPageControl(ACtrl).OnChange  := TPageControl(ACtrl).OnExit;

     //ִ���¼�
     TPageControl(ACtrl).OnChange(TPageControl(ACtrl));

     //���OnExit�¼�
     TPageControl(ACtrl).OnExit  := nil;
end;



//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     iTab      : Integer;
     //
     joHint    : Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(ACtrl);

     with TPageControl(ACtrl) do begin
          //���
          Result.Add('<el-tabs'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' v-model="'+Name+'__apg"'        //ActivePage
                    +' :tab-position="'+Name+'__tps"'  //����λ��
                    +dwIIF(ParentBiDiMode,' type="border-card"','')   //�Ƿ������
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    +Format(_DWEVENT,['tab-click',Name,'this.'+Name+'__apg','onchange',''])
                    +'>');
          //���ѡ�
          for iTab := 0 to PageCount-1 do begin
               //
               Result.Add('    <el-tab-pane label="'+dwConvertStr(Pages[iTab].Caption)+'" name="'+Pages[iTab].name+'">');
               //
               Result.Add('    </el-tab-pane>');
          end;


          //body��
          Result.Add('<div'+dwLTWHTab(ACtrl)+'">');

     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     Result.Add('    </div>');
     Result.Add('</el-tabs>');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TPageControl(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__apg'+ASeparator+'"'+ActivePage.Name+'"');
          //����
          if TabPosition =  (tpTop) then begin
               Result.Add(Name+'__tps'+ASeparator+'"top"');
          end else  if TabPosition =  (tpBottom) then begin
               Result.Add(Name+'__tps'+ASeparator+'"bottom"');
          end else  if TabPosition =  (tpLeft) then begin
               Result.Add(Name+'__tps'+ASeparator+'"left"');
          end else  if TabPosition =  (tpRight) then begin
               Result.Add(Name+'__tps'+ASeparator+'"right"');
          end;
     end;
end;


end.


