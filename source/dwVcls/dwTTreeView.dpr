library dwTTreeView;

uses
     ShareMem,      //必须添加

     //
     dwCtrlBase,    //一些基础函数

     //
     SynCommons,    //mormot用于解析JSON的单元

     //
     SysUtils,
     Classes,
     Dialogs,
     StdCtrls,ComCtrls,
     Windows,
     Controls,
     Forms;


function _GetExpanded(ANode:TTreeNode;var AExpanded:String):Integer;
var
     iItem     : Integer;
     tnItem    : TTreeNode;
begin
     //
     for iItem := 0 to ANode.Count-1 do begin
          tnItem    := ANode.Item[iItem];
          //
          if tnItem.expanded then begin
               AExpanded := AExpanded + IntToStr(tnItem.StateIndex)+',';
               _GetExpanded(tnItem,AExpanded);
          end;
     end;
     Result    := 0 ;
end;


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

     if joData.event = 'onclick' then begin
          //保存事件
          TTreeView(ACtrl).OnExit    := TTreeView(ACtrl).OnClick;
          //清空事件,以防止自动执行
          TTreeView(ACtrl).OnClick  := nil;
          //更新值
          //TTreeView(ACtrl).Text    := dwUnescape(joData.value);
          //恢复事件
          TTreeView(ACtrl).OnClick  := TTreeView(ACtrl).OnExit;

          //执行事件
          if Assigned(TTreeView(ACtrl).OnClick) then begin
               TTreeView(ACtrl).OnClick(TTreeView(ACtrl));
          end;
     end else if joData.event = 'onenter' then begin
     end;

     //清空OnExit事件
     TTreeView(ACtrl).OnExit  := nil;
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
     with TTreeView(ACtrl) do begin
          sCode     := '';
          //_GetExpanded(TTreeView(ACtrl),sCode);
          if sCode <>'' then begin
               System.Delete(sCode,Length(sCode),1);
          end;
          //
          joRes.Add('<el-tree'
                    +dwVisible(TControl(ACtrl))                            //用于控制可见性Visible
                    +dwDisable(TControl(ACtrl))                            //用于控制可用性Enabled(部分控件不支持)
                    +' :data="'+Name+'__dat"'
                    +' node-key="id"'
                    +' :default-expanded-keys="['+sCode+']"'
                    +' :props="'+Name+'__defaultProps"'
                    +dwLTWH(TControl(ACtrl))                               //Left/Top/Width/Height
                    +'background-color:'+dwColor(Color)+';'
                    +'overflow:auto;'
                    +'"' // 封闭style
                    +Format(_DWEVENT,['node-click',Name,'val.$treeNodeId','onclick','']) //绑定OnChange事件
                    +'>');

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
     joRes.Add('</el-tree>');          //此处需要和dwGetHead对应
     //
     Result    := (joRes);
end;

//取得Data
function dwGetData(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TTreeView(ACtrl) do begin
          joRes.Add(Name+'__lef:"'+IntToStr(Left)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(Top)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Width)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Height)+'px",');
          //
          joRes.Add(Name+'__vis:'+dwIIF(Visible,'true,','false,'));
          joRes.Add(Name+'__dis:'+dwIIF(Enabled,'false,','true,'));
          //
          joRes.Add(Name+'__dat:"'+(Text)+'",');
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
     with TTreeView(ACtrl) do begin
          joRes.Add('this.'+Name+'__lef="'+IntToStr(Left)+'px";');
          joRes.Add('this.'+Name+'__top="'+IntToStr(Top)+'px";');
          joRes.Add('this.'+Name+'__wid="'+IntToStr(Width)+'px";');
          joRes.Add('this.'+Name+'__hei="'+IntToStr(Height)+'px";');
          //
          joRes.Add('this.'+Name+'__vis='+dwIIF(Visible,'true;','false;'));
          joRes.Add('this.'+Name+'__dis='+dwIIF(Enabled,'false;','true;'));
          //
          joRes.Add('this.'+Name+'__txt="'+(Text)+'";');
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
 
