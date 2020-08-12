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

//--------------一些自用函数------------------------------------------------------------------------
function dwLTWHTab(ACtrl:TControl):String;  //可以更新位置的用法
begin

     //
     with ACtrl do begin
          Result    := ' :style="{width:'+Name+'__wid,height:'+Name+'__hei}"'
                    +' style="position:absolute;left:0px;top:0px;';
     end;
end;


//当前控件需要引入的第三方JS/CSS
function dwGetExtra(ACtrl:TComponent):string;stdCall;
begin
     Result    := '[]';
end;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     iTab      : Integer;
     joData    : Variant;
begin
     //解析AData字符串到JSON对象
     joData    := _json(AData);

     //保存事件
     TPageControl(ACtrl).OnExit    := TPageControl(ACtrl).OnChange;

     //清空事件,以防止自动执行
     TPageControl(ACtrl).OnChange  := nil;
     //更新值
     for iTab := 0 to TPageControl(ACtrl).PageCount-1 do begin
          if TPageControl(ACtrl).Pages[iTab].Name = joData.value then begin
               TPageControl(ACtrl).ActivePageIndex     := iTab;
               break;
          end;
     end;
     //恢复事件
     TPageControl(ACtrl).OnChange  := TPageControl(ACtrl).OnExit;

     //执行事件
     if Assigned(TPageControl(ACtrl).OnChange) then begin
          TPageControl(ACtrl).OnChange(TPageControl(ACtrl));
     end;

     //清空OnExit事件
     TPageControl(ACtrl).OnExit  := nil;
end;


//取得HTML头部消息
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
     iTab      : Integer;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     with TPageControl(ACtrl) do begin
          //外框
          joRes.Add('<el-tabs'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' v-model="'+Name+'__apg"'        //ActivePage
                    +' :tab-position="'+Name+'__tps"'  //标题位置
                    +dwIIF(ParentBiDiMode,' type="border-card"','')   //是否有外框
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style 封闭
                    +Format(_DWEVENT,['tab-click',Name,'this.'+Name+'__apg','onchange',''])
                    +'>');
          //添加选项卡
          for iTab := 0 to PageCount-1 do begin
               //
               joRes.Add('    <el-tab-pane label="'+dwConvertStr(Pages[iTab].Caption)+'" name="'+Pages[iTab].name+'">');
               //
               joRes.Add('    </el-tab-pane>');
          end;


          //body框
          joRes.Add('<div'+dwLTWHTab(TControl(ACtrl))+'">');

     end;
     //
     Result    := (joRes);
end;

//取得HTML尾部消息
function dwGetTail(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //生成返回值数组
     joRes.Add('    </div>');
     joRes.Add('</el-tabs>');
     //
     Result    := (joRes);
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TComponent;ASeparator:String):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
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
          //方向
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
 
