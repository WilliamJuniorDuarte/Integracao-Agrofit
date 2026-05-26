unit Repository.ProdutoTecnico;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  Model.ProdutoTecnico;

type
  TProdutoTecnicoRepository = class
  private
    FConn: TFDConnection;
  public
    constructor Create(AConn: TFDConnection);

    //Faz a busca a partir do número de registro
    function SearchByNumeroRegistro(const ANumeroRegistro: string): TProdutoTecnico;
    //Valida se o registro já existe no banco local
    function Exists(const ANumeroRegistro: string): Boolean;

    //Insere o registro
    procedure Insert(const AProduto: TProdutoTecnico);
    //Atualiza o registro com os novos dados
    procedure Update(const AProduto: TProdutoTecnico);
  end;

implementation

constructor TProdutoTecnicoRepository.Create(AConn: TFDConnection);
begin
  FConn := AConn;
end;

function TProdutoTecnicoRepository.Exists(const ANumeroRegistro: string): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text :=
      'SELECT 1 FROM PRODUTO_TECNICO WHERE NUMERO_REGISTRO = :NUM';
    Qry.ParamByName('NUM').AsString := ANumeroRegistro;
    Qry.Open;

    Result := not Qry.IsEmpty;
  finally
    Qry.Free;
  end;
end;

procedure TProdutoTecnicoRepository.Insert(const AProduto: TProdutoTecnico);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text :=
      'INSERT INTO PRODUTO_TECNICO ' +
      '(NUMERO_REGISTRO, MARCA_COMERCIAL, CLASSE_AGRONOMICA, TITULAR_REGISTRO, ' +
      ' CLASSIFICACAO_TOXICOLOGICA, CLASSIFICACAO_AMBIENTAL, URL_AGROFIT) ' +
      'VALUES (:NUM, :MARCA, :CLASSE, :TITULAR, :TOX, :AMB, :URL)';

    Qry.ParamByName('NUM').AsString     := AProduto.NumeroRegistro;
    Qry.ParamByName('MARCA').AsString   := String.Join('; ', AProduto.MarcaComercial);
    Qry.ParamByName('CLASSE').AsString  := String.Join('; ', AProduto.ClasseCategoriaAgronomica);
    Qry.ParamByName('TITULAR').AsString := AProduto.TitularRegistro;
    Qry.ParamByName('TOX').AsString     := AProduto.ClassificacaoToxicologica;
    Qry.ParamByName('AMB').AsString     := AProduto.ClassificacaoAmbiental;
    Qry.ParamByName('URL').AsString     := AProduto.UrlAgrofit;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TProdutoTecnicoRepository.Update(const AProduto: TProdutoTecnico);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text :=
      'UPDATE PRODUTO_TECNICO SET ' +
      ' MARCA_COMERCIAL = :MARCA, ' +
      ' CLASSE_AGRONOMICA = :CLASSE, ' +
      ' TITULAR_REGISTRO = :TITULAR, ' +
      ' CLASSIFICACAO_TOXICOLOGICA = :TOX, ' +
      ' CLASSIFICACAO_AMBIENTAL = :AMB, ' +
      ' URL_AGROFIT = :URL ' +
      'WHERE NUMERO_REGISTRO = :NUM';

    Qry.ParamByName('NUM').AsString     := AProduto.NumeroRegistro;
    Qry.ParamByName('MARCA').AsString   := String.Join('; ', AProduto.MarcaComercial);
    Qry.ParamByName('CLASSE').AsString  := String.Join('; ', AProduto.ClasseCategoriaAgronomica);
    Qry.ParamByName('TITULAR').AsString := AProduto.TitularRegistro;
    Qry.ParamByName('TOX').AsString     := AProduto.ClassificacaoToxicologica;
    Qry.ParamByName('AMB').AsString     := AProduto.ClassificacaoAmbiental;
    Qry.ParamByName('URL').AsString     := AProduto.UrlAgrofit;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TProdutoTecnicoRepository.SearchByNumeroRegistro(const ANumeroRegistro: string): TProdutoTecnico;
var
  Qry: TFDQuery;
begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text :=
      'SELECT * FROM PRODUTO_TECNICO WHERE NUMERO_REGISTRO = :NUM';
    Qry.ParamByName('NUM').AsString := ANumeroRegistro;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    Result := TProdutoTecnico.Create;
    Result.NumeroRegistro           := Qry.FieldByName('NUMERO_REGISTRO').AsString;
    Result.TitularRegistro          := Qry.FieldByName('TITULAR_REGISTRO').AsString;
    Result.ClassificacaoToxicologica:= Qry.FieldByName('CLASSIFICACAO_TOXICOLOGICA').AsString;
    Result.ClassificacaoAmbiental   := Qry.FieldByName('CLASSIFICACAO_AMBIENTAL').AsString;

    Result.MarcaComercial            := Qry.FieldByName('MARCA_COMERCIAL').AsString.Split([';']);
    Result.ClasseCategoriaAgronomica := Qry.FieldByName('CLASSE_AGRONOMICA').AsString.Split([';']);
  finally
    Qry.Free;
  end;
end;

end.
