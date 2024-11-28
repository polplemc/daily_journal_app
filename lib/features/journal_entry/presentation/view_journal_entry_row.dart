import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabelValueRow extends StatelessWidget {
  final String label;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2639896179.
  final dynamic value;

  const LabelValueRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text("$value"),
      ],
    );
  }
}
