import 'enums.dart';

class FinancialTerm {
  const FinancialTerm({
    required this.id,
    required this.term,
    required this.definition,
    required this.category,
    this.example,
    this.relatedIds = const [],
    this.sourceIds = const [],
    this.difficulty = Difficulty.intro,
  });

  final String id;
  final String term;
  final String definition;
  final String category;
  final String? example;
  final List<String> relatedIds;
  final List<String> sourceIds;
  final Difficulty difficulty;
}
