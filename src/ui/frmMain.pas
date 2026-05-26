unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Service.ApiAgrofit, Model.ProdutoTecnico;

type
  TFormMain = class(TForm)
    BtnConsultarLocal: TButton;
    EdtNumeroRegistro: TEdit;
    LblNumeroRegistro: TLabel;
    PnlPrin: TPanel;
    PnlCabecalho: TPanel;
    PnlDadosProduto: TPanel;
    LblNome: TLabel;
    EdtNome: TEdit;
    EdtClasse: TEdit;
    LblClasse: TLabel;
    EdtTitular: TEdit;
    LblTitular: TLabel;
    EdtClassificacaoToxicologica: TEdit;
    LblClassificacaoToxicologica: TLabel;
    LblClassificacaoAmbiental: TLabel;
    EdtClassificacaoAmbiental: TEdit;
    BtnConsultarAPI: TButton;
    BtnSalvarLocal: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnConsultarApiClick(Sender: TObject);
    procedure BtnConsultarLocalClick(Sender: TObject);
    procedure BtnSalvarLocalClick(Sender: TObject);

  private
    FApiService: TApiAgrofitService;

    //Carrega/limpa os campos da tela
    procedure LoadFields(const AProduto: TProdutoTecnico = nil);
  end;

var
  FormMain: TFormMain;

implementation

uses
  Repository.ProdutoTecnico,
  DM.Database;
{$R *.dfm}

procedure TFormMain.BtnConsultarApiClick(Sender: TObject);
var
  Produto: TProdutoTecnico;
begin
  if EdtNumeroRegistro.Text = '' then
  begin
    ShowMessage('Numero de Registro para consulta não informado!');
    Exit;
  end;

  try
    Produto := FApiService.GetProdutoTecnico(EdtNumeroRegistro.Text);
  except on E: Exception do
    begin
      ShowMessage('Falha na comunicação com a API! ' +sLineBreak+ E.Message);
      Exit;
    end;
  end;

  if Produto.NumeroRegistro = '' then
  begin
    LoadFields();
    ShowMessage('Produto não encontrado.');
    Exit;
  end;

  try
    LoadFields(Produto);
  finally
    Produto.Free;
  end;
end;

procedure TFormMain.BtnConsultarLocalClick(Sender: TObject);
var
  Repo   : TProdutoTecnicoRepository;
  Produto: TProdutoTecnico;
begin
  Repo := TProdutoTecnicoRepository.Create(DMDatabase.Conn);
  try
    Produto := Repo.SearchByNumeroRegistro(EdtNumeroRegistro.Text);

    if not Assigned(Produto) then
    begin
      LoadFields();
      ShowMessage('Produto não encontrado no banco local.');
      Exit;
    end;

    try
      LoadFields(Produto)
    finally
      Produto.Free;
    end;
  finally
    Repo.Free;
  end;
end;

procedure TFormMain.BtnSalvarLocalClick(Sender: TObject);
var
  Repository: TProdutoTecnicoRepository;
  Produto   : TProdutoTecnico;
begin
  Repository := TProdutoTecnicoRepository.Create(DMDatabase.Conn);
  Produto    := TProdutoTecnico.Create;
  try
    Produto.NumeroRegistro            := EdtNumeroRegistro.Text;
    Produto.MarcaComercial            := SplitString(EdtNome.Text, ';');
    Produto.ClasseCategoriaAgronomica := SplitString(EdtClasse.Text, ';');
    Produto.TitularRegistro           := EdtTitular.Text;
    Produto.ClassificacaoToxicologica := EdtClassificacaoToxicologica.Text;
    Produto.ClassificacaoAmbiental    := EdtClassificacaoAmbiental.Text;

    if Repository.Exists(Produto.NumeroRegistro) then
    begin
      if MessageDlg('Produto já existe. Deseja atualizar os dados locais?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Repository.Update(Produto);
        ShowMessage('Produto atualizado com sucesso.');
      end;
    end
    else
    begin
      Repository.Insert(Produto);
      ShowMessage('Produto salvo com sucesso.');
    end;
  finally
    Produto.Free;
    Repository.Free;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FApiService := TApiAgrofitService.Create;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin

  if Assigned(FApiService) then
    FApiService.Free;
end;

procedure TFormMain.LoadFields(const AProduto: TProdutoTecnico = nil);
begin
  if not Assigned(AProduto) then
  begin
    EdtNome.Text  := '';
    EdtClasse.Text := '';
    EdtTitular.Text := '';
    EdtClassificacaoToxicologica.Text := '';
    EdtClassificacaoAmbiental.Text := '';
  end
  else
  begin
    EdtNome.Text  := String.Join('; ', AProduto.MarcaComercial);
    EdtClasse.Text := String.Join('; ', AProduto.ClasseCategoriaAgronomica);
    EdtTitular.Text := AProduto.TitularRegistro;
    EdtClassificacaoToxicologica.Text := AProduto.ClassificacaoToxicologica;
    EdtClassificacaoAmbiental.Text := AProduto.ClassificacaoAmbiental
  end;
end;

end.
