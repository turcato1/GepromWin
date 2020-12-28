unit UnitGepromInDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  tipo_valor:string[12];
  ReadASC:Char;

implementation

uses UnitGepromMain, UnitGepromDlgErro;

{$R *.DFM}

Function Power(b:integer;e:integer):integer;
var i,p:integer;
begin
 i:=0;
 p:=b;
 For i:=0 to e do
  begin
   If i=0 then p:=1;
   If i=1 then p:=b;
   If i>1 then p:=p*b;
  end;
      Power:=p;
      end;



{Função de Conversão Binário(string) -> Decimal(integer)}

Function BinToInt(s:string):integer;
var i,parc:integer;
    sc:string[1];
begin
 parc:=0;
 i:=0;
 If Length(s)=8 then
  begin
   For i:=1 to 8 do
    begin
     sc:=Copy(s,i,1);
     If (sc='1') or (sc='0') then
      begin
       If sc='1' then parc:=parc+Power(2,(8-i));
      end;
    end;
   BinToInt:=parc;
  end
  else ShowMessage('Valor incorreto');
end;


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

{Função para testar a integridade do valor e determinar
sua colocação no StringGrid}

Function Testar(a:string):string;
var int,i,code:integer;
begin
 If a='hexadecimal' then
  begin
   If (Pos(',',Form3.Edit1.Text)=0) and (Pos('.',Form3.Edit1.Text)=0) then
   begin
    Val(('$'+Form3.Edit1.Text),int,code);
    If (int<=$FF) and (int>=$0) and (code=0)  then
     begin
      Testar:=UpperCase(Form3.Edit1.Text);
      Form1.StringGrid1.Cells[(col+1),lin]:=IntToStr(int);
      Form1.StringGrid1.Cells[(col+2),lin]:=IntToBin(int);
      Form1.StringGrid1.Cells[(col+3),lin]:=Chr(int);
    end
    else ShowMessage('Valor Incorreto');
   end;
  end;

 If a='decimal' then
 begin
  If (Pos(',',Form3.Edit1.Text)=0) and (Pos('.',Form3.Edit1.Text)=0) then
   begin
    Val(Form3.Edit1.Text,i,code);
    If (i<=255) and (i>=0) then
     begin
      Testar:=Form3.Edit1.Text;
      Form1.StringGrid1.Cells[(col-1),lin]:=IntToHex(i,2);
      Form1.StringGrid1.Cells[(col+1),lin]:=IntToBin(i);
      Form1.StringGrid1.Cells[(col+2),lin]:=Chr(i);
     end
    else ShowMessage('Valor incorreto');
   end;
 end;

 If a='binário' then
 begin
  If Length(Form3.Edit1.Text)<=8 then
  begin
   i:=BinToInt(Form3.Edit1.Text);
   If (i<=255) and (i>=0) then
    begin
     Form1.StringGrid1.Cells[(col-2),lin]:=IntToHex(i,2);
     Form1.StringGrid1.Cells[(col-1),lin]:=IntToStr(i);
     Form1.StringGrid1.Cells[(col+1),lin]:=Chr(i);
     Testar:=Form3.Edit1.Text;
    end
    else ShowMessage('Valor incorreto');
  end;
 end;

 If a='ASCII' then
 begin
  If (Length(Form3.Edit1.Text)=1) then
   begin
    Form1.StringGrid1.Cells[(col-3),lin]:=IntToHex(Ord(ReadASC),2);
    Form1.StringGrid1.Cells[(col-1),lin]:=IntToBin(Ord(ReadASC));
    Form1.StringGrid1.Cells[(col-2),lin]:=InttoStr(Ord(ReadASC));
    Testar:=Form3.Edit1.Text;
   end
 else ShowMessage('Valor incorreto');
 end;
end;

procedure TForm3.Button1Click(Sender: TObject);

begin
tipo_valor:=Label2.Caption;
Form1.StringGrid1.Cells[col,lin]:= Testar(tipo_valor);
If Testar(tipo_valor)<>'' then Form3.Close;
end;

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin
If Key=#27 then Form3.Close;
end;

procedure TForm3.Button1KeyPress(Sender: TObject; var Key: Char);
begin
If Key=#27 then Form3.Close;
end;

procedure TForm3.Edit1KeyPress(Sender: TObject; var Key: Char);
var auxstr:string[5];
begin
auxstr:=Form3.Label2.Caption;
If Key=#27 then Form3.Close;
If (auxstr='ASCII') then ReadASC:=Key;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
Edit1.SetFocus;
end;

end.
