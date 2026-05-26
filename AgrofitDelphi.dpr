program AgrofitDelphi;

uses
  Vcl.Forms,
  System.SysUtils,
  FireDAC.Comp.Client,
  frmMain in 'src\ui\frmMain.pas' {FormMain},
  Service.ApiAgrofit in 'src\api\Service.ApiAgrofit.pas',
  Model.ProdutoTecnico in 'src\model\Model.ProdutoTecnico.pas',
  RestClient in 'src\api\RestClient.pas',
  Database.Initializer in 'database\Database.Initializer.pas',
  DM.Database in 'src\dm\DM.Database.pas' {DMDatabase: TDataModule},
  Repository.ProdutoTecnico in 'src\repository\Repository.ProdutoTecnico.pas';

{$R *.res}

var
  RootPath: string;
  Init    : TDatabaseInitializer;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMDatabase, DMDatabase);

  RootPath    := ExtractFilePath(ParamStr(0)) ;

  DMDatabase.ConfigConnection(RootPath+ 'database\agrofit.fdb');

  Init := TDatabaseInitializer.Create(
    RootPath+ 'database\agrofit.fdb',
    RootPath+ 'database\database.sql');
  try
    Init.Initializer(DMDatabase.Conn);
  finally
    Init.Free;
  end;

  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
