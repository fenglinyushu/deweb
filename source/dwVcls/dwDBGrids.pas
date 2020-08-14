unit dwDBGrids;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     
     //
     DB,
     Messages, SysUtils, Variants, Classes, Graphics,     Controls, Forms, Dialogs, ComCtrls,
     ExtCtrls, Spin, Grids,  Math,typinfo, DateUtils, StdCtrls, Menus, Windows,Types,DBGrids;

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
     //TDBGrid(ACtrl).OnExit    := TDBGrid(ACtrl).OnCellClick;
     //清空事件,以防止自动执行
     //TDBGrid(ACtrl).OnCellClick  := nil;
     //更新值
     //TDrawGrid(TDBGrid(ACtrl)).Row := AData.value;
     TDBGrid(ACtrl).DataSource.DataSet.RecNo := AData.value+1;
     //恢复事件
     //TDBGrid(ACtrl).OnCellClick  := TDBGrid(ACtrl).OnExit;

     //执行事件
     if Assigned(TDBGrid(ACtrl).OnCellClick) then begin
          TDBGrid(ACtrl).OnCellClick(TDBGrid(ACtrl).Columns[0]);
     end;

     //清空OnExit事件
     //TDBGrid(ACtrl).OnExit  := nil;

end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     iItem     : Integer;
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);
     with TDBGrid(ACtrl) do begin
          //添加外框
          Result.Add('<div'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    +'>');
          //添加主体
          Result.Add('    <el-table'
                    +' :data="'+Name+'__ces"'
                    +' highlight-current-row stripe'
                    +dwIIF(Borderstyle<>bsNone,' border','')
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' height="'+IntToStr(ACtrl.Height)+'"'
                    +' style="width:100%"'
                    +Format(_DWEVENT,['row-click',Name,'val.d0','onchange',''])
                    +'>');
          //添加另外加的行号列, 用于表示行号
          Result.Add('        <el-table-column  show-overflow-tooltip fixed v-if=false prop="d0" label="rowno" width="80"></el-table-column>');
          //添加各列
          for iItem := 0 to Columns.Count-1 do begin
               Result.Add('        <el-table-column'
                         +' show-overflow-tooltip'
                         +' prop="d'+IntToStr(iItem+1)+'"'
                         +' label="'+Columns[iItem].Title.Caption+'"'
                         +' width="'+IntToStr(Columns[iItem].Width)+'"></el-table-column>');
          end;
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     Result.Add('    </el-table>');
     Result.Add('</div>');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
var
     iRow,iCol : Integer;
     sCode     : String;
     oDataSet  : TDataSet;
     function _GetValue(AField:TField):String;
     begin
          if AField.DataType in [ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency,
               ftBCD,ftBytes, ftVarBytes, ftAutoInc, ftFmtMemo,ftFixedChar, ftWideString, ftLargeint, ftMemo] then
          begin
               Result    := dwProcessCaption(AField.AsString);
          end else if AField.DataType in [ftDate] then begin
               Result    := FormatDateTime('yyyy-mm-dd',AField.AsDateTime);
          end else if AField.DataType in [ftTime] then begin
               Result    := FormatDateTime('HH:MM:SS',AField.AsDateTime);
          end else if AField.DataType in [ftDateTime] then begin
               Result    := FormatDateTime('yyyy-mm-dd HH:MM:SS',AField.AsDateTime);
          end else begin
               Result    := '';
          end;
     end;
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TDBGrid(ACtrl) do begin
          //
          oDataSet  := DataSource.DataSet;
          

          //
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
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
                              Result.Add(sCode+']');
                         end else begin
                              Result.Add(sCode);
                         end;
                    end;
                    oDataSet.First;
               end;
               oDataSet.EnableControls;
          end
(*
          end else begin
               for iRow := 0 to RowCount-1 do begin
                    sCode     := '';
                    sCode := '{d0:"'+IntToStr(iRow)+'",';   //另外添加的行号列
                    for iCol := 0 to ColCount-1 do begin
                         sCode    := sCode + 'd'+IntToStr(iCol+1)+':"'+Cells[iCol,iRow]+'",';
                    end;
                    if Length(sCode)>2 then begin
                         Delete(sCode,Length(sCode),1);  //删除最后的,
                    end;
                    sCode    := sCode + '}';

                    Result.Add('$set(this.'+Name+'__ces,'+IntToStr(iRow)+','+sCode+')');
               end;
          end;
*)
     end;
end;







end.
