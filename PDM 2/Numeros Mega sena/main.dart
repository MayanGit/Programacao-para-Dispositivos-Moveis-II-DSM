import 'dart:math';

void main() {
  Map<int, List<int>> jogosMegaSena = {};

  for (int i = 6; i <= 15; i++) {
    jogosMegaSena[i] = gerarVolante(i);
  }

  print('--- NÚMEROS DA MEGA SENA ---');
  jogosMegaSena.forEach((quantidade, numeros) {
    print('Aposta de $quantidade números: $numeros');
  });
}

List<int> gerarVolante(int quantidade) {
  final random = Random();
  Set<int> volanteSet = {};

  while (volanteSet.length < quantidade) {
    int numero = random.nextInt(60) + 1;
    volanteSet.add(numero);
  }

  List<int> volanteOrdenado = volanteSet.toList();
  volanteOrdenado.sort();

  return volanteOrdenado;
}