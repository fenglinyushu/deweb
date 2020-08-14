unit dwRadioButtons;

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
     TRadioButton(ACtrl).OnExit := TRadioButton(ACtrl).OnClick;
     //清空事件,以防止自动执行
     TRadioButton(ACtrl).OnClick := nil;
     //更新值
     TRadioButton(ACtrl).Checked := dwUnescape(AData.Value)='true';
     //恢复事件
     TRadioButton(ACtrl).OnClick := TRadioButton(ACtrl).OnExit;
     //执行事件
     if Assigned(TRadioButton(ACtrl).OnClick) then begin
          TRadioButton(ACtrl).OnClick(TRadioButton(ACtrl));
     end;
     //清空OnExit事件
     TRadioButton(ACtrl).OnExit := nil;

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

     //               
     with TRadioButton(ACtrl) do begin
          sCode     := '<el-radio'
                    +' label="1"'       //选中值
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' v-model="'+Name+'__chk"'
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    +dwIIF(Assigned(OnClick),Format(_DWEVENT,['change',Name,'(this.'+Name+'__chk)','onclick','']),'')
                    +'>{{'+Name+'__cap}}';
          //添加到返回值数据
          Result.Add(sCode);
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</el-radio>"]');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TRadioButton(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__cap'+ASeparator+'"'+dwProcessCaption(Caption)+'"');
          Result.Add(Name+'__chk'+ASeparator+'"'+dwIIF(Checked,'1','0')+'"');
     end;
end;


end.
