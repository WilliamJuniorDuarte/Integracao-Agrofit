unit RestClient;

interface

uses
  System.SysUtils,
  System.Net.HttpClient,
  System.Net.URLClient;

type
  TRestClient = class
  private
    FHttp: THTTPClient;
    FBaseUrl: string;
    FTokenAuth: string;

    //Inclui no Client os headers
    procedure ApplyHeaders();
  public
    constructor Create(const ABaseUrl, ATokenAuth: string);
    destructor Destroy; override;

    //Metodo GET generico, recebe URL de complemento como parametro
    function Get(const AURLComplement: string): string;
  end;

implementation

procedure TRestClient.ApplyHeaders();
begin
  FHttp.CustomHeaders['Accept']        := 'application/json';
  FHttp.CustomHeaders['Authorization'] := 'Bearer ' + FTokenAuth;
end;

constructor TRestClient.Create(const ABaseUrl, ATokenAuth: string);
begin
  FHttp := THTTPClient.Create;
  FBaseUrl := ABaseUrl;
  FTokenAuth := ATokenAuth;

  ApplyHeaders();
end;

destructor TRestClient.Destroy;
begin
  FHttp.Free;
  inherited;
end;

function TRestClient.Get(const AURLComplement: string): string;
var
  Response: IHTTPResponse;
begin
  Response := FHttp.Get(FBaseUrl + AURLComplement);

  if Response.StatusCode <> 200 then
    raise Exception.Create('StatusCode: ' + IntToStr(Response.StatusCode) +sLineBreak+
                           'Response: ' + Response.ContentAsString);

  Result := Response.ContentAsString;
end;

end.
