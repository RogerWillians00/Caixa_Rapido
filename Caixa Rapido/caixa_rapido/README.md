<div align="center">

# 📦 Caixa Rápido

**Registre suas vendas do dia a dia de maneira rápida e fácil.**

Aplicativo mobile multiplataforma feito em **Flutter**, pensado para quem
precisa anotar e registrar produtos e valores de forma prática, sem burocracia
e sem coleta de dados pessoais.

[![Flutter](https://img.shields.io/badge/Flutter-3.7.12-02569A?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D2.19.6-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux-lightgrey?style=flat-square)]()

</div>

---

## 📸 Telas

| Tela Inicial (Title) | Cadastro do Caixa (Name) |
| --- | --- |
| Logo, nome do app, disclaimer e botão de início | Foto do usuário, nome do caixa e botão de início |

- **Tela Inicial** — apresentação do app com layout responsivo (adaptada para
  celular e tablet) e créditos do desenvolvedor.
- **Tela de Cadastro** — permite anexar uma foto pela galeria e definir o
  nome do caixa. A foto é salva apenas localmente, com compressão para
  economizar memória em dispositivos antigos.

---

## ✨ Funcionalidades

- 🎨 **Tema claro e escuro** alternável pelo ícone na `AppBar`.
- 🖼️ **Seleção de foto** via galeria do dispositivo (`image_picker`).
- 📐 **Layout responsivo** com cálculos dinâmicos de tamanho de fonte,
  espaçamento e logo a partir de `MediaQuery`.
- 🧭 **Navegação por rotas nomeadas** (`/` e `/name`) centralizada em `main.dart`.
- 🧩 **Código organizado** em widgets privados e seções comentadas.
- 🔒 **Sem coleta de dados** — nada é enviado para servidores.

---

## 🛠️ Tecnologias

| Tecnologia | Versão | Uso |
| --- | --- | --- |
| Flutter | 3.7.12 | Framework de UI multiplataforma |
| Dart | >= 2.19.6 | Linguagem |
| flutter_svg | ^2.0.5 | Logo e ícones em SVG |
| image_picker | ^1.0.4 | Seleção de foto da galeria |
| flutter_lints | ^2.0.0 | Análise estática de código |

---

## 📁 Estrutura do Projeto

```
caixa_rapido/
├── assets/
│   ├── images/              # appLogo.svg, linkedinIcon.svg, githubIcon.svg
│   └── resources/           # imagens extras
├── lib/
│   ├── main.dart            # Ponto de entrada, rotas e troca de tema
│   ├── Screens/
│   │   ├── titleScreen.dart # Tela inicial (tela de título)
│   │   └── nameScreen.dart  # Tela de nome do caixa e foto
│   └── app_Controlers/
│       └── darktheme.dart   # ThemeProvider (InheritedWidget) do tema claro/escuro
├── android/                 # Implementação nativa Android
├── ios/                     # Implementação nativa iOS
├── macos/                   # Implementação nativa macOS
├── linux/                   # Implementação nativa Linux
├── windows/                 # Implementação nativa Windows
├── web/                     # Implementação Web
├── pubspec.yaml
└── README.md
```

---

## 🚀 Como Executar

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) 3.7.12 (Dart 2.19.6)
- Android Studio (para Android) ou Xcode (para iOS/macOS)

### Instalação

```bash
# Clone o repositório
git clone https://github.com/RogerWillians00/Caixa_Rapido.git

# Entre na pasta do projeto
cd Caixa_Rapido/caixa_rapido

# Instale as dependências
flutter pub get

# Execute no dispositivo/emulador conectado
flutter run
```

### Outros comandos úteis

```bash
flutter build apk      # Gera o APK de release
flutter build ipa      # Gera o pacote para iOS
flutter build web      # Gera a versão web
flutter analyze        # Verifica erros e avisos do código
dart format lib/       # Formata o código
```

---

## ✏️ Convenções de Código

O projeto segue um padrão de organização aplicado em todas as telas:

- **Blocos de seção comentados** no formato:

  ```dart
  // ============================================================
  // CONFIGURAÇÕES DE RESPONSIVIDADE
  // ============================================================
  ```

- **`build()` sempre começa pelas constantes**, na mesma ordem:
  1. `CONFIGURAÇÕES DE RESPONSIVIDADE`
  2. `CONSTANTES DE ESPACAMENTO`
  3. `CONSTANTES DE CORES`
  4. Widgets (`SECAO: ...`)

- **UI dividida em widgets privados** `_buildNomeDaSecao(...)`, cada um
  documentado com um bloco `// WIDGET: ...`.

- **Linha em branco antes do `return`** e formatação padrão do
  `dart format` (80 colunas).

---

## 🛠️ Stack de Manutenção

| Ferramenta | Uso |
| --- | --- |
| `flutter analyze` | Análise estática (lint) |
| `dart format` | Formatação automática |

---

## 👤 Autor

Desenvolvido por **Roger Willians**

- 💼 LinkedIn: [in/rogerw00](https://www.linkedin.com/in/rogerw00/)
- 💻 GitHub: [RogerWillians00](https://github.com/RogerWillians00)

---

## 📋 Modificações Recentes

Refatoração completa de padronização de código e comentários, aplicando em
todos os arquivos o mesmo padrão de `titleScreen.dart`.

### `lib/Screens/nameScreen.dart`

- Quebra da interface em **widgets privados**: `_buildAvatarSection`,
  `_buildPrivacyNoticeSection`, `_buildNameFieldSection` e
  `_buildStartButtonSection`.
- Criação dos blocos de constantes no início do `build()`:
  `CONFIGURAÇÕES DE RESPONSIVIDADE`, `CONSTANTES DE ESPACAMENTO`,
  `CONSTANTES DE DIMENSOES FIXAS` e `CONSTANTES DE CORES`.
- Substituição de valores "mágicos" (cores, heights, radius, fontSize) por
  `const` nomeados, deixando o layout **responsivo** (escala em tablets).
- Normalização de **indentação** e remoção de linhas acima de 80 colunas.
- Reordenação e padronização dos imports e dos **comentários** de seção.

### `lib/main.dart`

- Correção da indentação do `MaterialApp` (bloco `routes:` desalinhado).
- Rotas extraídas para o método privado `_buildRoutes()`.
- Adição de `const` nos construtores das telas e comentário de
  documentação das rotas.
- Correção de quebra de linha ausente ao final do arquivo.

### `lib/app_Controlers/darktheme.dart`

- Adição de blocos de comentário em `PROPRIEDADES` e `METODO: ...`
  para documentar `of()` e `updateShouldNotify()`.

### `lib/Screens/titleScreen.dart`

- Correção do bloco de comentário quebrado na seção
  `WIDGET: Botao Começar`.

### Arquivos de suporte

- Criação deste `README.md` com documentação do projeto, estrutura,
  instruções de execução e convenções de código.

### Pendências antes de publicar

- Remover os arquivos `.DS_Store` que estão versionados:
  `git rm --cached .DS_Store` e acrescentar `.DS_Store` ao `.gitignore`.
- Definir um arquivo `LICENSE` (ver seção Licença).

### Validação

```bash
dart format lib/   # 4 arquivos, 0 alterações pendentes
flutter analyze    # 0 erros
```

---

## 📄 Licença

> ⚠️ Nenhuma licença foi definida ainda. Adicione um arquivo `LICENSE` na
> raiz do repositório e informe aqui qual licença será aplicada antes de
> publicar o código como aberto.

---

<div align="center">
Feito com ❤️ por **Roger Willians**
</div>
