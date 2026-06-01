import 'package:calculadora_imc/database/app_database.dart';
import 'package:calculadora_imc/pages/home.dart';
import 'package:flutter/material.dart';

late final AppDatabase database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await $FroomAppDatabase.databaseBuilder("app_database.db").build();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}
