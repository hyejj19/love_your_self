import 'package:cloud_firestore/cloud_firestore.dart';

class Mood {
  final String mood;
  final String content;
  final Timestamp created;
  final String userId;

  Mood({
    required this.mood,
    required this.content,
    required this.created,
    required this.userId,
  });

  factory Mood.fromFirestore(Map<String, dynamic> data) {
    return Mood(
      mood: data['mood'] ?? '',
      content: data['content'] ?? '',
      created: data['created'] as Timestamp,
      userId: data['userId'] as String,
    );
  }
}
