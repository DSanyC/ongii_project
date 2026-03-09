import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../shared/models/models.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = <OngiiPost>[
      OngiiPost(
        id: 'p1',
        type: 'photo',
        authorId: 'u1',
        content: 'Walked through flowers today. Great weather and great memories.',
        createdAt: DateTime(2026, 3, 7, 9, 20),
        pinned: true,
        likes: 12,
        comments: 3,
      ),
      OngiiPost(
        id: 'p2',
        type: 'text',
        authorId: 'u2',
        content: 'Cookie baking this weekend. Kids will love it.',
        createdAt: DateTime(2026, 3, 6, 14, 10),
        pinned: false,
        likes: 8,
        comments: 5,
      ),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        children: [
          Row(
            children: [
              const Icon(Icons.family_restroom, color: AppTheme.accent),
              const SizedBox(width: 6),
              Text('Ongii', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _FeedFilter(),
          const SizedBox(height: 14),
          for (final post in posts) ...[
            _PostCard(post: post),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _FeedFilter extends StatelessWidget {
  const _FeedFilter();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: const [
        _FilterChip(label: 'All', selected: true),
        _FilterChip(label: 'Photo'),
        _FilterChip(label: 'Text'),
        _FilterChip(label: 'Notice'),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppTheme.accent : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? AppTheme.accent : const Color(0xFFE5E5E5),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final OngiiPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            color: Color(0x12000000),
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.pinned)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: const BoxDecoration(
                color: AppTheme.accentSoft,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: const Text('Pinned notice', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppTheme.accentSoft,
                  child: Text('GM'),
                ),
                const SizedBox(width: 8),
                Text(
                  post.authorId == 'u1' ? 'Grandma Sarah' : 'Dad Michael',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  '${post.createdAt.month}/${post.createdAt.day}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFFF7C25D), Color(0xFFE88E3B), Color(0xFF2E4E5E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(post.content, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: [
                const Icon(Icons.favorite_border, size: 18, color: AppTheme.textMuted),
                const SizedBox(width: 4),
                Text('${post.likes}'),
                const SizedBox(width: 12),
                const Icon(Icons.mode_comment_outlined, size: 18, color: AppTheme.textMuted),
                const SizedBox(width: 4),
                Text('${post.comments}'),
                const Spacer(),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(98, 34),
                    backgroundColor: AppTheme.accent,
                    foregroundColor: AppTheme.textPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {},
                  child: const Text('Comment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
