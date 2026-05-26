unit DM.Database;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, Data.DB, FireDAC.Phys.IBBase;

type
  TDMDatabase = class(TDataModule)
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    Conn: TFDConnection;
  public
    // Configura a conexão do BD que será utilizada
    procedure ConfigConnection(const ADatabasePath: string);
  end;

var
  DMDatabase: TDMDatabase;

implementation

{$R *.dfm}

procedure TDMDatabase.ConfigConnection(const ADatabasePath: string);
begin
  Conn.Connected := False;
  Conn.Params.Clear;

  Conn.DriverName := 'FB';
  Conn.Params.Add('Database=' + ADatabasePath);
  Conn.Params.Add('User_Name=SYSDBA');
  Conn.Params.Add('Password=masterkey');
  Conn.Params.Add('CharacterSet=UTF8');
end;

end.
