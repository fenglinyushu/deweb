library dwTCheckBox;

uses
     ShareMem,

     //
     dwCtrlBase,

     //
     SynCommons,

     //
     SysUtils,
     Classes,
     Dialogs,
     StdCtrls,
     Windows,
     Controls,
     Forms;

//当前控件需要引入的第三方JS/CSS
function dwGetExtra(ACtrl:TComponent):string;stdCall;
begin
     Result    := '[]';
end;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     joData    : Variant;
begin
     //
     joData    := _Json(AData);

     if joData.event = 'onclick' then begin
          //保存事件
          TCheckBox(ACtrl).OnExit := TCheckBox(ACtrl).OnClick;
          //清空事件,以防止自动执行
          TCheckBox(ACtrl).OnClick := nil;
          //更新值
          TCheckBox(ACtrl).Checked := dwUnescape(joData.Value)='true';
          //恢复事件
          TCheckBox(ACtrl).OnClick := TCheckBox(ACtrl).OnExit;
          //执行事件
          if Assigned(TCheckBox(ACtrl).OnClick) then begin
               TCheckBox(ACtrl).OnClick(TCheckBox(ACtrl));
          end;
          //清空OnExit事件
          TCheckBox(ACtrl).OnExit := nil;
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

     with TCheckBox(ACtrl) do begin
          sCode     := '<el-checkbox'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' v-model="'+Name+'__chk"'
                    +dwGetHintValue(joHint,'type','type',' type="default"')         //sCheckBoxType
                    +dwGetHintValue(joHint,'icon','icon','')         //CheckBoxIcon
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style 封闭
                    +Format(_DWEVENT,['change',Name,'this.'+Name+'__chk','onclick',''])
                    +'>{{'+Name+'__cap}}';
          //添加到返回值数据
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
     joRes.Add('</el-checkbox>');
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
     with TCheckBox(ACtrl) do begin
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          joRes.Add(Name+'__cap'+ASeparator+'"'+dwProcessCaption(Caption)+'"');
          joRes.Add(Name+'__chk'+ASeparator+''+dwIIF(Checked,'true','false'));
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
 
