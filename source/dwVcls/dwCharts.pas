unit dwCharts;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,

     //
     TeEngine,Series, TeeProcs, Chart,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Math,typinfo,
     StdCtrls, Windows,Types;



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

function GetChartType(AChart:TChart):String;
var
     oSeries   : TChartSeries;
begin
     //生成默认返回值
     Result    := 'line';

     with AChart do begin
          //得到图表类型,默认为曲线
          if SeriesCount>0 then begin
               oSeries   := SeriesList[0];
               if (oSeries.ClassType = TLineSeries) OR (oSeries.ClassType = TFastLineSeries) then begin
                    Result     := 'line';
               end else if (oSeries.ClassType = TBarSeries) then begin
                    Result     := 'histogram';
               end else if (oSeries.ClassType = THorizBarSeries) then begin
                    Result     := 'bar';
               end else if (oSeries.ClassType = TPieSeries) then begin
                    Result     := 'pie';
               end;
          end;
     end;
end;

function GetChartData(AChart:TChart):String;
var
     oSeries   : TChartSeries;
     sType     : string;
     I,iVal    : Integer;
     iCount    : Integer;

     //
     joChart   : Variant;
     jaColumns : Variant;
     jaRows    : Variant;
     joItem    : Variant;
begin
     joChart   := _Json('{columns:[],rows:[]}');
     jaColumns := joChart.columns;
     jaRows    := joChart.rows;

     //得到图表类型
     sType     := GetChartType(AChart);

     //添加横轴
     jaColumns.Add('bottomaxis');

     iCount    := 999;
     for I:=0 to AChart.SeriesCount-1 do begin
          oSeries   := AChart.Series[I];
          //
          iCount    := Min(iCount,oSeries.Count);

          //
          if sType = 'line' then begin
               if (oSeries.ClassType = TLineSeries) OR (oSeries.ClassType = TFastLineSeries) then begin
                    //
                    if oSeries.Title = '' then begin
                         oSeries.Title  := oSeries.Name;
                    end;
                    jaColumns.Add(oSeries.Title);

               end;
          end;
     end;

     //
     for iVal := 0 to iCount-1 do begin
          //
          joItem    := _json('{}');
          _ObjAddProps(['bottomaxis',oSeries.XValue[iVal]],joItem);//横轴坐标
          for I:=0 to AChart.SeriesCount-1 do begin
               oSeries   := AChart.Series[I];

               //
               if sType = 'line' then begin
                    if (oSeries.ClassType = TLineSeries) OR (oSeries.ClassType = TFastLineSeries) then begin
                         _ObjAddProps([oSeries.Title,oSeries.YValue[iVal]],joItem);
                    end;
               end;
          end;
          jaRows.add(joItem);
     end;

     //
     Result    := StringReplace(joChart,'"','''',[rfReplaceAll]);;
     Result    := StringReplace(Result,'''columns''','columns',[rfReplaceAll]);;
     Result    := StringReplace(Result,'''rows''','rows',[rfReplaceAll]);;
end;


//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwEvent(ACtrl:TControl;AData:Variant):String;
begin
     //
     TChart(ACtrl).OnClick(TChart(ACtrl));
end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     joHint    : Variant;
     oSeries   : TChartSeries;
     sType     : String;      //图表类型,line/histogram(柱状)/bar(水平柱状)/pie/
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);

     //得到图表类型
     sType     := GetChartType(TChart(ACtrl));
     
     with TChart(ACtrl) do begin
          //<ve-line :data="chartData"></ve-line>
          sCode     := '<ve-'+sType
                    +' :data="'+Name+'__dat"'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)

                    //style
                    +dwLTWH(ACtrl)
                    +'"'
                    //style 封闭

                    +Format(_DWEVENT,['click',Name,'0','onclick',''])
                    +'>';
          //添加到返回值数据
          Result.Add(sCode);
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //<ve-line :data="chartData"></ve-line>
     Result.Add('</ve-'+GetChartType(TChart(ACtrl))+'>');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TChart(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__dat'+ASeparator+''+GetChartData(TChart(ACtrl))+'');
          //

     end;
end;



end.
