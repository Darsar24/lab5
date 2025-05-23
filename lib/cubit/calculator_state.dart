import 'package:equatable/equatable.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object?> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoading extends CalculatorState {}

class CalculatorSuccess extends CalculatorState {
  final String resultText;

  const CalculatorSuccess({required this.resultText});

  @override
  List<Object?> get props => [resultText];
}

class CalculatorError extends CalculatorState {
  final String message;

  const CalculatorError({required this.message});

  @override
  List<Object> get props => [message];
}