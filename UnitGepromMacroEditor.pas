unit UnitGepromMacroEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls;

type
  TForm8 = class(TForm)
    MainMenu1: TMainMenu;
    Compilar1: TMenuItem;
    Opes1: TMenuItem;
    CriarBDM1: TMenuItem;
    TransferirparaEWriter1: TMenuItem;
    Sair1: TMenuItem;
    Compilador1: TMenuItem;
    Memo1: TMemo;
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.DFM}

procedure TForm8.Sair1Click(Sender: TObject);
begin
Form8.Close;
end;

end.
