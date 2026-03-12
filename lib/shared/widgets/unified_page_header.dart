import 'package:flutter/material.dart';

import 'family_selector.dart';

class UnifiedPageHeader extends StatelessWidget {
  const UnifiedPageHeader({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionTap,
  });

  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          if (title == 'Ongii') ...[
            const Icon(Icons.pets_rounded, size: 20, color: Color(0xFFE65100)),
            const SizedBox(width: 6),
          ],
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFFE65100),
            ),
          ),
          const Spacer(),
          const FamilySelector(),
          if (actionIcon != null) ...[
            const SizedBox(width: 4),
            IconButton(onPressed: onActionTap ?? () {}, icon: Icon(actionIcon)),
          ],
        ],
      ),
    );
  }
}
