class Mood {
  final String mood;
  final String content;
  final String created;

  Mood({
    required this.mood,
    required this.content,
    required this.created,
  });

  factory Mood.fromFirestore(Map<String, dynamic> doc) {
    return Mood(
      mood: doc['mood'] ?? '',
      content: doc['content'] ?? '',
      created: doc['created'] ?? '',
    );
  }
}
