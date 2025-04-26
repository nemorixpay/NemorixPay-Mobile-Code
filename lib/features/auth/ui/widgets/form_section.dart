import 'package:flutter/material.dart';

/// @file        form_section.dart
/// @brief       Implementation of a form section widget.
/// @details     This widget is used to group related form fields with a title and optional description.
///              It provides a consistent visual structure for form sections across the app.
/// @author      Miguel Fagundez
/// @date        04/26/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class FormSection extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const FormSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(description!, style: Theme.of(context).textTheme.bodyMedium),
          ],
          const SizedBox(height: 16),
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
