unit dwStringGrids;

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
     TStringGrid(ACtrl).OnExit    := TStringGrid(ACtrl).OnClick;
     //清空事件,以防止自动执行
     TStringGrid(ACtrl).OnClick    := nil;
     //更新值
     TStringGrid(ACtrl).Row    := AData.value;
     //恢复事件
     TStringGrid(ACtrl).OnClick  := TStringGrid(ACtrl).OnExit;

     //执行事件
     if Assigned(TStringGrid(ACtrl).OnClick) then begin
          TStringGrid(ACtrl).OnClick(TStringGrid(ACtrl));
     end;

     //清空OnExit事件
     TStringGrid(ACtrl).OnExit  := nil;

end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     iItem     : Integer;
     sCode     : string;
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);
     with TStringGrid(ACtrl) do begin
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
                    +' style="width:100%;height:100%;"'
                    +Format(_DWEVENT,['row-click',Name,'val.d0','onchange',''])
                    +'>');
          //添加另外加的行号列, 用于表示行号
          Result.Add('        <el-table-column show-overflow-tooltip fixed v-if=false prop="d0" label="rowno" width="80"></el-table-column>');
          //添加各列
          for iItem := 0 to ColCount-1 do begin
               Result.Add('        <el-table-column'
                         +' show-overflow-tooltip'
                         +dwIIF(iItem<FixedCols,' fixed','')
                         +' prop="d'+IntToStr(iItem+1)+'"'
                         +' label="'+Cells[iItem,0]+'"'
                         +' width="'+IntToStr(Colwidths[iItem])+'"></el-table-column>');
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
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TStringGrid(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          if ASeparator = ':' then begin
               sCode     := '';
               for iRow := 1 to RowCount-1 do begin
                    sCode     := sCode + '{"d0":'''+IntToStr(iRow)+''',';
                    for iCol := 0 to ColCount-1 do begin
                         sCode     := sCode + '"d'+IntToStr(iCol+1)+'":'''+dwProcessCaption(Cells[iCol,iRow])+''',';
                    end;
                    Delete(sCode,Length(sCode),1);
                    sCode     := sCode + '},';
               end;
               if sCode<>'' then begin
                    Delete(sCode,Length(sCode),1);
               end;
               sCode     := '['+sCode + ']';
               Result.Add(Name+'__ces'+ASeparator+sCode);
          end else begin
               for iRow := 0 to RowCount-1 do begin
                    sCode     := '';
                    sCode := '{d0:"'+IntToStr(iRow)+'",';   //另外添加的行号列
                    for iCol := 0 to ColCount-1 do begin
                         sCode    := sCode + 'd'+IntToStr(iCol+1)+':"'+dwProcessCaption(Cells[iCol,iRow])+'",';
                    end;
                    if Length(sCode)>2 then begin
                         Delete(sCode,Length(sCode),1);  //删除最后的,
                    end;
                    sCode    := sCode + '}';

                    Result.Add('$set(this.'+Name+'__ces,'+IntToStr(iRow)+','+sCode+')');
               end;
          end;
     end;
end;







end.
