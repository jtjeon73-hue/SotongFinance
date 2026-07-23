class CalculatorField {
  const CalculatorField({
    required this.key,
    required this.label,
    required this.unit,
    this.hint,
    this.defaultValue = '',
  });

  final String key;
  final String label;
  final String unit;
  final String? hint;
  final String defaultValue;
}

class CalculatorDefinition {
  const CalculatorDefinition({
    required this.id,
    required this.title,
    required this.purpose,
    required this.formula,
    required this.fields,
    required this.limitations,
    this.example,
    this.route = '',
  });

  final String id;
  final String title;
  final String purpose;
  final String formula;
  final List<CalculatorField> fields;
  final List<String> limitations;
  final String? example;
  final String route;
}
