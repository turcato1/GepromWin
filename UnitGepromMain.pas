unit UnitGepromMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,Clipbrd;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Sobre1: TMenuItem;
    Arquivo1: TMenuItem;
    Editar1: TMenuItem;
    Parametros1: TMenuItem;
    Novo: TMenuItem;
    Abrir2: TMenuItem;
    Salvarcomo1: TMenuItem;
    Salvar1: TMenuItem;
    Sair1: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Timer2: TTimer;
    Portas1: TMenuItem;
    Portas2: TMenuItem;
    Fonte1: TMenuItem;
    N1: TMenuItem;
    Opes1: TMenuItem;
    FontDialog1: TFontDialog;
    Copiar1: TMenuItem;
    Recortar1: TMenuItem;
    Colar1: TMenuItem;
    Ferramentas1: TMenuItem;
    MacroEditor1: TMenuItem;
    procedure Sobre1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Abrir2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Salvarcomo1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Salvar1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Opes1Click(Sender: TObject);
    procedure NovoClick(Sender: TObject);
    procedure Fonte1Click(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Colar1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MacroEditor1Click(Sender: TObject);
    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  NomeArq,StrCab:string;
  x,y,tipo_mem,ind:integer;
  Lin,Col:LongInt;
  nomeatr,saved:boolean;

implementation

uses UnitGepromAbout, UnitGepromAbert, UnitGepromInDados, UnitGepromOpc,
  UnitGepromCarr, UnitMacredapr, UnitGepromMacroEditor;

{$R *.DFM}

{Função de Conversão Decimal(integer) -> Binário(string)}

Function IntToBin(s:integer):string;
var index,aux:integer;
    numst:string[8];
begin
 index:=1;
 aux:=s;
 numst:='';
 For index:=1 to 8 do
  begin
   If index<8 then
    begin
     numst:=IntToStr(aux mod 2)+numst;
     aux:=aux div 2;
    end;
   If index=8 then numst:=IntToStr(aux)+numst;
  end;
IntToBin:=numst;
end;

// ** {Procedimento para salvar arquivo} **
procedure Salvar;
var indice:longint;
    StrData:string[20];
    Mayumi: System.TextFile;
    Cancel:Boolean;
begin
 Cancel:=true;
 If nomeatr=false then
  begin
   If Form1.SaveDialog1.Execute then
    begin
     Cancel:=False;
     nomeatr:=True;
     NomeArq:=Form1.SaveDialog1.FileName;
    end;
  end
  else Cancel:=False;
  If Cancel=False then
   begin
    Form1.StatusBar1.Panels.Items[0].Text:= NomeArq;
    AssignFile(Mayumi,Form1.SaveDialog1.FileName);
    Rewrite(Mayumi);
    Reset(Mayumi);
    StrCab:='@tipomem 27'+IntToStr(tipo_mem)+';';
    Append(Mayumi); { é necessario utilizar antes de qqer oper. c/ arquivo}
    Writeln(Mayumi,StrCab);
    Append(Mayumi);
    Writeln(Mayumi);
    Form6.Show;
    Form6.Gauge1.MaxValue:=Form1.StringGrid1.RowCount;
    Form6.Caption:='Salvando para arquivo...';
    For indice:=1 to Form1.StringGrid1.RowCount do
     begin
      StrData:=Form1.StringGrid1.Cells[0,indice]+':'+
      Form1.StringGrid1.Cells[2,indice]+';';
      If Form1.StringGrid1.Cells[2,indice]<>'' then
       begin
        Append(Mayumi);
        Writeln(Mayumi,StrData);
       end;
       Form6.Gauge1.Progress:=indice;
     end;
    StrData:='@fim;';
    Append(Mayumi);
    Writeln(Mayumi);
    Append(Mayumi);
    Write(Mayumi,StrData);
    Form6.Close;
    CloseFile(Mayumi);
    saved:=true;
   end;

end;

//** {Preparação dos endereços} **
procedure Prep(a:integer);

procedure loop_eoc(addr:Longint);
begin
 Form1.StringGrid1.RowCount:=(addr+2);
  For addr:=0 to addr do
  Form1.StringGrid1.Cells[0,(addr+1)]:=IntToHex(addr,4);
 end;

 begin
 tipo_mem:=a;
 Case a of
      16:Loop_eoc(2047);
      32:Loop_eoc(4095);
      64:Loop_eoc(8191);
      128:Loop_eoc(16383);
      256:Loop_eoc(32767);
      512:Loop_eoc(65535);
 end;
end;

//** {Mostrar função e endereço selecionados} **
procedure Proc_Mostrar(a:integer;b:longint);

begin
If a=1 then
begin
 Form3.Label2.Caption:= 'hexadecimal';
 Form1.StatusBar1.Panels.Items[2].Text:= 'Hexadecimal';
end;

If a=2 then
begin
 Form3.Label2.Caption:= 'decimal';
 Form1.StatusBar1.Panels.Items[2].Text:= 'Decimal';
end;

If a=3 then
begin
 Form3.Label2.Caption:= 'binário';
 Form1.StatusBar1.Panels.Items[2].Text:= 'Binário';
end;

If a=4 then
begin
 Form3.Label2.Caption:= 'ASCII';
 Form1.StatusBar1.Panels.Items[2].Text:= 'ASCII';
end;

Form1.StatusBar1.Panels.Items[1].Text:=
Form1.StringGrid1.Cells[0,lin];

end;

// ** {Procedimento de limpeza de Grid} **
procedure Limpar;
var indice:integer;
begin
 For indice:=1 to Form1.StringGrid1.RowCount do
 begin
  Form1.StringGrid1.Cells[1,indice]:='';
  Form1.StringGrid1.Cells[2,indice]:='';
  Form1.StringGrid1.Cells[3,indice]:='';
  Form1.StringGrid1.Cells[4,indice]:='';
 end;
end;

//** {Procedimento na abertura de um novo arquivo} **
procedure Novo_Arq;
var Cancel:boolean;
begin
 Cancel:=false;
 If (saved=false) then
  begin
   Case MessageDlg('Deseja Salvar '+'"'+NomeArq+'"'+' ?', mtWarning, mbYesNoCancel, 0) of
        mrYes: Salvar;
        mrCancel: Cancel:=true;
        end;
  end;
 If Cancel=false then
  begin
   //saved:=False;
   NomeArq:='SemTitulo';
   Form1.SaveDialog1.FileName:=NomeArq;
   Form1.StatusBar1.Panels.Items[0].Text:= NomeArq;
   Limpar;
  end;
end;

// ** {Procedimento para abertura de arquivos} **
procedure Abrir;
var Cancel1,erro:boolean;
    Mayumi:Text;
    strleitura:string[1];
    strtotal,endstr,datastr:string;
    ponteiro,endint,dataint:longint;
    leit_mem,code:integer;

procedure Erro_leitura;
 begin
 ShowMessage('Arquivo Corrompido na posição '+IntToStr(FilePos(Mayumi)));
 erro:=true;
 end;

begin
 erro:=false;
 Cancel1:=false;
 ponteiro:=0;
 dataint:=0;
 endint:=0;
 leit_mem:=0;
 code:=0;
 strleitura:='';
 strtotal:='';
 endstr:='';
 datastr:='';
 If (saved=false) then
  begin
   Case MessageDlg('Deseja Salvar '+'"'+NomeArq+'"'+' ?', mtWarning, mbYesNoCancel, 0) of
        mrYes: Salvar;
        mrCancel: Cancel1:=true;
        end;
  end;
   //saved:=False;
   If Form1.OpenDialog1.Execute then
    begin
     Limpar;
     NomeArq:=Form1.OpenDialog1.FileName;
     Form1.SaveDialog1.FileName:=NomeArq;
     Form1.StatusBar1.Panels.Items[0].Text:= NomeArq;
     AssignFile(Mayumi,NomeArq);
     Reset(Mayumi);

     While (strtotal='') and (code<120) do
     begin
     inc(code);
     Readln(Mayumi,strtotal);
     end;
     Delete(strtotal,1,11);
     Delete(strtotal,Pos(';',strtotal),1);
     code:=0;
     Val(strtotal,leit_mem,code);
     If erro=false then
      begin
       tipo_mem:=leit_mem;
       Prep(leit_mem);
       Case leit_mem of
            16:Form5.RadioGroup1.ItemIndex:=0;
            32:Form5.RadioGroup1.ItemIndex:=1;
            64:Form5.RadioGroup1.ItemIndex:=2;
            128:Form5.RadioGroup1.ItemIndex:=3;
            256:Form5.RadioGroup1.ItemIndex:=4;
            end;

      strleitura:='';
      strtotal:='';
      ponteiro:=0;

      Form6.Show;
      Form6.Gauge1.MaxValue:=Form1.StringGrid1.RowCount;
      Form6.Caption:='Carregando arquivo...';

      Repeat
          inc(ponteiro);
          Readln(Mayumi,strtotal);
      Until (strtotal<>'') or (ponteiro>120);
      If ponteiro>120 then erro_leitura;
      ponteiro:=0;
      While (strtotal<>'@fim;') and (erro=false) do
       begin
        If Pos(':',strtotal)<>0 then
        begin
         Form6.Gauge1.Progress:=ponteiro;
         endstr:=Copy(strtotal,1,4);
         endstr:='$'+endstr;
         Val(endstr,endint,code);
        If code<>0 then erro_leitura;
        If erro=false then
         begin
          Repeat
            inc(ponteiro)
          Until (Form1.StringGrid1.Cells[0,ponteiro]=InttoHex(endint,4)) or
          (ponteiro>endint+1);
         datastr:=strtotal;
         Delete(datastr, Pos(';',datastr),1);
         datastr:=Copy(datastr,6,Length(datastr));
         Val(datastr,dataint,code);
         If code<>0 then erro_leitura;
         If erro=false then
         begin
          Form1.StringGrid1.Cells[1,ponteiro]:=IntToHex(dataint,2);
          Form1.StringGrid1.Cells[2,ponteiro]:=datastr;
          Form1.StringGrid1.Cells[3,ponteiro]:=IntToBin(dataint);
          Form1.StringGrid1.Cells[4,ponteiro]:=Chr(dataint);
         end;
        end;
       end;
      code:=0;
      Repeat
       inc(code);
       Readln(Mayumi,strtotal);
      Until (strtotal<>'') or (code<120);
      end;
      code:=0;
      Form6.Close;
      CloseFile(Mayumi);
     end;
 end;
end;



// *** Fim dos procedimentos de usuário ***

procedure TForm1.Sobre1Click(Sender: TObject);
begin
Aboutbox.Show;
Aboutbox.Comments.Top:=166;
Aboutbox.Copyright.Top:=166;
AboutBox.Copyright.Left:=48;
AboutBox.Comments.Left:=120;
AboutBox.Timer4.Enabled:=True;
AboutBox.Timer5.Enabled:=False;
AboutBox.Timer6.Enabled:=False;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
Aboutbox.Show;
Aboutbox.Comments.Top:=146;
Aboutbox.Copyright.Top:=146;
AboutBox.Copyright.Left:=48;
AboutBox.Comments.Left:=120;
end;

procedure TForm1.Abrir2Click(Sender: TObject);
begin
Abrir;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
Abrir;
end;

procedure TForm1.FormCreate(Sender: TObject);
var item:integer;
begin
{Preparação do Ambiente. Criação dos Campos}
StringGrid1.Cells[1,0]:='Endereço';
StringGrid1.Cells[1,0]:='Hexadecimal';
StringGrid1.Cells[2,0]:='Decimal';
StringGrid1.Cells[3,0]:='Binario';
StringGrid1.Cells[4,0]:='ASCII';
Timer1.Enabled:=True;
nomeatr:=false;
saved:=true;
NomeArq:='SemTitulo';
Form1.SaveDialog1.FileName:=NomeArq;
Form1.StatusBar1.Panels.Items[0].Text:= NomeArq;
ind:=0;

{Verificação das Opções Default}
item:=0;
Case item of
     0: Prep(16);
     1: Prep(32);
     2: Prep(64);
     3: Prep(128);
     4: Prep(256);
     5: Prep(512);
     end;
// StringGrid1.Font:=FontDialog1.Font;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Timer1.Enabled:=False;
Timer2.Enabled:=True;
Form1.Enabled:=False;
Form2.Show;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
Timer2.Enabled:=False;
Form2.Close;
Form1.Enabled:=True;
end;



procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
Salvar;
end;

procedure TForm1.Salvarcomo1Click(Sender: TObject);
begin
 nomeatr:=false;
 Salvar;
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.Salvar1Click(Sender: TObject);
begin
Salvar;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
Novo_Arq;
nomeatr:=False;
end;

procedure TForm1.StatusBar1Click(Sender: TObject);
begin
Salvar;
end;

procedure TForm1.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
StringGrid1.MouseToCell(x,y,col,lin);
If (lin<>0) and (col<>0) then
 begin
  Proc_Mostrar(col,lin);
  Form3.Edit1.Text:=StringGrid1.Cells[col,lin];
  Form3.Show;
 end;
saved:=false;

end;

procedure TForm1.Opes1Click(Sender: TObject);
begin
Form5.Show;
Form1.Enabled:=False;
end;

procedure TForm1.NovoClick(Sender: TObject);
begin
Novo_Arq;
nomeatr:=False;
end;

procedure TForm1.Fonte1Click(Sender: TObject);
begin
FontDialog1.Font:=StringGrid1.Font;
 If FontDialog1.Execute then
  begin
   StringGrid1.Font:=FontDialog1.Font;
   Form3.Edit1.Font:=FontDialog1.Font;
  end;
end;

procedure TForm1.Copiar1Click(Sender: TObject);
begin
// CopyToClipboard;
//Clipboard;
//SetClipboard.Copy;
end;

procedure TForm1.Colar1Click(Sender: TObject);
begin
//SetClipboard.Paste;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 If (saved=false) then
  begin
   Case MessageDlg('Deseja Salvar '+'"'+NomeArq+'"'+' ?', mtWarning, mbYesNoCancel, 0) of
        mrYes: Salvar;
        mrCancel:CanClose:=false;
        end;
  end;
end;

procedure TForm1.MacroEditor1Click(Sender: TObject);
begin
Form7.Show;
Form7.Timer1.Enabled:=True;
end;

end.
