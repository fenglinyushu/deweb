unit dwCtrlBase;

interface

uses
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Spin, Grids,
     Math,typinfo,
     DateUtils, StdCtrls, Menus,
     Windows,Types;

//���ݿؼ���Hint����JSON
function dwGetHintJson(ACtrl:TControl):Variant;

//���ɿɼ����ַ���
function dwVisible(ACtrl:TControl):String;

//���ɿ������ַ���
function dwDisable(ACtrl:TControl):String;

//����LTWH�ַ���
function dwLTWH(ACtrl:TControl):String;      //���Ը���λ�õ��÷�

//���HINT��JOSN���������������ĳ����,�򷵻��ַ���
//������� AJsonName �� ���� AHtmlName = AJson.AJsonName;
//                 ���� ���� ADefault
function dwGetHintValue(AHint:Variant;AJsonName,AHtmlName,ADefault:String):String;

function dwIIF(ABool:Boolean;AYes,ANo:string):string;

const
     _DWEVENT = ' @%s="dwevent(''%s'',''%s'',''%s'',''%s'')"';            //��������Ϊ:JS�¼����� ---  �ؼ�����,�ؼ�ֵ,D�¼�����,����

//���ܺ���
function dwDecryptKey (Src:String; Key:String):string;

//Delphi ��ɫתHTML ��ɫ�ַ���
function dwColor(AColor:Integer):string;

//
function dwEncodeURIComponent(S:AnsiString):AnsiString;

function dwBoolToStr(AVal:Boolean):string;
function dwIsNull(AVar:Variant):Boolean;

//����DELPHI�е������ַ�
function dwConvertStr(AStr:String):String;

//���ڶ����Ľ��б���, ��ӦJS�е�escape����
function dwEscape(const StrToEscape:string):String;
function dwUnescape(S: string): string;

//����/��ȡ��Hint�д�ŵ�ֵ
function dwSetProp(ACtrl:TControl;AAttr,AValue:String):Integer;
function dwGetProp(ACtrl:TControl;AAttr:String):String;
function dwGetJsonAttr(AJson:Variant;AAttr:String):String;   //��JSON�����ж�ȡ����ֵ

//��ȡ������Բ����Ϣ
function dwRadius(AJson:Variant):string;

//����ACtrl����Ҫ��.   AHorzΪ��ʱ ˮƽ�ȿ�����, ����ֱ����
procedure dwRealignChildren(ACtrl:TWinControl;AHorz:Boolean;ASize:Integer);



//Memo.textת��Ϊelemenu Textarea �ĸ�ʽ
function  dwMemoValueToText(AText:string):string;
function  dwMemoTextToValue(AText:string):string;

procedure showMsg(AMsg:string);

implementation


