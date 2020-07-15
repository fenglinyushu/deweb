unit DriverUnit;

interface

uses
     dwDatas,
     dwCore,
     //
     CloneComponents,
     //
     Windows, Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TDriver = class(TForm)
    Panel_Content: TPanel;
    Panel_00_Logo: TPanel;
    Panel1: TPanel;
    Img: TImage;
    Label_Title: TLabel;
    Panel_Space1: TPanel;
    Panel2: TPanel;
    Panel_ZZ_Buttons: TPanel;
    Button_OK: TButton;
    Panel__02_Judge: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel5: TPanel;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    Panel_01_Select: TPanel;
    Label_Item: TLabel;
    Panel8: TPanel;
    RadioButton17: TRadioButton;
    RadioButton18: TRadioButton;
    RadioButton15: TRadioButton;
    RadioButton16: TRadioButton;
    procedure RadioButton17Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button_OKClick(Sender: TObject);
    function FormHelp(Command: Word; Data: NativeInt;
      var CallHelp: Boolean): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
     Driver: TDriver;

implementation

{$R *.dfm}

procedure TDriver.Button_OKClick(Sender: TObject);
var
     oPanel    : TPanel;
     oPanelAll : TPanel;
     //
     iScore    : Integer;
     iCtrl     : Integer;
     iRight    : Integer;
begin
     iScore    := 0;

     //
     for iCtrl := 0 to Panel_Content.ControlCount-1 do begin
          oPanel    := TPanel(Panel_Content.Controls[iCtrl]);
          //
          if (oPanel = Panel_00_Logo) or (oPanel = Panel_ZZ_Buttons) then begin
               Continue;
          end;
          if not oPanel.Visible then begin
               Continue;
          end;

          oPanelAll := TPanel(oPanel.Controls[1]);

          //
          iRight    := oPanel.Tag;
          //
          if TRadioButton(oPanelAll.Controls[iRight]).Checked then begin
               Inc(iScore,5);
          end;

     end;

     //
     if iScore<60 then begin
          dwShowMessage('成绩很差,分数为 '+IntToStr(iScore)+', 不要偷懒哟!','成绩','OK',Self);
     end else if iScore < 70 then begin
          dwShowMessage('成绩勉强及格,分数为 '+IntToStr(iScore)+',加油!','成绩','OK',Self);
     end else if iScore < 80 then begin
          dwShowMessage('成绩还可以!,分数为 '+IntToStr(iScore)+',继续努力!','成绩','OK',Self);
     end else begin
          dwShowMessage('成绩很好! 分数为 '+IntToStr(iScore)+',你真棒!','成绩','OK',Self);
     end;
end;

function TDriver.FormHelp(Command: Word; Data: NativeInt;  var CallHelp: Boolean): Boolean;
var
     iW,iH     : Integer;
     sOS       : String;
begin
     sOS  := dwGetProp(Self,'os');

     //根据是否移动端, 分别处理. 因为 clientwidth/clientheight取得的是实际值, 也就是分辨率;而手机端采用的是虚拟值
     if (sOS = '0') or (sOS='1') then begin
          Panel_ZZ_Buttons.Align   := alNone;
          Panel_ZZ_Buttons.Width   := 130;
          Panel_ZZ_Buttons.Top     := Data+StrTointDef(dwGetProp(Self,'clientheight'),0)-Panel_ZZ_Buttons.Height-15;
          Panel_ZZ_Buttons.Left    := StrTointDef(dwGetProp(Self,'clientwidth'),0)-Panel_ZZ_Buttons.Width-15;
     end else begin
          Panel_ZZ_Buttons.Align   := alNone;
          Panel_ZZ_Buttons.Width   := 130;
          Panel_ZZ_Buttons.Top     := Data+StrTointDef(dwGetProp(Self,'screenheight'),0)-Panel_ZZ_Buttons.Height-25;
          Panel_ZZ_Buttons.Left    := StrTointDef(dwGetProp(Self,'screenwidth'),0)-Panel_ZZ_Buttons.Width-15;
     end;
end;

