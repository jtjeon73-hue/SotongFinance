import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lib has no Firestore/Analytics personal finance persistence', () {
    final root = Directory('lib');
    final hits = <String>[];
    for (final f in root.listSync(recursive: true)) {
      if (f is! File || !f.path.endsWith('.dart')) continue;
      final text = f.readAsStringSync();
      for (final needle in [
        'FirebaseFirestore',
        'cloud_firestore',
        'FirebaseAnalytics',
        'logEvent(',
        'shared_preferences',
        'Hive.open',
      ]) {
        if (text.contains(needle)) {
          hits.add('${f.path}: $needle');
        }
      }
    }
    expect(hits, isEmpty, reason: hits.join('\n'));
  });
}
