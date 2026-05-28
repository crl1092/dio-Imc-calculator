class ImcCalc {
  final double peso;
  final double altura;

  ImcCalc({required this.peso, required this.altura});

  double calcular(double peso, double altura) {
    if (peso == 0.0 && altura == 0.0) {
      return 0.0;
    } else {
      return peso / (altura * altura);
    }
  }
}