procedure TDriver.FormMouseUp(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
var
     oPanel    : TPanel;
     iCtrl     : Integer;
begin
     //
     if (X>700) and (Y>700) then begin
          //PC等高分辨率

          Width     := X;
          Height    := Y;

          //
          Panel_Content.Top        := 30;
          Panel_Content.Width      := X;
          Panel_Content.Height     := Y-60;


          //
          for iCtrl := 0 to Panel_Content.ControlCount-1 do begin
               oPanel    := TPanel(Panel_Content.Controls[iCtrl]);

               //
               if (oPanel = Panel_00_Logo) or (oPanel = Panel_ZZ_Buttons) then begin
                    Continue;
               end;

               //以下两行是为了刷新自动高度
               TLabel(oPanel.Controls[0]).AutoSize     := False;
               TLabel(oPanel.Controls[0]).AutoSize     := True;
               //以下两行是为了解决网页显示不全的问题
               TLabel(oPanel.Controls[0]).AutoSize     := False;
               TLabel(oPanel.Controls[0]).Height       := TLabel(oPanel.Controls[0]).Height+5;

               //
               dwRealignChildren(TPanel(oPanel.Controls[1]),True,0);
               TPanel(oPanel.Controls[1]).AutoSize     := False;
               TPanel(oPanel.Controls[1]).Height       := 40;
          end;

          //
          Panel_Content.AutoSize   := True;

          //
          dwSetHeight(self,Panel_Content.Height)

     end else begin

          Width     := X;
          Height    := Y;

          //
          Panel_Content.Top        := 30;
          Panel_Content.Height     := Y-60;
          Panel_Content.Width      := X;

          //
          for iCtrl := 0 to Panel_Content.ControlCount-1 do begin
               oPanel    := TPanel(Panel_Content.Controls[iCtrl]);

               //
               if (oPanel = Panel_00_Logo) or (oPanel = Panel_ZZ_Buttons) then begin
                    Continue;
               end;

               //以下两行是为了刷新自动高度
               TLabel(oPanel.Controls[0]).AutoSize     := False;
               TLabel(oPanel.Controls[0]).AutoSize     := True;
               //以下两行是为了解决网页显示不全的问题
               TLabel(oPanel.Controls[0]).AutoSize     := False;
               TLabel(oPanel.Controls[0]).Height       := TLabel(oPanel.Controls[0]).Height+5;

               //
               dwRealignChildren(TPanel(oPanel.Controls[1]),False,0);
          end;

          //
          Panel_Content.AutoSize   := False;

          //
          dwSetHeight(self,Panel_Content.Height)
     end;

end;

procedure TDriver.FormShow(Sender: TObject);
var
     //
     iItem     : Integer;
     iCount    : Integer;
     iA,iB     : Integer;
     iC,iD     : Integer;
     iRandom   : Integer;
     //
     oPanel    : TPanel;
     oTitle    : TLabel;
     oPanelALL : TPanel;
     oCheckA   : TCheckBox;
     oCheckB   : TCheckBox;
     oCheckC   : TCheckBox;
     oCheckD   : TCheckBox;

     //
     sContent  : String;
     sTitle    : string;
     sRight    : string;
begin
     DM.ADOQuery_Driver.Filter     := 'FQuestionTypeID=1';
     DM.ADOQuery_Driver.Filtered   := True;
     DM.ADOQuery_Driver.First;

     //
     iRandom   := Random(100);
     for iItem := 0 to iRandom-1 do begin
          if DM.ADOQuery_Driver.Eof then begin
               DM.ADOQuery_Driver.First;
          end else begin
               DM.ADOQuery_Driver.Next;
          end;
     end;

     //生成20个选择题
     iCount    := 0;
     for iItem := 0 to 39 do  begin
          //
          sContent  := DM.ADOQuery_Driver.FieldByName('FContent').AsString;

          //暂时略过带图的
          if Pos('图',sContent)>0 then begin
               DM.ADOQuery_Driver.First;
               Continue;
          end;

          //略过空
          if Pos('A、',sContent)<=0 then begin
               DM.ADOQuery_Driver.First;
               Continue;
          end;


          //克隆控件
          oPanel    := TPanel(CloneComponent(Panel_01_Select));
          oPanel.Visible      := True;
          oPanel.Top          := 9999;  //置最底

          //保存答案
          sRight    := UpperCase(DM.ADOQuery_Driver.FieldByName('FRightSolution').AsString);
          if sRight = 'A' then begin
               oPanel.Tag     := 0;
          end else if sRight = 'B' then begin
               oPanel.Tag     := 1;
          end else if sRight = 'C' then begin
               oPanel.Tag     := 2;
          end else if sRight = 'D' then begin
               oPanel.Tag     := 3;
          end;

          //得到各对象
          oTitle    := TLabel(oPanel.Controls[0]);
          oPanelAll := TPanel(oPanel.Controls[1]);
          oCheckA   := TCheckBox(oPanelAll.Controls[0]);
          oCheckB   := TCheckBox(oPanelAll.Controls[1]);
          oCheckC   := TCheckBox(oPanelAll.Controls[2]);
          oCheckD   := TCheckBox(oPanelAll.Controls[3]);

          //题目
          sTitle    := IntToStr(iCount+1)+'、 '+Copy(sContent,1,Pos('A、',sContent)-1);
          sTitle    := StringReplace(sTitle,#13#10,'',[rfReplaceAll]);
          oTitle.Caption      := Trim(sTitle);
          //以下两行是为了刷新oTitle自动高度
          oTitle.AutoSize     := False;
          oTitle.AutoSize     := True;
          //以下两行是为了解决网页显示不全的问题
          oTitle.AutoSize     := False;
          oTitle.Height       := oTitle.Height+5;


          //得到ABCD选项
          iA   := Pos('A、',sContent);
          iB   := Pos('B、',sContent);
          iC   := Pos('C、',sContent);
          iD   := Pos('D、',sContent);
          oCheckA.Caption     := Trim(Copy(sContent,iA,iB-iA));
          oCheckB.Caption     := Trim(Copy(sContent,iB,iC-iB));
          oCheckC.Caption     := Trim(Copy(sContent,iC,iD-iC));
          oCheckD.Caption     := Trim(Copy(sContent,iD,Length(sContent)-iD));

          //
          oPanelAll.Top  := 40;
          dwRealignChildren(oPanelAll,False,0);
          //
          oPanel.AutoSize     := True;

          //
          DM.ADOQuery_Driver.Next;

          //
          Inc(iCount);

          //
          if iCount>=20 then begin
               break;
          end;
     end;

     //
     Panel_ZZ_Buttons.Top     := 99999;
     Panel_ZZ_Buttons.TabOrder     := 9999;



     //
     Panel_Content.AutoSize   := True;
     //
     dwSetHeight(self,Panel_Content.Height)

end;

procedure TDriver.RadioButton17Click(Sender: TObject);
var
     oPanel    : TPanel;
begin
     oPanel    := TPanel(TRadioButton(Sender).Parent);

     //先禁止事件
     TRadioButton(oPanel.Controls[0]).OnClick   := nil;
     TRadioButton(oPanel.Controls[1]).OnClick   := nil;
     TRadioButton(oPanel.Controls[2]).OnClick   := nil;
     TRadioButton(oPanel.Controls[3]).OnClick   := nil;

     //
     TRadioButton(oPanel.Controls[0]).Checked   := False;
     TRadioButton(oPanel.Controls[1]).Checked   := False;
     TRadioButton(oPanel.Controls[2]).Checked   := False;
     TRadioButton(oPanel.Controls[3]).Checked   := False;

     //
     TRadioButton(Sender).Checked  := True;

     //恢复事件
     TRadioButton(oPanel.Controls[0]).OnClick   := RadioButton17Click;
     TRadioButton(oPanel.Controls[1]).OnClick   := RadioButton17Click;
     TRadioButton(oPanel.Controls[2]).OnClick   := RadioButton17Click;
     TRadioButton(oPanel.Controls[3]).OnClick   := RadioButton17Click;
end;

end.
