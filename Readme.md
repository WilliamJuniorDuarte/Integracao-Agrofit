# Agrofit Delphi

## Como executar o projeto

- Basta executar o arquivo `.exe` que está na raiz do projeto:

```txt
Agrofit\AgrofitDelphi.exe
```

- Não é necessário instalar banco de dados ou qualquer dependência externa, pois o projeto já acompanha todas as DLLs de permissão para execução.

- Para construir o `.dproj`, basta abrir o projeto na IDE, seguir até o menu:

```txt
Projeto -> Opções -> Compilador Delphi -> Compilador de Saída
```

e alterar o caminho para a mesma raiz do `.dproj`, dessa forma garante que ele encontrará todos os arquivos necessários.

---

## Estrutura

Separado em camadas, garantindo escalabilidade e facilidade para encontrar arquivos.

```txt
Agrofit/
│
├── AgrofitDelphi.dpr
├── AgrofitDelphi.dproj
├── AgrofitDelphi.exe
│   # executável já buildado
│
├── fbembed.dll
│   # e demais outros arquivos de configuração do Firebird 2.5 Embedded
│
├── banco de dados/
│   ├── AGROFIT.FDB
│   ├── Database.Initializer.pas
│   │   # inicializador do BD, cria o fdb e executa o database.sql
│   │
│   └── database.sql
│       # scripts de criação de tabela, pk, trigger, etc...
│
└── src/
    │
    ├── api/
    │   ├── RestClient.pas
    │   │   # cliente HTTP Genérico
    │   │
    │   └── Service.ApiAgrofit.pas
    │       # serviço específico para API,
    │       # conhece os endpoints e trata exatamente
    │       # para o retorno esperado pela UI
    │
    ├── dm/
    │   ├── DM.Database.pas
    │   │   # DataModulo, conecta o FireDAC com o Firebird
    │   │
    │   └── DM.Database.dfm
    │
    ├── modelo/
    │   └── Model.ProdutoTecnico.pas
    │       # model com a classe conforme retornado pela API
    │
    ├── repositorio/
    │   └── Repositorio.ProdutoTecnico.pas
    │       # repositório, responsável por comunicar
    │       # diretamente com o BD, executando
    │       # insert, update e consultas
    │
    └── ui/
        ├── frmMain.pas
        │   # formulário principal,
        │   # exibe todas as operações possíveis
        │
        └── frmPrincipal.dfm
```

---

## Princípio SOLID aplicado

### SRP – Princípio de Responsabilidade Única

Cada classe possui uma responsabilidade única bem definida.

Exemplos:

- `TAPIAgrofitService`
  - consome apenas a API Agrofit

- `TRestClient`
  - apenas executa métodos GET

- `RestClient`
  - não conhece API

- `API`
  - não conhece interface nem banco local

Cada classe conhece apenas seus métodos responsáveis por sua operação.

---

## Operações realizadas

### Consulta API

- consulta produto na API
- trata o retorno
- exibe na tela caso encontre o produto

### Consulta Local

- consulta o produto no banco de dados local

### Salva Local

- salva o produto no banco de dados local
- caso já esteja salvo:
  - pergunta se deseja atualizar o registro com os novos dados

---

## Objetivo

A ideia foi deixar funcional como se fosse uma conferência para importação de produtos de um sistema para outro.

Fluxo:

1. Consome o produto da API;
2. Valida os dados na tela;
3. Caso esteja tudo OK, salva;
4. Caso necessário, altera os dados;
5. Salva com as informações corretas.
