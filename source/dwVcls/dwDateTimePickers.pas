unit dwDateTimePickers;

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

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwEvent(ACtrl:TControl;AData:Variant):String;
begin
     //保存事件
     TDateTimePicker(ACtrl).OnExit    := TDateTimePicker(ACtrl).OnChange;
     //清空事件,以防止自动执行
     TDateTimePicker(ACtrl).OnChange  := nil;
     //更新值
     if TDateTimePicker(ACtrl).Kind = dtkDate then begin
          TDateTimePicker(ACtrl).Date    := StrToDate(AData.value);
     end else begin
          TDateTimePicker(ACtrl).Time    := StrToTime(StringReplace(AData.value,'%3A',':',[rfReplaceAll])+':00');
     end;
     //恢复事件
     TDateTimePicker(ACtrl).OnChange  := TDateTimePicker(ACtrl).OnExit;

     //执行事件
     if Assigned(TDateTimePicker(ACtrl).OnChange) then begin
          TDateTimePicker(ACtrl).OnChange(TDateTimePicker(ACtrl));
     end;

     //清空OnExit事件
     TDateTimePicker(ACtrl).OnExit  := nil;
end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
begin
     //生成返回值数组
     Result    := _Json('[]');

     with TDateTimePicker(ACtrl) do begin
          //生成字符串
          if kind =  dtkDate then begin
               //日期  <el-date-picker v-model="value1"  type="date" placeholder="选择日期"></el-date-picker>
               sCode     := '<el-date-picker type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(ACtrl)
                         +'"' //style 封闭
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>{{'+Name+'__cap}}';
          end else begin
               sCode     := '<el-time-select :picker-options="{start: ''00:00'', step: ''00:01'', end: ''23:59''}" format="HH:mm" value-format="HH:mm"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(ACtrl)
                         +'"' //style 封闭
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>{{'+Name+'__cap}}';
          end;
          Result.Add(sCode);
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     if TDateTimePicker(ACtrl).Kind =  dtkDate then begin
          Result    := _Json('["</el-date-picker>"]');
     end else begin
          Result    := _Json('["</el-time-select>"]');
     end;
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TDateTimePicker(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          if kind =  dtkDate then begin
               Result.Add(Name+'__val'+ASeparator+'"'+FormatDateTime('yyyy-mm-dd',Date)+'"');
          end else begin
               Result.Add(Name+'__val'+ASeparator+'"'+FormatDateTime('hh:MM:ss',Time)+'"');
          end;
     end;
end;


end.
