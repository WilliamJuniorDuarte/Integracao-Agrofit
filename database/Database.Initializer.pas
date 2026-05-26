unit Database.Initializer;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands;

type
  TDatabaseInitializer = class
  private
    FDatabasePath: string;
    FScriptPath  : string;

    //Verifica se o arquivo do BD existe
    function DatabaseExists: Boolean;

    //Verifica se a tabela já existe para ver se o script já foi executado
    function TableExists(AConnection: TFDConnection; const ATabela: string): Boolean;

    //Cria o BD
    procedure CreateDatabase;

    //Executa os scripts do BD, Create Tables, Index, Triggers, etc...
    procedure ExecScript(AConnection: TFDConnection);
  public
    constructor Create(const ADatabasePath, AScriptPath: string);

    //Faz todas as validações e tratametnos necessários para criar o BD e deixar ele rodando
    procedure Initializer(AConnection: TFDConnection);
  end;

implementation

constructor TDatabaseInitializer.Create(const ADatabasePath, AScriptPath: string);
begin
  FDatabasePath := ADatabasePath;
  FScriptPath   := AScriptPath;
end;

function TDatabaseInitializer.DatabaseExists: Boolean;
begin
  Result := FileExists(FDatabasePath);
end;

procedure TDatabaseInitializer.CreateDatabase;
var
  Conn: TFDConnection;
begin
  Conn := TFDConnection.Create(nil);
  try
    Conn.DriverName := 'FB';
    Conn.Params.Add('Database=' + FDatabasePath);
    Conn.Params.Add('User_Name=SYSDBA');
    Conn.Params.Add('Password=masterkey');
    Conn.Params.Add('CreateDatabase=Yes');
    Conn.Connected := True;
  finally
    Conn.Free;
  end;
end;

function TDatabaseInitializer.TableExists(AConnection: TFDConnection;const ATabela: string): Boolean;
begin
  Result := AConnection.ExecSQLScalar(
    'SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ?',
    [UpperCase(ATabela)]) > 0;
end;

procedure TDatabaseInitializer.ExecScript(AConnection: TFDConnection);
var
  Script: TFDScript;
begin
  Script := TFDScript.Create(nil);
  try
    Script.Connection := AConnection;
    Script.SQLScripts.Clear;
    Script.SQLScripts.Add.SQL.LoadFromFile(FScriptPath);
    Script.ExecuteAll;
  finally
    Script.Free;
  end;
end;

procedure TDatabaseInitializer.Initializer(AConnection: TFDConnection);
begin
  if not DatabaseExists then
  begin
    ForceDirectories(ExtractFilePath(FDatabasePath));
    CreateDatabase;
  end;

  if not AConnection.Connected then
    AConnection.Connected := True;

  if not TableExists(AConnection, 'PRODUTO_TECNICO') then
    ExecScript(AConnection);
end;

end.
