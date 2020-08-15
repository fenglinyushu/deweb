library dwTDBGrid;

uses
     ShareMem,      //必须添加

     //
     dwCtrlBase,    //一些基础函数

     //
     SynCommons,    //mormot用于解析JSON的单元

     //
     SysUtils,DateUtils,ComCtrls, ExtCtrls,
     Classes,DB,DBGrids,
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

     TDBGrid(ACtrl).DataSource.DataSet.RecNo := joData.value+1;

     //执行事件
     if Assigned(TDBGrid(ACtrl).OnCellClick) then begin
          TDBGrid(ACtrl).OnCellClick(TDBGrid(ACtrl).Columns[0]);
     end;

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
     with TDBGrid(ACtrl) do begin
          //添加外框
          joRes.Add('<div'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style 封闭
                    +'>');
          //添加主体
          joRes.Add('    <el-table'
                    +' :data="'+Name+'__ces"'
                    +' highlight-current-row stripe'
                    +dwIIF(Borderstyle<>bsNone,' border','')
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' height="'+IntToStr(TControl(ACtrl).Height)+'"'
                    +' style="width:100%"'
                    +Format(_DWEVENT,['row-click',Name,'val.d0','onchange',''])
                    +'>');
          //添加另外加的行号列, 用于表示行号
          joRes.Add('        <el-table-column  show-overflow-tooltip fixed v-if=false prop="d0" label="rowno" width="80"></el-table-column>');
          //添加各列
          for iItem := 0 to Columns.Count-1 do begin
               joRes.Add('        <el-table-column'
                         +' show-overflow-tooltip'
                         +' prop="d'+IntToStr(iItem+1)+'"'
                         +' label="'+Columns[iItem].Title.Caption+'"'
                         +' width="'+IntToStr(Columns[iItem].Width)+'"></el-table-column>');
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

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):string;StdCall;
var
     joRes     : Variant;
     iRow,iCol : Integer;
     sCode     : String;
     oDataSet  : TDataSet;

     //
     oForm     : TForm;
     oWinCtrl  : TWinControl;
     //
     function _GetValue(AField:TField):String;
     begin
          try
               if AField.DataType in [ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency,
                    ftBCD,ftBytes, ftVarBytes, ftAutoInc, ftFmtMemo,ftFixedChar, ftWideString, ftLargeint, ftMemo] then
               begin
                    Result    := dwProcessCaption(UTF8ToAnsi(AField.AsString));
               end else if AField.DataType in [ftDate] then begin
                    Result    := FormatDateTime('yyyy-mm-dd',AField.AsDateTime);
               end else if AField.DataType in [ftTime] then begin
                    Result    := FormatDateTime('HH:MM:SS',AField.AsDateTime);
               end else if AField.DataType in [ftDateTime] then begin
                    Result    := FormatDateTime('yyyy-mm-dd HH:MM:SS',AField.AsDateTime);
               end else begin
                    Result    := '';
               end;
          except
          end;
     end;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     oWinCtrl  := TDBGrid(ACtrl).Parent;
     while not (oWinCtrl is TCustomForm) do begin
          //
          oWinCtrl  := oWinCtrl.Parent;
     end;
{
     oForm     := TForm(oWinCtrl);
}
     //
     with TDBGrid(ACtrl) do
      begin
          if oForm <> nil then begin
               joREs.add(oForm.Name);
          end else begin
               joRes.Add('NO FOUND!!!');
          end;
(*
          //
          oDataSet  := DataSource.DataSet;

          //
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          if oDataSet <> nil then begin
               if not oDataSet.Active then begin
               end else begin
                    oDataSet.DisableControls;
                    //
                    if ASeparator = ':' then begin
                         sCode     := '';
                         oDataSet.First;
                         iRow := 0;
                         while not oDataSet.Eof do begin
                              if sCode = '' then begin
                                   sCode     := Name+'__ces:[{"d0":'''+IntToStr(iRow)+''',';
                              end else begin
                                   sCode     := '{"d0":'''+IntToStr(iRow)+''',';
                              end;
                              for iCol := 0 to Columns.Count-2 do begin
                                   sCode     := sCode +'"d'+IntToStr(iCol+1)+'":'''+_GetValue(Columns[iCol].Field)+''',';
                              end;
                              sCode     := sCode +'"d'+IntToStr(Columns.Count-1)+'":'''+_GetValue(Columns[Columns.Count-1].Field)+'''}';
                              //
                              oDataSet.Next;
                              Inc(iRow);
                              if oDataSet.Eof then begin
                                   joRes.Add(sCode+']');
                              end else begin
                                   joRes.Add(sCode);
                              end;
                         end;
                         oDataSet.First;
                    end;
                    oDataSet.EnableControls;
               end;
          end
*)
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
 
