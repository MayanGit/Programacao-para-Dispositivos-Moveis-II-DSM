
# Blueprint: HealthMetric Hub

## Visão Geral

O HealthMetric Hub é uma calculadora de IMC (Índice de Massa Corporal) desenvolvida em Flutter. O aplicativo permite que os usuários insiram seu peso e altura para calcular o IMC e visualizar a classificação correspondente de forma clara e interativa.

## Estilo e Design

*   **Cores:**
    *   Primária: `#34508a`
    *   Destaque: `#26e6e6`
    *   Fundo: `#f0f4f8`
    *   Texto Primário: `#0f172a`
    *   Texto Secundário: `#64748b`
*   **Tipografia:**
    *   Família da Fonte: `Inter`
    *   Títulos: `ExtraBold`, tamanho 40-60
    *   Corpo: `Regular`, tamanho 16
*   **Estilo Visual:**
    *   Bordas Arredondadas: `12.0`
    *   Sombras: Suaves com profundidade de 10-20
    *   Gradientes: A cor primária se mescla com o fundo.

## Funcionalidades

*   **Entrada de Dados:** Campos para peso (kg) e altura (m).
*   **Cálculo de IMC:** Botão para calcular o IMC com base nos dados inseridos.
*   **Exibição de Resultados:**
    *   Valor do IMC formatado com duas casas decimais.
    *   Classificação do IMC (Abaixo do peso, Peso normal, Sobrepeso, Obesidade).
    *   A cor do resultado muda de acordo com a classificação.
*   **Validação:** Impede o cálculo se os campos estiverem vazios ou contiverem valores inválidos.
*   **Tema:** Suporte para temas claro e escuro.

## Plano de Implementação Atual

*   **Tarefa:** Criar a estrutura inicial do aplicativo de calculadora de IMC.
*   **Passos:**
    1.  Adicionar as dependências `provider` e `google_fonts`.
    2.  Configurar o `ChangeNotifierProvider` para gerenciamento de estado.
    3.  Implementar a classe `ThemeProvider` para alternar entre os temas claro e escuro.
    4.  Criar a interface de usuário com `TextFields` para peso e altura, um `ElevatedButton` para o cálculo e uma área para exibir o resultado.
    5.  Adicionar a lógica para o cálculo do IMC e a determinação da classificação.
    6.  Estilizar o aplicativo de acordo com as especificações de design.

