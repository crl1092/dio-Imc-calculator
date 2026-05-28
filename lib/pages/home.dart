import 'package:calculadora_imc/logic/imc_calc.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  double imcResultado = 0.0;
  String classificacao = "";

  //transforma os dados dos controllers em  double para calcular o imc
  double get peso => double.tryParse(pesoController.text) ?? 0.0;
  double get altura => double.tryParse(alturaController.text) ?? 0.0;

  //classifica o imc
  void classificar() {
    if (imcResultado < 18.5) {
      setState(() {
        classificacao = "Abaixo do peso";
      });
    } else if (imcResultado >= 18.5 && imcResultado <= 24.9) {
      setState(() {
        classificacao = "Peso normal";
      });
    } else if (imcResultado >= 25.0 && imcResultado <= 29.9) {
      setState(() {
        classificacao = "Obesidade grau I";
      });
    } else if (imcResultado >= 30.0 && imcResultado <= 39.9) {
      setState(() {
        classificacao = "Obesidade de grau II";
      });
    } else {
      setState(() {
        classificacao = "Obesidade de grau III";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 15,
            children: [
              const SizedBox(height: 1),
              const Text('Informe o seu peso:', style: TextStyle(fontSize: 20)),
              TextField(
                controller: pesoController,
                decoration: const InputDecoration(
                  hintText: 'Peso',
                  prefixIcon: Icon(Icons.balance),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
              ),
              const Text('Informe sua altura:', style: TextStyle(fontSize: 20)),
              TextField(
                controller: alturaController,
                decoration: const InputDecoration(
                  hintText: 'Altura',
                  prefixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
              ),
              TextButton(
                onPressed: () {
                  final imcCalc = ImcCalc(peso: peso, altura: altura);
                  setState(() {
                    imcResultado = imcCalc.calcular(peso, altura);
                  });
                  classificar();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15),
                  ),
                ),
                child: const Text('Calcular'),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Seu imc é: ${imcResultado.toStringAsFixed(2)}\nSua classificação é: $classificacao',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
