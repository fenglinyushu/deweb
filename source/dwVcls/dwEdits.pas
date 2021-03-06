unit dwEdits;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,     Controls, Forms, Dialogs, ComCtrls,
     ExtCtrls, Spin, Grids,  Math,typinfo, DateUtils, StdCtrls, Menus, Windows,Types;

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
     TEdit(ACtrl).OnExit    := TEdit(ACtrl).OnChange;
     //清空事件,以防止自动执行
     TEdit(ACtrl).OnChange  := nil;
     //更新值
     TEdit(ACtrl).Text    := dwUnescape(AData.value);
     //恢复事件
     TEdit(ACtrl).OnChange  := TEdit(ACtrl).OnExit;

     //执行事件
     if Assigned(TEdit(ACtrl).OnChange) then begin
          TEdit(ACtrl).OnChange(TEdit(ACtrl));
     end;

     //清空OnExit事件
     TEdit(ACtrl).OnExit  := nil;
end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);
     with TEdit(ACtrl) do begin
          sCode     := '<el-input'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwIIF(PasswordChar=#0,'',' show-password')
                    +' v-model="'+Name+'__txt"'
                    +dwGetHintValue(joHint,'placeholder','placeholder','')         //placeholder
                    +dwGetHintValue(joHint,'prefix-icon','prefix-icon','')         //Icon
                    +dwGetHintValue(joHint,'suffix-icon','suffix-icon','')         //Icon
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    +Format(_DWEVENT,['input',Name,'(this.'+Name+'__txt)','onchange',''])
                    +'>';
          //添加到返回值数据
          Result.Add(sCode);
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</el-input>"]');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TEdit(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__txt'+ASeparator+'"'+(Text)+'"');
     end;
end;







end.
