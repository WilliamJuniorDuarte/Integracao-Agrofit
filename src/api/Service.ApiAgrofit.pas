unit Service.ApiAgrofit;

interface

uses
  System.JSON,
  System.SysUtils,
  REST.Json,
  RestClient,
  Model.ProdutoTecnico;

type
  TApiAgrofitService = class
  private
    FClient: TRestClient;
  public
    constructor Create;
    destructor Destroy; override;

    //Faz o GET consultando pelo numero do produto
    function GetProdutoTecnico(const ANumeroRegistro: string): TProdutoTecnico;
  end;

implementation

const
  BASE_URL   = 'https://api.cnptia.embrapa.br/agrofit/v1';
  TOKEN_AUTH = '###SEU_TOKEN_AQUI###';

constructor TApiAgrofitService.Create;
begin
  FClient := TRestClient.Create(BASE_URL, TOKEN_AUTH);
end;

destructor TApiAgrofitService.Destroy;
begin
  FClient.Free;
  inherited;
end;

function TApiAgrofitService.GetProdutoTecnico(const ANumeroRegistro: string): TProdutoTecnico;
var
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
begin
  JsonValue := TJSONObject.ParseJSONValue(FClient.Get('/produtos-tecnicos/' + ANumeroRegistro));
  try
    if not (JsonValue is TJSONArray) then
      raise Exception.Create('Formato inesperado da resposta da API');

    JsonArray := JsonValue as TJSONArray;

    if JsonArray.Count = 0 then
      Result := TProdutoTecnico.Create
    else
      Result := TJson.JsonToObject<TProdutoTecnico>(JsonArray.Items[0].ToJSON);
  finally
    JsonValue.Free;
  end;
end;

end.
