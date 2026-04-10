import 'dart:io';
import 'dart:math';

void main() {
  bool continuar = true;

  while (continuar) {
    print('\n=== MENU DE CALCULADORAS ===');
    print('1 - Calculadora Universal (Dicionário de Funções)');
    print('2 - Calculadora de Raízes (1º e 2º Grau)');
    print('0 - Sair');
    stdout.write('Escolha uma opção: ');
    
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        executarCalculadoraUniversal();
        break;
      case '2':
        executarCalculadoraRaizes();
        break;
      case '0':
        continuar = false;
        print('Saindo...');
        break;
      default:
        print('Opção inválida!');
    }
  }
}

// 1. CALCULADORA UNIVERSAL

void executarCalculadoraUniversal() {
  
  Map<String, double Function(double, double)> funcoes = {
    'soma': (a, b) => a + b,
    'subtracao': (a, b) => a - b,
    'multiplicacao': (a, b) => a * b,
    'divisao': (a, b) => b != 0 ? a / b : double.nan,
    'potencia': (a, b) => pow(a, b).toDouble(),
  };

  print('\n-- Calculadora Universal --');
  print('Funções disponíveis: ${funcoes.keys.join(', ')}');
  
  stdout.write('Digite o nome da função: ');
  String nome = stdin.readLineSync()!.toLowerCase();

  if (funcoes.containsKey(nome)) {
    stdout.write('Digite o primeiro número: ');
    double n1 = double.parse(stdin.readLineSync()!);
    stdout.write('Digite o segundo número: ');
    double n2 = double.parse(stdin.readLineSync()!);

    double resultado = funcoes[nome]!(n1, n2);
    print('Resultado de $nome: $resultado');
  } else {
    print('Função não encontrada!');
  }
}

// CALCULADORA DE RAÍZES

void executarCalculadoraRaizes() {
  print('\n-- Calculadora de Raízes --');
  print('Insira os coeficientes (a, b, c). Para 1º grau, a = 0.');
  
  stdout.write('Valor de a: ');
  double a = double.parse(stdin.readLineSync()!);
  stdout.write('Valor de b: ');
  double b = double.parse(stdin.readLineSync()!);
  stdout.write('Valor de c: ');
  double c = double.parse(stdin.readLineSync()!);

  calcularRaizes(a, b, c);
}

void calcularRaizes(double a, double b, double c) {
  if (a == 0) {
    print('Equação de 1º Grau (bx + c = 0)');
    if (b != 0) {
      double x = -c / b;
      print('Raiz real: x = $x');
    } else {
      print('Não é uma equação válida (b=0).');
    }
  } else {
    print('Equação de 2º Grau (ax² + bx + c = 0)');
    double delta = (b * b) - (4 * a * c);
    print('Delta (Δ) = $delta');

    if (delta < 0) {
      print('A equação não possui raízes reais.');
    } else if (delta == 0) {
      double x = -b / (2 * a);
      print('A equação possui uma única raiz real: x = $x');
    } else {
      double x1 = (-b + sqrt(delta)) / (2 * a);
      double x2 = (-b - sqrt(delta)) / (2 * a);
      print('A equação possui duas raízes reais: x1 = $x1 e x2 = $x2');
    }
  }
}
