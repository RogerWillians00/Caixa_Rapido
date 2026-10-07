Caixa Rápido

Caixa Rápido é um aplicativo de gestão comercial desenvolvido em Flutter, pensado para facilitar o controle de vendas, estoque e fluxo de caixa de pequenos comércios.

📋 Sobre o Projeto

Este projeto tem como objetivo oferecer uma solução simples, rápida e intuitiva para o gerenciamento diário de um ponto de venda. Permite cadastrar produtos, realizar vendas, controlar o estoque e acompanhar o fluxo financeiro, tudo em uma interface leve e amigável.

✨ Funcionalidades

Tela de Vendas: Realize vendas de forma ágil, com cálculo automático de valores e finalização de pedidos.
Controle de Estoque (Inventory): Gerencie todos os produtos cadastrados com informações de preço, quantidade e muito mais.
Identificação Visual de Preços: Na tela de estoque, os produtos são destacados com cores baseadas na faixa de preço, facilitando a análise do seu portfólio.
Fluxo de Caixa: Acompanhe entradas, saídas e saldo do caixa de forma organizada.
Interface Intuitiva: Design pensado para agilidade no dia a dia do comércio.
🧪 Últimas Alterações

[v0.2.0] - Destaque Visual por Faixa de Preço no Estoque (2025-10-06)

Adicionada uma funcionalidade de identificação visual na tela de estoque para facilitar a análise de precificação dos produtos.

Mudanças realizadas:

inventory_screen.dart:
Adicionada interpolação de cores entre verde, amarelo e vermelho com base no preço de cada produto em relação ao estoque.
O produto mais barato do estoque é exibido em verde.
Os produtos intermediários apresentam uma transição gradual de verde → amarelo → vermelho conforme o preço aumenta.
O produto mais caro do estoque é exibido em vermelho.
Caso todos os produtos possuam o mesmo preço, o destaque fica em amarelo para evitar divisão por zero.
Implementado cálculo dinâmico de preço mínimo e preço máximo sempre que a lista de produtos é atualizada (inclusive ao adicionar novos produtos).
Essa melhoria proporciona uma visão estratégica rápida: identificar produtos com melhor custo/valor e aqueles com maior valor no estoque de forma instantânea.

🚀 Tecnologias Utilizadas

Flutter - Framework para desenvolvimento multiplataforma
Dart - Linguagem de programação
📦 Como Executar o Projeto

Pré-requisitos

Flutter SDK instalado (Guia de instalação)
Emulador Android/iOS ou dispositivo físico conectado
Editor de código (VS Code, Android Studio, etc.)
Passos para execução

# 1. Clone o repositório
git clone https://github.com/seu-usuario/caixa_rapido.git

# 2. Acesse a pasta do projeto
cd caixa_rapido

# 3. Instale as dependências
flutter pub get

# 4. Execute o aplicativo
flutter run
🛠️ Scripts Úteis

Comando	Descrição
flutter analyze	Executa a análise estática do código (Lint)
flutter test	Executa todos os testes do projeto
flutter build apk	Gera o APK para Android
flutter build ios	Gera o build para iOS
