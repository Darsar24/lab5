import 'package:flutter/material.dart';
import 'package:lab5/db/calculation.dart';
import 'package:lab5/db/database_provider.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Calculation>> futureCalculations;

  @override
  void initState() {
    super.initState();
    futureCalculations = DatabaseProvider().getAllCalculations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('История расчётов')),
      body: FutureBuilder<List<Calculation>>(
        future: futureCalculations,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Calculation item = snapshot.data![index];
                return ListTile(
                  title: Text('a: ${item.a}, b: ${item.b}, c: ${item.c}'),
                  subtitle: Text(item.result),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}