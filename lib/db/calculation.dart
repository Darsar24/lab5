class Calculation {
  final int? id;
  final double a;
  final double b;
  final double c;
  final String result;

  const Calculation({
    this.id,
    required this.a,
    required this.b,
    required this.c,
    required this.result,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'a': a,
      'b': b,
      'c': c,
      'result': result,
    };
  }

  factory Calculation.fromMap(Map<String, Object?> map) {
    return Calculation(
      id: map['id'] as int?,
      a: map['a'] as double,
      b: map['b'] as double,
      c: map['c'] as double,
      result: map['result'] as String,
    );
  }
}