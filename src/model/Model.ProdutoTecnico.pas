unit Model.ProdutoTecnico;

interface

uses
  REST.Json.Types;

type
  TIngredienteAtivoDetalhado = class
  private
    [JsonName('ingrediente_ativo')]
    FIngredienteAtivo: string;

    [JsonName('grupo_quimico')]
    FGrupoQuimico: string;

    [JsonName('concentracao')]
    FConcentracao: string;

    [JsonName('unidade_medida')]
    FUnidadeMedida: string;

    [JsonName('percentual')]
    FPercentual: string;
  published
    property IngredienteAtivo: string read FIngredienteAtivo write FIngredienteAtivo;
    property GrupoQuimico    : string read FGrupoQuimico     write FGrupoQuimico;
    property Concentracao    : string read FConcentracao     write FConcentracao;
    property UnidadeMedida   : string read FUnidadeMedida    write FUnidadeMedida;
    property Percentual      : string read FPercentual       write FPercentual;
  end;

  TDocumentoCadastrado = class
  private
    [JsonName('descricao')]
    FDescricao: string;

    [JsonName('tipo_documento')]
    FTipoDocumento: string;

    [JsonName('data_inclusao')]
    FDataInclusao: string;

    [JsonName('url')]
    FUrl: string;

    [JsonName('origem')]
    FOrigem: string;
  published
    property Descricao    : string read FDescricao     write FDescricao;
    property TipoDocumento: string read FTipoDocumento write FTipoDocumento;
    property DataInclusao : string read FDataInclusao  write FDataInclusao;
    property Url          : string read FUrl           write FUrl;
    property Origem       : string read FOrigem        write FOrigem;
  end;

  TProdutoFormuladoVinculado = class
  private
    [JsonName('marca_comercial')]
    FMarcaComercial: TArray<string>;

    [JsonName('numero_registro')]
    FNumeroRegistro: string;

    [JsonName('titular_registro')]
    FTitularRegistro: string;
  published
    property MarcaComercial : TArray<string> read FMarcaComercial  write FMarcaComercial;
    property NumeroRegistro : string         read FNumeroRegistro  write FNumeroRegistro;
    property TitularRegistro: string         read FTitularRegistro write FTitularRegistro;
  end;

  TProdutoTecnico = class
  private
    [JsonName('numero_registro')]
    FNumeroRegistro: string;

    [JsonName('titular_registro')]
    FTitularRegistro: string;

    [JsonName('classificacao_toxicologica')]
    FClassificacaoToxicologica: string;

    [JsonName('classificacao_ambiental')]
    FClassificacaoAmbiental: string;

    [JsonName('formulacao')]
    FFormulacao: string;

    [JsonName('url_agrofit')]
    FUrlAgrofit: string;

    [JsonName('marca_comercial')]
    FMarcaComercial: TArray<string>;

    [JsonName('classe_categoria_agronomica')]
    FClasseCategoriaAgronomica: TArray<string>;

    [JsonName('ingrediente_ativo')]
    FIngredienteAtivo: TArray<string>;

    [JsonName('ingrediente_ativo_detalhado')]
    FIngredienteAtivoDetalhado: TArray<TIngredienteAtivoDetalhado>;

    [JsonName('documento_cadastrado')]
    FDocumentoCadastrado: TArray<TDocumentoCadastrado>;

    [JsonName('produto_formulado_vinculado')]
    FProdutoFormuladoVinculado: TArray<TProdutoFormuladoVinculado>;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property NumeroRegistro           : string read FNumeroRegistro            write FNumeroRegistro;
    property TitularRegistro          : string read FTitularRegistro           write FTitularRegistro;
    property ClassificacaoToxicologica: string read FClassificacaoToxicologica write FClassificacaoToxicologica;
    property ClassificacaoAmbiental   : string read FClassificacaoAmbiental    write FClassificacaoAmbiental;
    property Formulacao               : string read FFormulacao                write FFormulacao;
    property UrlAgrofit               : string read FUrlAgrofit                write FUrlAgrofit;

    property MarcaComercial           : TArray<string> read FMarcaComercial            write FMarcaComercial;
    property ClasseCategoriaAgronomica: TArray<string> read FClasseCategoriaAgronomica write FClasseCategoriaAgronomica;
    property IngredienteAtivo         : TArray<string> read FIngredienteAtivo          write FIngredienteAtivo;

    property IngredienteAtivoDetalhado: TArray<TIngredienteAtivoDetalhado> read FIngredienteAtivoDetalhado write FIngredienteAtivoDetalhado;
    property DocumentoCadastrado      : TArray<TDocumentoCadastrado>       read FDocumentoCadastrado       write FDocumentoCadastrado;
    property ProdutoFormuladoVinculado: TArray<TProdutoFormuladoVinculado> read FProdutoFormuladoVinculado write FProdutoFormuladoVinculado;
  end;

implementation

{ TProdutoTecnico }

constructor TProdutoTecnico.Create;
begin
  inherited;
end;

destructor TProdutoTecnico.Destroy;
var
  I: Integer;
begin
  for I := 0 to High(FIngredienteAtivoDetalhado) do
    FIngredienteAtivoDetalhado[I].Free;

  for I := 0 to High(FDocumentoCadastrado) do
    FDocumentoCadastrado[I].Free;

  for I := 0 to High(FProdutoFormuladoVinculado) do
    FProdutoFormuladoVinculado[I].Free;

  inherited;
end;

end.
