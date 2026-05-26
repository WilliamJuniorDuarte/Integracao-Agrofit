object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Agrofit'
  ClientHeight = 478
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PnlPrin: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 478
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 489
    object PnlCabecalho: TPanel
      Left = 20
      Top = 20
      Width = 540
      Height = 133
      BorderStyle = bsSingle
      TabOrder = 0
      object LblNumeroRegistro: TLabel
        Left = 20
        Top = 15
        Width = 90
        Height = 15
        Caption = 'N'#250'mero Registro'
      end
      object EdtNumeroRegistro: TEdit
        Left = 20
        Top = 30
        Width = 235
        Height = 23
        Hint = 'Informe o N'#250'mero de Registro'
        TabOrder = 0
        TextHint = 'TC00323'
      end
      object BtnConsultarLocal: TButton
        Left = 20
        Top = 71
        Width = 235
        Height = 35
        Caption = 'Consultar Local'
        TabOrder = 1
        OnClick = BtnConsultarLocalClick
      end
      object BtnConsultarAPI: TButton
        Left = 275
        Top = 24
        Width = 235
        Height = 35
        Caption = 'Consultar API'
        TabOrder = 2
        OnClick = BtnConsultarApiClick
      end
      object BtnSalvarLocal: TButton
        Left = 275
        Top = 71
        Width = 235
        Height = 35
        Caption = 'Salvar Local'
        TabOrder = 3
        OnClick = BtnSalvarLocalClick
      end
    end
    object PnlDadosProduto: TPanel
      Left = 20
      Top = 170
      Width = 540
      Height = 289
      BorderStyle = bsSingle
      TabOrder = 1
      object LblNome: TLabel
        Left = 20
        Top = 15
        Width = 134
        Height = 15
        Caption = 'Nome / Marca Comercial'
      end
      object LblClasse: TLabel
        Left = 20
        Top = 68
        Width = 67
        Height = 15
        Caption = 'Classe / Tipo'
      end
      object LblTitular: TLabel
        Left = 20
        Top = 121
        Width = 89
        Height = 15
        Caption = 'Titular / Empresa'
      end
      object LblClassificacaoToxicologica: TLabel
        Left = 20
        Top = 174
        Width = 137
        Height = 15
        Caption = 'Classifica'#231#227'o Toxicol'#243'gica'
      end
      object LblClassificacaoAmbiental: TLabel
        Left = 20
        Top = 227
        Width = 126
        Height = 15
        Caption = 'Classifica'#231#227'o Ambiental'
      end
      object EdtNome: TEdit
        Left = 20
        Top = 30
        Width = 490
        Height = 23
        Hint = 'Nome / Marca comercial'
        TabOrder = 0
      end
      object EdtClasse: TEdit
        Left = 20
        Top = 83
        Width = 490
        Height = 23
        Hint = 'Classe / tipo (herbicida, inseticida, fungicida, etc.)'
        TabOrder = 1
      end
      object EdtTitular: TEdit
        Left = 20
        Top = 136
        Width = 490
        Height = 23
        Hint = 'Titular do registro / empresa'
        TabOrder = 2
      end
      object EdtClassificacaoToxicologica: TEdit
        Left = 20
        Top = 189
        Width = 490
        Height = 23
        Hint = 'Classifica'#231#227'o Toxicol'#243'gica'
        TabOrder = 3
      end
      object EdtClassificacaoAmbiental: TEdit
        Left = 20
        Top = 242
        Width = 490
        Height = 23
        Hint = 'Classifica'#231#227'o Ambiental'
        TabOrder = 4
      end
    end
  end
end
