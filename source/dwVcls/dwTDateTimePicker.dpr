library dwTDateTimePicker;

uses
     ShareMem,      //必须添加

     //
     dwCtrlBase,    //一些基础函数

     //
     SynCommons,    //mormot用于解析JSON的单元

     //
     SysUtils,DateUtils,ComCtrls, ExtCtrls,
     Classes,
     Dialogs,
     StdCtrls,
     Windows,
     Controls,
     Forms;

//当前控件需要引入的第三方JS/CSS ,一般为不做改动,目前仅在TChart使用时需要用到
function dwGetExtra(ACtrl:TComponent):string;stdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     {
     //以下是TChart时的代码,供参考
     joRes.Add('<script src="dist/charts/echarts.min.js"></script>');
     joRes.Add('<script src="dist/charts/lib/index.min.js"></script>');
     joRes.Add('<link rel="stylesheet" href="dist/charts/lib/style.min.css">');
     }

     //
     Result    := joRes;
end;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     joData    : Variant;
begin
     //
     joData    := _Json(AData);

     if joData.event = 'onchange' then begin
          //保存事件
          TDateTimePicker(ACtrl).OnExit    := TDateTimePicker(ACtrl).OnChange;
          //清空事件,以防止自动执行
          TDateTimePicker(ACtrl).OnChange  := nil;
          //更新值
          if TDateTimePicker(ACtrl).Kind = dtkDate then begin
               TDateTimePicker(ACtrl).Date    := StrToDateDef(joData.value,Now);
          end else begin
               TDateTimePicker(ACtrl).Time    := StrToTimeDef(StringReplace(joData.value,'%3A',':',[rfReplaceAll])+':00',Now);
          end;
          //恢复事件
          TDateTimePicker(ACtrl).OnChange  := TDateTimePicker(ACtrl).OnExit;

          //执行事件
          if Assigned(TDateTimePicker(ACtrl).OnChange) then begin
               TDateTimePicker(ACtrl).OnChange(TDateTimePicker(ACtrl));
          end;

          //清空OnExit事件
          TDateTimePicker(ACtrl).OnExit  := nil;
     end else if joData.event = 'onenter' then begin
     end;

end;


//取得HTML头部消息
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(TControl(ACtrl));
     with TDateTimePicker(ACtrl) do begin
          //生成字符串
          if kind =  dtkDate then begin
               //日期  <el-date-picker v-model="value1"  type="date" placeholder="选择日期"></el-date-picker>
               sCode     := '<el-date-picker type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd"'
                         +dwVisible(TControl(ACtrl))
                         +dwDisable(TControl(ACtrl))
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(TControl(ACtrl))
                         +'"' //style 封闭
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>';
          end else begin
               sCode     := '<el-time-select :picker-options="{start: ''00:00'', step: ''00:01'', end: ''23:59''}" format="HH:mm" value-format="HH:mm"'
                         +dwVisible(TControl(ACtrl))
                         +dwDisable(TControl(ACtrl))
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(TControl(ACtrl))
                         +'"' //style 封闭
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>';
          end;
          joRes.Add(sCode);
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
     if TDateTimePicker(ACtrl).Kind =  dtkDate then begin
          joRes.Add('</el-date-picker>');          //此处需要和dwGetHead对应
     end else begin
          joRes.Add('</el-time-select>');          //此处需要和dwGetHead对应
     end;

     //
     Result    := (joRes);
end;

//取得Data消息
function dwGetData(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TDateTimePicker(ACtrl) do begin
          joRes.Add(Name+'__lef:"'+IntToStr(Left)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(Top)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Width)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Height)+'px",');
          //
          joRes.Add(Name+'__vis:'+dwIIF(Visible,'true,','false,'));
          joRes.Add(Name+'__dis:'+dwIIF(Enabled,'false,','true,'));
          //
          if kind = dtkDate then begin
               joRes.Add(Name+'__val:"'+FormatDateTime('yyyy-mm-dd',Date)+'",');
          end else begin
               joRes.Add(Name+'__val:"'+FormatDateTime('hh:MM:ss',Time)+'",');
          end;
     end;
     //
     Result    := (joRes);
end;

function dwGetMethod(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TDateTimePicker(ACtrl) do begin
          joRes.Add('this.'+Name+'__lef="'+IntToStr(Left)+'px";');
          joRes.Add('this.'+Name+'__top="'+IntToStr(Top)+'px";');
          joRes.Add('this.'+Name+'__wid="'+IntToStr(Width)+'px";');
          joRes.Add('this.'+Name+'__hei="'+IntToStr(Height)+'px";');
          //
          joRes.Add('this.'+Name+'__vis='+dwIIF(Visible,'true;','false;'));
          joRes.Add('this.'+Name+'__dis='+dwIIF(Enabled,'false;','true;'));
          //
          if kind =  dtkDate then begin
               joRes.Add('this.'+Name+'__val="'+FormatDateTime('yyyy-mm-dd',Date)+'";');
          end else begin
               joRes.Add('this.'+Name+'__val="'+FormatDateTime('hh=MM=ss',Time)+'";');
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
 
