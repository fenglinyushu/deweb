unit dwListBoxs;

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
var
     sValue    : String;
     iItem     : Integer;
begin
     //保存事件
     TListBox(ACtrl).OnExit    := TListBox(ACtrl).OnClick;
     //清空事件,以防止自动执行
     TListBox(ACtrl).OnClick  := nil;
     //更新值
     sValue    := dwUnescape(AData.value);
     sValue    := ','+sValue+',';
     for iItem := 0 to TListBox(ACtrl).Items.Count-1 do begin
          TListBox(ACtrl).Selected[iItem]    := Pos(','+IntToStr(iItem)+',',sValue)>0;
     end;
     //恢复事件
     TListBox(ACtrl).OnClick  := TListBox(ACtrl).OnExit;

     //执行事件
     if Assigned(TListBox(ACtrl).OnClick) then begin
          TListBox(ACtrl).OnClick(TListBox(ACtrl));
     end;

     //清空OnExit事件
     TListBox(ACtrl).OnExit  := nil;
end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var

     //
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);


     with TListBox(ACtrl) do begin
          //
          Result.Add('<select class="dwselect" size=2'
                    +dwIIF(MultiSelect,' multiple','')
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' v-model="'+Name+'__val"'
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    +Format(_DWEVENT,['change',Name,'String(this.'+Name+'__val)','onchange',''])
                    +'>');
          Result.Add('    <option class="dwoption" v-for=''(item,index) in '+Name+'__its''  :value=item.value :key=''index''>{{ item.text }}</option>');

     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</select>"]');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
var
     iItem     : Integer;
     sCode     : String;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //生成Data:选项

     //
     with TListBox(ACtrl) do begin
          //
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //添加选项
          sCode     := Name+'__its'+ASeparator+'[';
          for iItem := 0 to Items.Count-1 do begin
               sCode     := sCode + '{text:'''+Items[iItem]+''',value:'''+IntToStr(iItem)+'''},';
          end;
          Delete(sCode,Length(sCode),1);
          sCode     := sCode + ']';
          Result.Add(sCode);
          //
          sCode     := '';
          for iItem := 0 to Items.Count-1 do begin
               if Selected[iItem] then begin
                    sCode     := sCode + IntToStr(iItem)+',';
               end
          end;
          if sCode<>'' then begin
               Delete(sCode,Length(sCode),1);
          end;
          Result.Add(Name+'__val'+ASeparator+'['+sCode+']');
     end;
end;


end.
