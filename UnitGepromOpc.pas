unit UnitGepromOpc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses UnitGepromMain, UnitGepromCarr;

{$R *.DFM}


procedure Prep(a:longint);


{Preparação dos endereços}
procedure loop_eoc(addr:Longint);
var x:longint;
begin
 x:=addr;
 Form6.Caption:='Carregando endereços...';
 Form6.Gauge1.MaxValue:=addr;
 Form1.StringGrid1.RowCount:=(addr+2);
  For x:=0 to addr do
  Form1.StringGrid1.Cells[0,(x+1)]:=IntToHex(x,4);
  Form6.Gauge1.Progress:=x;
 end;

 begin
 Form6.Show;
 Case a of
      16:Loop_eoc(2047);
      32:Loop_eoc(4095);
      64:Loop_eoc(8191);
      128:Loop_eoc(16383);
      256:Loop_eoc(32767);
      512:Loop_eoc(50000);
 end;
 UnitGepromMain.tipo_mem:=a;
 Form6.Close;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
Self.Close;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Enabled:=True;
end;

procedure TForm5.Button1Click(Sender: TObject);

begin
 If Form5.RadioGroup1.ItemIndex=0 then Prep(16);
 If Form5.RadioGroup1.ItemIndex=1 then Prep(32);
 If Form5.RadioGroup1.ItemIndex=2 then Prep(64);
 If Form5.RadioGroup1.ItemIndex=3 then Prep(128);
 If Form5.RadioGroup1.ItemIndex=4 then Prep(256);
 If Form5.RadioGroup1.ItemIndex=5 then Prep(512);
 Form5.Close;
end;

procedure TForm5.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
GroupBox1.Enabled:=CheckBox1.Checked;
Combobox1.Enabled:=CheckBox1.Checked;
Button3.Enabled:=CheckBox1.Checked;
end;

end.
