import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class HighlightText extends StatelessWidget {
  const HighlightText({
    super.key,
    required this.text,
    this.query = '',
    this.style,
    this.highlightStyle,
  });

  final String text;
  final String query;
  final TextStyle? style;
  final TextStyle? highlightStyle;

  @override
  Widget build(BuildContext context) {
    final q = query.trim();
    if (q.isEmpty) {
      return Text(text, style: style);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = q.toLowerCase();
    final spans = <TextSpan>[];
    var start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index < 0) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + q.length),
          style:
              highlightStyle ??
              TextStyle(
                backgroundColor: AppColors.gold.withValues(alpha: 0.35),
                fontWeight: FontWeight.w700,
              ),
        ),
      );
      start = index + q.length;
    }

    return Text.rich(TextSpan(style: style, children: spans));
  }
}
