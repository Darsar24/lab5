import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab5/cubit/calculator_cubit.dart';
import 'package:lab5/cubit/calculator_state.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _cController = TextEditingController();
  bool _agree = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agree) {
      final double a = double.parse(_aController.text);
      final double b = double.parse(_bController.text);
      final double c = double.parse(_cController.text);

      context.read<CalculatorCubit>().calculateRoots(a, b, c);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля и примите соглашение.')),
      );
    }
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Квадратное уравнение'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _aController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Коэффициент a'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите коэффициент a';
                  if (double.tryParse(value) == null) return 'Неверный формат числа';
                  if (double.parse(value) == 0) return 'a не может быть равно 0';
                  return null;
                },
              ),
              TextFormField(
                controller: _bController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Коэффициент b'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите коэффициент b';
                  if (double.tryParse(value) == null) return 'Неверный формат числа';
                  return null;
                },
              ),
              TextFormField(
                controller: _cController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Коэффициент c'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите коэффициент c';
                  if (double.tryParse(value) == null) return 'Неверный формат числа';
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Согласен на обработку данных'),
                value: _agree,
                onChanged: (value) {
                  setState(() {
                    _agree = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Рассчитать'),
              ),
              SizedBox(height: 30),
              BlocBuilder<CalculatorCubit, CalculatorState>(
                builder: (context, state) {
                  if (state is CalculatorInitial) {
                    return Text('Введите данные и нажмите "Рассчитать"', style: TextStyle(fontSize: 16));
                  }

                  if (state is CalculatorLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is CalculatorSuccess) {
                    return Text(state.resultText, style: TextStyle(fontSize: 18, color: Colors.green));
                  }

                  if (state is CalculatorError) {
                    return Text(state.message, style: TextStyle(fontSize: 18, color: Colors.red));
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}