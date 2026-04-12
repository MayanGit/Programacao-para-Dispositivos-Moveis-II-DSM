import 'dart:io';
import 'dart:math';

void main() {
  final random = Random();

  List<int> senhaSecreta = List.generate(4, (_) => random.nextInt(6) + 1);
  
  int tentativasRestantes = 10;
  bool venceu = false;

  print('=== BEM-VINDO AO MASTERMIND ===');
  print('Tente adivinhar a senha de 4 dígitos (entre 1 e 6).');
  print('Pretos: Número e posição corretos | Brancos: Número existe, mas posição errada.');

  while (tentativasRestantes > 0 && !venceu) {
    print('\nTentativas restantes: $tentativasRestantes');
    stdout.write('Seu palpite (ex: 1234): ');
    String? entrada = stdin.readLineSync();

    List<int>? palpite = validarEntrada(entrada);
    
    if (palpite == null) {
      print('Entrada inválida! Digite exatamente 4 números entre 1 e 6.');
      continue; 
    }

    Map<String, int> resultado = compararSenha(senhaSecreta, palpite);
    int pretos = resultado['pretos']!;
    int brancos = resultado['brancos']!;

    print('Feedback: $pretos Pinos Pretos, $brancos Pinos Brancos');

    if (pretos == 4) {
      venceu = true;
    } else {
      tentativasRestantes--;
    }
  }

 if (venceu) {
    print('\nPARABÉNS! Você descobriu a senha: $senhaSecreta');
  } else {
    print('\nGAME OVER! Suas tentativas acabaram.');
    print('A senha era: $senhaSecreta');
  }
}

List<int>? validarEntrada(String? entrada) {
  if (entrada == null || entrada.length != 4) return null;
  
  List<int> numeros = [];
  for (var i = 0; i < entrada.length; i++) {
    int? n = int.tryParse(entrada[i]);
    if (n == null || n < 1 || n > 6) return null;
    numeros.add(n);
  }
  return numeros;
}

Map<String, int> compararSenha(List<int> secreta, List<int> palpite) {
  int pretos = 0;
  int brancos = 0;

  List<int> copiaSecreta = List.from(secreta);
  List<int> copiaPalpite = List.from(palpite);
  List<bool> processadoSecreta = [false, false, false, false];
  List<bool> processadoPalpite = [false, false, false, false];

  for (int i = 0; i < 4; i++) {
    if (copiaPalpite[i] == copiaSecreta[i]) {
      pretos++;
      processadoSecreta[i] = true;
      processadoPalpite[i] = true;
    }
  }

  for (int i = 0; i < 4; i++) {
    if (processadoPalpite[i]) continue; 

    for (int j = 0; j < 4; j++) {
      if (!processadoSecreta[j] && copiaPalpite[i] == copiaSecreta[j]) {
        brancos++;
        processadoSecreta[j] = true;
        break; 
      }
    }
  }

  return {'pretos': pretos, 'brancos': brancos};
}