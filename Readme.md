#Como executar o projeto
  -Basta executar o arquivo .exe que está na raiz do projeto (Agrofit\AgrofitDelphi.exe).
  -Não é necessário instalar banco de dados ou qualquer dependência externa, pois o projeto já acompanha todas as DLLs necessárias para execução.
  -Para buildar o .dproj, basta abrir o projeto na IDE, seguir até mo menu Project -> Options -> Delphi Compiler -> Output Compiler e alterar 
     o caminho para a mesma raiz do .dproj, dessa forma garante que ele encontrará todos os arquivos necessários.

#Estrutura
  -Separado em camadas, garantindo escalabilidade e facilidade para encontrar arquivos

Agrofit/
|-- AgrofitDelphi.dpr
|-- AgrofitDelphi.dproj
|-- AgrofitDelphi.exe #executável já buildado
|-- fbembed.dll #e demais outros arquivos de configuração do Firebird 2.5 Embedded
|
|-- database/
|   |-- AGROFIT.FDB 
|   |-- Database.Initializer.pas #inicializador do BD, cria o fdb e executa o database.sql
|   |-- database.sql #scripts de criação de tabela, pk, trigger, etc...
|
|-- src/
|   |── api/ #Consumo HTTP
|   |   |--RestClient.pas # client HTTP Genérico
|   |   |-- Service.ApiAgrofit.pas # serviço especifico para a API, conhece os endpoints e trata para exatamente o retorno esperado pela Ui
|   |
|   |-- dm/
|   |   |── DM.Database.pas #DataModulo, conecta o FireDAC com o Firebird
|   |   |── DM.Database.dfm
|   |
|   |-- model/
|   |   |── Model.ProdutoTecnico.pas #model com a classe conforme retornado pela API
|   |
|   |-- repository/
|   |   |── Repository.ProdutoTecnico.pas #repository, responsável por comunicar diretamente com o BD, executando insert, update e consultas
|   |
|   |-- ui/
|       |── frmMain.pas # formulario principal, exibe todas as operações possiveis
|       |── frmMain.dfm
|--

#Princípio SOLID aplicado
  -SRP – Single Responsibility Principle
    -Cada classe possui uma unica responsabilidade bem definida ex:
      -TAPIAgrofitService - consume apenas a api agrofit, TRestClient - apenas executa métodos get
      -RestClient não conhece api, api não conhece interface, nem banco local, cada classe conhece apenas seus métodos responsáveis por sua operação

#Operações realizadas
  -Consulta API - consulta produto na API, trata o retorno e exibe na tela se encontrar produto;
  -Consulta Local - consulta pelo produto no bd local;
  -Salva Local - salva o produto no banco de dados local
    -caso já esteja salvo localmente, pergunta se deseja atualizar o registro salvo com os novos dados

A ideia foi deixar funcional como se fosse uma conferencia para importação de produtos de um sistema para outro, consome produto da API, 
  valida os dados em tela, se OK, salva, se não, altera o que for necessário e pode salvar com as informaçoes corretas.