unit unit1;

interface

uses
     //
     dwBase,

     //
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label3: TLabel;
    Edit_User: TEdit;
    Label4: TLabel;
    Edit_Psd: TEdit;
    Button4: TButton;
    Image_dfwlogo: TImage;
    CheckBox_Remember: TCheckBox;
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button4Click(Sender: TObject);
begin
     if (Edit_User.Text = 'admin')and(Edit_Psd.Text = '123') then begin
          //����ǰ��¼�û���Ϣд��cookie��ʵ��ʹ��ʱ�����ȼ��ܣ���д�룩
          dwSetCookie(self,'dfwuser',Edit_User.Text,1);
          //������ҳ
          dwOpenUrl(self,'/dfw.dw','');
     end else begin
          dwShowMessage('�û��������벻��ȷ��',self);
     end;
end;

end.
