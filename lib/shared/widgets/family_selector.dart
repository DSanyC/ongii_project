import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class FamilySelector extends StatelessWidget {
  FamilySelector({super.key});

  static const List<String> families = <String>[
    'Kim Family',
    'Lee Family',
    'Park Family',
    'Choi Family',
    'Han Family',
  ];

  static final ValueNotifier<String> selectedFamily =
      ValueNotifier<String>(families.first);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedFamily,
      builder: (context, value, _) {
        return PopupMenuButton<String>(
          onSelected: (family) => selectedFamily.value = family,
          itemBuilder: (context) {
            return families
                .map(
                  (family) => PopupMenuItem<String>(
                    value: family,
                    child: Text(family),
                  ),
                )
                .toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFE8E8E8)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
                const SizedBox(width: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
