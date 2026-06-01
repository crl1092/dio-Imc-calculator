import 'package:calculadora_imc/database/entities/imc_entity.dart';
import 'package:froom/froom.dart';

@dao
abstract class ImcDao {
  @Query('SELECT * FROM Imc')
  Future<List<Imc>> getAll();

  @Query('SELECT * FROM Imc')
  Stream<List<Imc>> watchAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertImc(Imc imc);
}
