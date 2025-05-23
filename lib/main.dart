import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:lab5/cubit/calculator_cubit.dart';
import 'package:lab5/screens/input_screen.dart';
import 'package:lab5/screens/history_screen.dart';

void main() {
  
  sqfliteFfiInit();

  
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubit(),
      child: MaterialApp(
        title: 'Квадратное уравнение',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: InputScreen(),
        routes: {
          '/history': (context) => HistoryScreen(),
        },
      ),
    );
  }
}
