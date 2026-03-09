import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../shared/models/models.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final members = <OngiiUser>[
      const OngiiUser(id: 'u1', name: 'Grandma Sarah', avatarLabel: 'S'),
      const OngiiUser(id: 'u2', name: 'Dad Michael', avatarLabel: 'M'),
      const OngiiUser(id: 'u3', name: 'Mom Jane', avatarLabel: 'J'),
      const OngiiUser(id: 'u4', name: 'Me', avatarLabel: 'ME'),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              ),
              Text('My Page', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: AppTheme.accentSoft,
                  child: Icon(Icons.person, size: 34, color: AppTheme.textMuted),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jane Doe', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 3),
                      Text('Grandmother', style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.accentSoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('Edit Profile', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Family Members', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              const Text('+ Add', style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: members
                  .map(
                    (member) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: AppTheme.accentSoft,
                        child: Text(
                          member.avatarLabel,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          const _MenuItem(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            subtitle: 'Manage alerts and sounds',
          ),
          const SizedBox(height: 10),
          const _MenuItem(
            icon: Icons.groups_outlined,
            title: 'Family Management',
            subtitle: 'Manage family member permissions',
          ),
          const SizedBox(height: 10),
          const _MenuItem(
            icon: Icons.security_outlined,
            title: 'Privacy & Security',
            subtitle: 'Data and account safety settings',
          ),
          const SizedBox(height: 10),
          const _MenuItem(
            icon: Icons.help_outline_rounded,
            title: 'Support',
            subtitle: 'FAQ and contact us',
          ),
          const SizedBox(height: 18),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Log out',
                style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppTheme.accentSoft,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: AppTheme.textPrimary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppTheme.textMuted),
        ],
      ),
    );
  }
}
