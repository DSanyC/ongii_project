class OngiiUser {
  const OngiiUser({
    required this.id,
    required this.name,
    required this.avatarLabel,
  });

  final String id;
  final String name;
  final String avatarLabel;
}

class OngiiEvent {
  const OngiiEvent({
    required this.id,
    required this.title,
    required this.startAt,
    required this.endAt,
    required this.description,
    required this.createdAt,
  });

  final String id;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime createdAt;
  final String title;
  final String description;
}

class OngiiPost {
  const OngiiPost({
    required this.id,
    required this.type,
    required this.authorId,
    required this.content,
    required this.createdAt,
    required this.pinned,
    required this.likes,
    required this.comments,
  });

  final String id;
  final String type;
  final String authorId;
  final String content;
  final DateTime createdAt;
  final bool pinned;
  final int likes;
  final int comments;
}

class OngiiChatMessage {
  const OngiiChatMessage({
    required this.id,
    required this.authorId,
    required this.text,
    required this.createdAt,
    required this.mine,
  });

  final String id;
  final String authorId;
  final String text;
  final DateTime createdAt;
  final bool mine;
}
