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



//����ֵ˵�� : ����һ���ַ�������(ÿ��Ԫ�ش���һ��,�Դ���ǰ����)

//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TControl;AData:Variant):String;


implementation

function GetChartType(AChart:TChart):String;
var
     oSeries   : TChartSeries;
begin
     //����Ĭ�Ϸ���ֵ
     Result    := 'line';

     with AChart do begin
          //�õ�ͼ������,Ĭ��Ϊ����
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

     //�õ�ͼ������
     sType     := GetChartType(AChart);

     //��Ӻ���
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
          _ObjAddProps(['bottomaxis',oSeries.XValue[iVal]],joItem);//��������
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


//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TControl;AData:Variant):String;
begin
     //
     TChart(ACtrl).OnClick(TChart(ACtrl));
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     joHint    : Variant;
     oSeries   : TChartSeries;
     sType     : String;      //ͼ������,line/histogram(��״)/bar(ˮƽ��״)/pie/
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(ACtrl);

     //�õ�ͼ������
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
                    //style ���

                    +Format(_DWEVENT,['click',Name,'0','onclick',''])
                    +'>';
          //��ӵ�����ֵ����
          Result.Add(sCode);
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //<ve-line :data="chartData"></ve-line>
     Result.Add('</ve-'+GetChartType(TChart(ACtrl))+'>');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
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
