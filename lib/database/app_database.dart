import 'dart:async';

import 'package:calculadora_imc/database/dao/imc_dao.dart';
import 'package:calculadora_imc/database/entities/imc_entity.dart';
import 'package:froom/froom.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Imc])
abstract class AppDatabase extends FroomDatabase {
  ImcDao get imcDao;
}
