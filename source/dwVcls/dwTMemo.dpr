library dwTMemo;

uses
     ShareMem,

     //
     dwCtrlBase,

     //
     SynCommons,

     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     StdCtrls, Windows;

//��ǰ�ؼ���Ҫ����ĵ�����JS/CSS
function dwGetExtra(ACtrl:TComponent):string;stdCall;
begin
     Result    := '[]';
end;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     sValue    : String;
     iItem     : Integer;
     joData    : Variant;
begin
     joData    := _json(AData);

     //�����¼�
     TMemo(ACtrl).OnExit    := TMemo(ACtrl).OnChange;
     //����¼�,�Է�ֹ�Զ�ִ��
     TMemo(ACtrl).OnChange  := nil;
     //����ֵ
     TMemo(ACtrl).Text    := dwUnescape(joData.value);
     //�ָ��¼�
     TMemo(ACtrl).OnChange  := TMemo(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TMemo(ACtrl).OnChange) then begin
          TMemo(ACtrl).OnChange(TMemo(ACtrl));
     end;

     //���OnExit�¼�
     TMemo(ACtrl).OnExit  := nil;
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     with TMemo(ACtrl) do begin
          sCode     := '<el-input type="textarea"'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' v-model="'+Name+'__txt"'
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style ���
                    +Format(_DWEVENT,['input',Name,'(this.'+Name+'__txt)','onchange',''])
                    +'>';
          //��ӵ�����ֵ����
          joRes.Add(sCode);
     end;

     //
     Result    := (joRes);
end;

//ȡ��HTMLβ����Ϣ
function dwGetTail(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //���ɷ���ֵ����
     joRes.Add('</el-input>');
     //
     Result    := (joRes);
end;

function dwMemoTextToValue(AText:string):string;
var
     slTxt     : TStringList;
     iItem     : Integer;
begin
     slTxt     := TStringList.Create;
     slTxt.Text     := AText;
     Result    := '';
     for iItem := 0 to slTxt.Count-1 do begin
          if iItem <slTxt.Count-1 then begin
               Result     := Result + slTxt[iItem]+'\n';
          end else begin
               Result     := Result + slTxt[iItem];
          end;
     end;
     slTxt.Destroy;
end;


//ȡ��Data
function dwGetData(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
     sCode     : String;
     iItem     : Integer;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TMemo(ACtrl) do begin
          joRes.Add(Name+'__lef:"'+IntToStr(Left)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(Top)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Width)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Height)+'px",');
          //
          joRes.Add(Name+'__vis:'+dwIIF(Visible,'true,','false,'));
          joRes.Add(Name+'__dis:'+dwIIF(Enabled,'false,','true,'));
          //
          joRes.Add(Name+'__txt:"'+dwMemoTextToValue(Text)+'",');
     end;
     //
     Result    := (joRes);
end;

function dwGetMethod(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
     sCode     : String;
     iItem     : Integer;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TMemo(ACtrl) do begin
          joRes.Add('this.'+Name+'__lef="'+IntToStr(Left)+'px";');
          joRes.Add('this.'+Name+'__top="'+IntToStr(Top)+'px";');
          joRes.Add('this.'+Name+'__wid="'+IntToStr(Width)+'px";');
          joRes.Add('this.'+Name+'__hei="'+IntToStr(Height)+'px";');
          //
          joRes.Add('this.'+Name+'__vis='+dwIIF(Visible,'true;','false;'));
          joRes.Add('this.'+Name+'__dis='+dwIIF(Enabled,'false;','true;'));
          //
          joRes.Add('this.'+Name+'__txt="'+dwMemoTextToValue(Text)+'";');
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
 