function dwMemoValueToText(AText:string):string;
begin
     Result    := StringReplace(AText,'\r\n',#13,[rfReplaceAll]);
     Result    := dwUnescape(Result);
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


procedure showMsg(AMsg:string);
begin
     {$IFDEF DEBUG}
          //ShowMessage(AMsg);
     {$ENDIF}

end;


procedure dwRealignChildren(ACtrl:TWinControl;AHorz:Boolean;ASize:Integer);
var
     iCount    : Integer;
     iItem     : Integer;
     iW        : Integer;
     iItemW    : Integer;
     //
     oCtrl     : TControl;
     //
     procedure _AutoSize(ooCtrl:TControl);
     begin
          if Assigned(GetPropInfo(ooCtrl.ClassInfo,'AutoSize')) then begin
               TPanel(ooCtrl).AutoSize  := False;
               TPanel(ooCtrl).AutoSize  := True;
          end;
     end;
begin
     //����ACtrl���ӿؼ�
     //���ˮƽ(AHorz=True), ��ȡ���пؼ��ȿ�ˮƽ����
     //�����ֱ, �����пؼ�Align=alTop


     //�õ��ӿؼ�����
     iCount    := ACtrl.ControlCount;
     if iCount = 0 then begin
          Exit;
     end;


     if AHorz then begin
          //ˮƽ����

          //��ȡ���ܿ��
          if Assigned(GetPropInfo(ACtrl.ClassInfo,'BorderWidth')) then begin
               iW   := ACtrl.Width - TPanel(ACtrl).BorderWidth;
          end else begin
               iW   := ACtrl.Width;
          end;
          iItemW    := Round(iW / iCount);

          //��������
          for iItem := 0 to ACtrl.ControlCount-1 do begin
               oCtrl     := ACtrl.Controls[iItem];
               //�Զ���С
               //_AutoSize(oCtrl);
               //
               if iItem<ACtrl.ControlCount-1 then begin
                    oCtrl.Align    := alLeft;
                    oCtrl.Width    := iItemW;
                    oCtrl.Top      := 0;
                    oCtrl.Left     := 99999;
               end else begin
                    oCtrl.Align    := alClient;
               end;

               //�Զ���С
               _AutoSize(oCtrl);
          end;

          //�Զ���С
          _AutoSize(ACtrl);
     end else begin
          //��ֱ����

          //��������
          for iItem := 0 to ACtrl.ControlCount-1 do begin
               oCtrl     := ACtrl.Controls[iItem];
               //�Զ���С
               _AutoSize(oCtrl);
               //
               oCtrl.Align    := alTop;
               oCtrl.Top      := 99999;
               if ASize>0 then begin
                    oCtrl.Height   := ASize;
               end else begin
                    //�Զ���С
                    _AutoSize(oCtrl);
               end;
          end;

          //�Զ���С
          _AutoSize(ACtrl);
     end;

end;


//��ȡ������Բ����Ϣ
function dwRadius(AJson:Variant):string;
var
     sRadius   : string;
begin
     sRadius   := dwGetJsonAttr(AJson,'radius');
     //
     Result    := '';
     if sRadius<>'' then begin
          Result    := 'border-radius:'+sRadius+';'
     end;
end;

function dwGetJsonAttr(AJson:Variant;AAttr:String):String;
var
     sHint     : String;
     joHint    : Variant;
begin
     Result    := '';
     //
     sHint     := AJson.hint;

     //����HINT����, ��������һЩ��������
     TDocVariant.New(joHint);
     if ( sHint <> '' ) and ( Pos('{',sHint) >= 0 ) and ( Pos('}',sHint) > 0 ) then begin
          try
               joHint    := _Json(sHint);
          except
               TDocVariant.New(joHint);
          end;
     end;

     //
     if not dwIsNull(joHint) then begin
          Result    := joHint._(AAttr);
     end;
end;


function dwGetProp(ACtrl:TControl;AAttr:String):String;
var
     sHint     : String;
     joHint    : Variant;
begin
     //
     sHint     := ACtrl.Hint;

     //����HINT����, ��������һЩ��������
     TDocVariant.New(joHint);
     if ( sHint <> '' ) and ( Pos('{',sHint) >= 0 ) and ( Pos('}',sHint) > 0 ) then begin
          try
               joHint    := _JSON(UTF8ToWideString(sHint));
          except
               TDocVariant.New(joHint);
          end;
     end;

     //
     Result    := '';
     if joHint.Exists(AAttr) then begin
          Result    := joHint._(AAttr);
     end;
end;

function dwSetProp(ACtrl:TControl;AAttr,AValue:String):Integer;
var
     sHint     : String;
     joHint    : Variant;
begin
     Result    := 0;
     //
     sHint     := ACtrl.Hint;

     //����HINT����, ��������һЩ��������
     TDocVariant.New(joHint);
     if ( sHint <> '' ) and ( Pos('{',sHint) >= 0 ) and ( Pos('}',sHint) > 0 ) then begin
          try
               joHint    := _Json(sHint);
          except
               TDocVariant.New(joHint);
          end;
     end;

     //�����ǰ���ڸ�����, ����ɾ��
     if joHint.Exists(AAttr) then begin
          joHint.Delete(AAttr);
     end;

     //�������
     joHint.Add(AAttr,AValue);

     //���ص�HINT�ַ���
     ACtrl.Hint     := VariantSaveJSON(joHint);


end;


function dwEscape(const StrToEscape:string):String;
var
   i:Integer;

   w:Word;
begin
     Result:='';

     for i:=1 to Length(StrToEscape) do
     begin
          w:=Word(StrToEscape[i]);

          if w in [Ord('0')..Ord('9'),Ord('A')..Ord('Z'),Ord('a')..Ord('z')] then
             Result:=Result+Char(w)
          else if w<=255 then
               Result:=Result+'%'+IntToHex(w,2)
          else
               Result:=Result+'%u'+IntToHex(w,4);
     end;
end;

function dwUnescape(S: string): string;
var
     i0,i1     : Integer;
begin
     Result := '';
     while Length(S) > 0 do
     begin
          if S[1]<>'%' then
          begin
               Result    := Result + S[1];
               Delete(S,1,1);
          end
          else
          begin
               Delete(S,1,1);
               if S[1]='u' then
               begin
                    try
                         //Result    := Result + Chr(StrToInt('$'+Copy(S, 2, 2)))+ Chr(StrToInt('$'+Copy(S, 4, 2)));
                         i0   := StrToInt('$'+Copy(S, 2, 2));
                         i1   := StrToInt('$'+Copy(S, 4, 2));
                         Result    := Result + WideChar((i0 shl 8) or i1);
                    except
                         ShowMessage(Result);

                    end;
                    Delete(S,1,5);
               end
               else
               begin
                    try
                         Result    := Result + Chr(StrToInt('$'+Copy(S, 1, 2)));
                    except
                         ShowMessage(Result);

                    end;
                    Delete(S,1,2);
               end;
          end;
     end;
end;




function dwConvertStr(AStr:String):String;
begin
     //�滻�ո�
     Result    := StringReplace(AStr,' ','&ensp;',[rfReplaceAll]);
end;



function dwBoolToStr(AVal:Boolean):string;
begin
     if AVal then begin
          Result    := 'true';
     end else begin
          Result    := 'false';
     end;
end;

function dwIsNull(AVar:Variant):Boolean;
begin
     Result    := (lowerCase(VarToStr(AVar)) = 'null') or (VarToStr(AVar) = '');
end;


function HTTPEncodeEx(const AStr: String): String;
const
     NoConversion = ['A'..'Z','a'..'z','*','@','.','_','-','0'..'9','$','!','''','(',')'];
var
     Sp, Rp: PChar;
begin
     SetLength(Result, Length(AStr) * 3);
     Sp := PChar(AStr);
     Rp := PChar(Result);
     while Sp^ <> #0 do begin
          if Sp^ in NoConversion then begin
               Rp^ := Sp^
          end else begin
               FormatBuf(Rp^, 3, '%%%.2x', 6, [Ord(Sp^)]);
               Inc(Rp,2);
          end;
          Inc(Rp);
          Inc(Sp);
     end;
     SetLength(Result, Rp - PChar(Result));
end;

function dwEncodeURIComponent(S:AnsiString):AnsiString;
begin
     Result    := HTTPEncodeEx(AnsiToUtf8(S));
end;


function dwColor(AColor:Integer):string;
begin
     Result := Format('#%.2x%.2x%.2x',[GetRValue(ColorToRGB(AColor)),GetGValue(ColorToRGB(AColor)),GetBValue(ColorToRGB(AColor))]);
end;



//���ܺ���
function dwDecryptKey (Src:String; Key:String):string;
var
     KeyLen :Integer;
     KeyPos :Integer;
     offset :Integer;
     dest :string;
     SrcPos :Integer;
     SrcAsc :Integer;
     TmpSrcAsc :Integer;
begin
     try
          KeyLen:=Length(Key);
          if KeyLen = 0 then key:='Think Space';
          KeyPos:=0;
          offset:=StrToInt('$'+ copy(src,1,2));
          SrcPos:=3;
          repeat
               SrcAsc:=StrToInt('$'+ copy(src,SrcPos,2));
               if KeyPos < KeyLen Then KeyPos := KeyPos + 1 else KeyPos := 1;
               TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
               if TmpSrcAsc <= offset then
                    TmpSrcAsc := 255 + TmpSrcAsc - offset
               else
                    TmpSrcAsc := TmpSrcAsc - offset;
               dest := dest + chr(TmpSrcAsc);
               offset:=srcAsc;
               SrcPos:=SrcPos + 2;
          until SrcPos >= Length(Src);
               Result:=Dest;
     except
          Result    := 'ias@njw#oriu$we_em1!83~4r`mskjhr?';
     end;
end;


function dwIIF(ABool:Boolean;AYes,ANo:string):string;
begin
     if ABool then begin
          Result    := AYes;
     end else begin
          Result    := ANo;
     end;
end;

function dwVisible(ACtrl:TControl):String;
begin
     Result    := ' v-if="'+ACtrl.Name+'__vis"';
end;

function dwDisable(ACtrl:TControl):String;
begin
     Result    := ' :disabled="'+ACtrl.Name+'__dis"';
end;

function dwGetHintJson(ACtrl:TControl):Variant;
var
     sHint     : String;
begin
     sHint     := ACtrl.Hint;
     TDocVariant.New(Result);
     if ( sHint <> '' ) and ( sHint[1] = '{' ) and ( sHint[Length(sHint)] = '}' ) then begin
          try
               Result    := _Json(sHint);
          except
               TDocVariant.New(Result);
          end;
     end;
end;

function dwLTWH(ACtrl:TControl):String;  //���Ը���λ�õ��÷�
var
     joHint    : Variant;
     sZI       : String;
begin
     //
     joHint    := dwGetHintJson(ACtrl);

     //
     if joHint.Exists('z-index')  then begin
          sZI  := 'z-index:'+IntToStr(Min(joHint._('z-index'),998))+';';
     end;

     //
     with ACtrl do begin
          Result    := ' :style="{left:'+Name+'__lef,top:'+Name+'__top,width:'+Name+'__wid,height:'+Name+'__hei}"'
                    +' style="position:absolute;'+sZI;
     end;
end;

function dwGetHintValue(AHint:Variant;AJsonName,AHtmlName,ADefault:String):String;
begin
     if AHint.Exists(AJsonName) then begin
          Result    := AnsiString(' '+AHtmlName+'="'+AHint._(AJsonName)+'"');
     end else begin
          Result    := ADefault;
     end;
end;



end.
