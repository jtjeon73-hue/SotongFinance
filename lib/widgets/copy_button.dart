import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    super.key,
    required this.text,
    this.label = '복사',
    this.successMessage = '클립보드에 복사했습니다',
    this.icon = Icons.copy,
  });

  final String text;
  final String label;
  final String successMessage;
  final IconData icon;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successMessage),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label 버튼',
      child: IconButton(
        onPressed: () => _copy(context),
        icon: Icon(icon),
        tooltip: label,
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      ),
    );
  }
}

class CopyTextButton extends StatelessWidget {
  const CopyTextButton({
    super.key,
    required this.text,
    this.label = '복사',
    this.successMessage = '클립보드에 복사했습니다',
  });

  final String text;
  final String label;
  final String successMessage;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: OutlinedButton.icon(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: text));
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(successMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: const Icon(Icons.copy, size: 18),
        label: Text(label),
      ),
    );
  }
}
