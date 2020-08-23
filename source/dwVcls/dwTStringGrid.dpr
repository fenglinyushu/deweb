library dwTStringGrid;

uses
     ShareMem,      //必须添加

     //
     dwCtrlBase,    //一些基础函数

     //
     SynCommons,    //mormot用于解析JSON的单元

     //
     SysUtils,DateUtils,ComCtrls, ExtCtrls,
     Classes,Grids,
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

     if joData.event = 'onclick' then begin
          //保存事件
          TStringGrid(ACtrl).OnExit    := TStringGrid(ACtrl).OnClick;
          //清空事件,以防止自动执行
          TStringGrid(ACtrl).OnClick  := nil;
          //更新值
          TStringGrid(ACtrl).Row   := joData.value;
          //恢复事件
          TStringGrid(ACtrl).OnClick  := TStringGrid(ACtrl).OnExit;

          //执行事件
          if Assigned(TStringGrid(ACtrl).OnClick) then begin
               TStringGrid(ACtrl).OnClick(TStringGrid(ACtrl));
          end;
     end else if joData.event = 'onenter' then begin
     end;

     //清空OnExit事件
     TStringGrid(ACtrl).OnExit  := nil;
end;


//取得HTML头部消息
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     //
     iItem     : Integer;
     //
     joHint    : Variant;
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     //
     with TStringGrid(ACtrl) do begin
          //添加外框
          joRes.Add('<div'
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style 封闭
                    +'>');
          //添加主体
          joRes.Add('    <el-table'
                    +' :data="'+Name+'__ces"'
                    +' highlight-current-row'
                    +' ref="'+Name+'"'
                    //+' stripe'
                    +dwIIF(Borderstyle<>bsNone,' border','')
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' height="'+IntToStr(TControl(ACtrl).Height)+'"'
                    +' style="width:100%"'
                    +Format(_DWEVENT,['row-click',Name,'val.d0','onclick',''])
                    +'>');

          //添加另外加的行号列, 用于表示行号
          joRes.Add('        <el-table-column  show-overflow-tooltip fixed v-if=false prop="d0" label="rowno" width="80"></el-table-column>');
          //添加各列
          for iItem := 0 to ColCount-1 do begin
               joRes.Add('        <el-table-column'
                         +' show-overflow-tooltip'
                         +' prop="d'+IntToStr(iItem+1)+'"'
                         +' :label="'+Name+'__col'+IntToStr(iItem)+'"'
                         +' width="'+IntToStr(ColWidths[iItem])+'"></el-table-column>');
          end;
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
     joRes.Add('    </el-table>');
     joRes.Add('</div>');

     //
     Result    := (joRes);
end;



//取得Data
function dwGetData(ACtrl:TControl):string;StdCall;
var
     joRes     : Variant;
     //
     iRow,iCol : Integer;
     sCode     : String;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TStringGrid(ACtrl) do begin

          //
          joRes.Add(Name+'__lef:"'+IntToStr(Left)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(Top)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Width)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Height)+'px",');
          //
          joRes.Add(Name+'__vis:'+dwIIF(Visible,'true,','false,'));
          joRes.Add(Name+'__dis:'+dwIIF(Enabled,'false,','true,'));
          //列标题
          for iCol := 0 to ColCount-1 do begin
               joRes.Add(Name+'__col'+IntToStr(iCol)+':"'+Cells[iCol,0]+'",');
          end;


          //内容
          sCode     := Name+'__ces:[';
          for iRow := 1 to RowCount-1 do begin
               sCode     := sCode + '{"d0":'''+IntToStr(iRow)+''',';
               for iCol := 0 to ColCount-1 do begin
                    sCode     := sCode + '"d'+IntToStr(iCol+1)+'":'''+Cells[iCol,iRow]+''',';
               end;
               sCode     := sCode + '},';
          end;
          sCode     := sCode + '],';
          joRes.Add(sCode);
          //joRes.Add('currentRow: 1,');
     end;
     //
     Result    := (joRes);
end;



//取得Method
function dwGetMethod(ACtrl:TControl):string;StdCall;
var
     joRes     : Variant;
     //
     iRow,iCol : Integer;
     sCode     : String;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     //
     with TStringGrid(ACtrl) do begin
          //
          joRes.Add(Name+'__lef="'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top="'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid="'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei="'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis='+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis='+dwIIF(Enabled,'false','true'));

          //列标题
          for iCol := 0 to ColCount-1 do begin
               joRes.Add('this.'+Name+'__col'+IntToStr(iCol)+'="'+Cells[iCol,0]+'";');
          end;

          //内容
          for iRow := 1 to RowCount-1 do begin
               sCode     := 'this.$set(this.'+TStringGrid(ACtrl).Name+'__ces,'+IntToStr(iRow-1)+',{d0:"'+IntToStr(iRow)+'",';
               for iCol := 0 to ColCount-2 do begin
                    sCode     := sCode +'d'+IntToStr(iCol+1)+':"'+Cells[iCol,iRow]+'",';
               end;
               sCode     := sCode +'d'+IntToStr(ColCount)+':"'+Cells[ColCount-1,iRow]+'"});';
               joRes.Add(sCode);
          end;

     end;
     //行号        this.$refs.multiplePlan.data[0]
     joRes.Add('this.$refs.'+TStringGrid(ACtrl).Name+'.setCurrentRow('
          +'this.$refs.'+TStringGrid(ACtrl).Name+'.data['+IntToStr(TStringGrid(ACtrl).Row-1)+']'
          +');');
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
 
