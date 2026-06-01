import 'package:froom/froom.dart';

@Entity()
class Imc {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final double peso;

  final double altura;

  final double imc;

  final String classificacao;

  Imc(this.id, this.peso, this.altura, this.imc, this.classificacao);
}
