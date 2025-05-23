import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab5/db/database_provider.dart';
import 'package:lab5/db/calculation.dart';
import 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  final DatabaseProvider dbProvider = DatabaseProvider();

  void calculateRoots(double a, double b, double c) async {
  emit(CalculatorLoading());
  try {
    if (a == 0) {
      emit(CalculatorError(message: 'Коэффициент a не может быть равен нулю'));
      return;
    }  // <-- закрывающая скобка добавлена здесь
    double d = b * b - 4 * a * c;
    String resultText;
    if (d > 0) {
      double sqrtD = sqrt(d);
      double x1 = (-b - sqrtD) / (2 * a);
      double x2 = (-b + sqrtD) / (2 * a);
      resultText = 'Два корня: x₁ = $x1, x₂ = $x2';
    } else if (d == 0) {
      double x = (-b) / (2 * a);
      resultText = 'Один корень: x = $x';
    } else {
      resultText = 'Нет действительных корней';
    }
    await dbProvider.insertCalculation(
      Calculation(a: a, b: b, c: c, result: resultText)
    );
    emit(CalculatorSuccess(resultText: resultText));
  } catch (e, stackTrace) {
    print('Ошибка расчёта: $e');
    print('Stack Trace: $stackTrace');
    emit(CalculatorError(message: 'Ошибка расчёта: $e'));
  }
}
}