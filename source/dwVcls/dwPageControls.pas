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



//返回值说明 : 返回一个字符串数组(每个元素代表一行,自带当前缩进)

//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwEvent(ACtrl:TControl;AData:Variant):String;


implementation

function dwLTWHTab(ACtrl:TControl):String;  //可以更新位置的用法
begin

     //
     with ACtrl do begin
          Result    := ' :style="{width:'+Name+'__wid,height:'+Name+'__hei}"'
                    +' style="position:absolute;left:0px;top:0px;';
     end;
end;


//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwEvent(ACtrl:TControl;AData:Variant):String;
var
     iTab      : Integer;
begin
     //保存事件
     TPageControl(ACtrl).OnExit    := TPageControl(ACtrl).OnChange;
     //清空事件,以防止自动执行
     TPageControl(ACtrl).OnChange  := nil;
     //更新值
     for iTab := 0 to TPageControl(ACtrl).PageCount-1 do begin
          if TPageControl(ACtrl).Pages[iTab].Name = AData.value then begin
               TPageControl(ACtrl).ActivePageIndex     := iTab;
               break;
          end;
     end;
     //恢复事件
     TPageControl(ACtrl).OnChange  := TPageControl(ACtrl).OnExit;

     //执行事件
     TPageControl(ACtrl).OnChange(TPageControl(ACtrl));

     //清空OnExit事件
     TPageControl(ACtrl).OnExit  := nil;
end;



//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     iTab      : Integer;
     //
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);

     with TPageControl(ACtrl) do begin
          //外框
          Result.Add('<el-tabs'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' v-model="'+Name+'__apg"'        //ActivePage
                    +' :tab-position="'+Name+'__tps"'  //标题位置
                    +dwIIF(ParentBiDiMode,' type="border-card"','')   //是否有外框
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    +Format(_DWEVENT,['tab-click',Name,'this.'+Name+'__apg','onchange',''])
                    +'>');
          //添加选项卡
          for iTab := 0 to PageCount-1 do begin
               //
               Result.Add('    <el-tab-pane label="'+dwConvertStr(Pages[iTab].Caption)+'" name="'+Pages[iTab].name+'">');
               //
               Result.Add('    </el-tab-pane>');
          end;


          //body框
          Result.Add('<div'+dwLTWHTab(ACtrl)+'">');

     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     Result.Add('    </div>');
     Result.Add('</el-tabs>');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
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
          //方向
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


