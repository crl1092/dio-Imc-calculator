import 'package:calculadora_imc/database/entities/imc_entity.dart';
import 'package:calculadora_imc/main.dart';
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
  String classificar() {
    if (imcResultado < 18.5) {
      classificacao = "Abaixo do peso";
    } else if (imcResultado >= 18.5 && imcResultado <= 24.9) {
      classificacao = "Peso normal";
    } else if (imcResultado >= 25.0 && imcResultado <= 29.9) {
      classificacao = "Obesidade grau I";
    } else if (imcResultado >= 30.0 && imcResultado <= 39.9) {
      classificacao = "Obesidade de grau II";
    } else {
      classificacao = "Obesidade de grau III";
    }
    return classificacao;
  }

  Future<void> _calcularESalvar() async {
    final peso = double.tryParse(pesoController.text) ?? 0;
    final altura = double.tryParse(alturaController.text) ?? 0;

    if (peso > 0 && altura > 0) {
      // Cálculo do IMC: Peso dividido pela altura ao quadrado
      final valorImc = peso / (altura * altura);
      imcResultado = valorImc;
      classificacao = classificar();
      final novoRegistro = Imc(
        0, // id autogerado pelo banco de dados
        peso,
        altura,
        valorImc,
        classificacao,
      );

      // Inserindo no Floor DB
      await database.imcDao.insertImc(novoRegistro);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'IMC ${valorImc.toStringAsFixed(1)} salvo com sucesso!',
          ),
        ),
      );

      pesoController.clear();
      alturaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final imcDao = database.imcDao;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
                onPressed: _calcularESalvar,
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
              Expanded(
                child: StreamBuilder<List<Imc>>(
                  stream: imcDao.watchAll(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final registros = snapshot.data ?? [];
                    if (registros.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum registro',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: registros.length,
                      itemBuilder: (context, index) {
                        final registro = registros[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Seu imc é: ${registro.imc.toStringAsFixed(2)}\nSua classificação é: ${registro.classificacao}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
