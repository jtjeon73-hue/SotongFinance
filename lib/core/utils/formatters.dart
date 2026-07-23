import 'package:intl/intl.dart';

final _won = NumberFormat('#,###', 'ko_KR');
final _decimal = NumberFormat('#,##0.##', 'ko_KR');

String formatWon(num value) => '${_won.format(value.round())}원';

String formatNumber(num value) => _decimal.format(value);

String formatPercent(num value, {int digits = 2}) =>
    '${value.toStringAsFixed(digits)}%';

bool isValidUrl(String url) {
  final uri = Uri.tryParse(url);
  return uri != null &&
      (uri.scheme == 'https' || uri.scheme == 'http') &&
      uri.host.isNotEmpty;
}
