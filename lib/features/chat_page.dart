import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../shared/models/models.dart';
import '../shared/widgets/unified_page_header.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = <OngiiChatMessage>[
      OngiiChatMessage(
        id: 'c1',
        authorId: 'Mom',
        text: 'I will arrive around 7pm. I can bring extra side dishes.',
        createdAt: DateTime(2026, 3, 7, 15, 2),
        mine: false,
      ),
      OngiiChatMessage(
        id: 'c2',
        authorId: 'Me',
        text: 'Great. I will prepare dessert.',
        createdAt: DateTime(2026, 3, 7, 15, 7),
        mine: true,
      ),
      OngiiChatMessage(
        id: 'c3',
        authorId: 'Grandpa',
        text: 'I will share flower photos today.',
        createdAt: DateTime(2026, 3, 7, 15, 10),
        mine: false,
      ),
    ];

    return SafeArea(
      child: Column(
        children: [
          const _ChatHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _ChatBubble(message: messages[index]);
              },
            ),
          ),
          const _Composer(),
        ],
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader();

  @override
  Widget build(BuildContext context) {
    return const UnifiedPageHeader(
      title: 'Family Chat',
      actionIcon: Icons.group_outlined,
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final OngiiChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      constraints: const BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: message.mine ? AppTheme.accent : Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: AppTheme.textPrimary,
          fontWeight: message.mine ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );

    return Align(
      alignment: message.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: bubble,
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEDEDED))),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppTheme.accentSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.camera_alt_outlined, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFF3F3F3),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Type a message...',
                style: TextStyle(color: AppTheme.textMuted),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppTheme.accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send_rounded, size: 18),
          ),
        ],
      ),
    );
  }
}
