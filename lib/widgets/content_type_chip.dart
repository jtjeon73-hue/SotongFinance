import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/enums.dart';

Color contentTypeColor(ContentType type) => switch (type) {
  ContentType.concept => AppColors.blue,
  ContentType.calculation => AppColors.teal,
  ContentType.risk => AppColors.danger,
  ContentType.tax => AppColors.tax,
  ContentType.officialCheck => AppColors.official,
  ContentType.scenario => AppColors.scenario,
  ContentType.actionGuide => AppColors.action,
  ContentType.professionalReview => AppColors.warning,
  ContentType.checklist => AppColors.navy,
  ContentType.glossary => AppColors.gold,
};

class ContentTypeChip extends StatelessWidget {
  const ContentTypeChip({super.key, required this.type});

  final ContentType type;

  @override
  Widget build(BuildContext context) {
    final color = contentTypeColor(type);
    return Chip(
      label: Text(type.label),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.35)),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
