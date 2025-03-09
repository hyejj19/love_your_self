import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_your_self/features/home/models/mood_model.dart';

class MoodState {
  final List<Mood> moods;
  final bool isLoading;
  final bool hasData;

  MoodState({
    required this.moods,
    required this.isLoading,
    required this.hasData,
  });

  factory MoodState.initial() {
    return MoodState(moods: [], isLoading: true, hasData: true);
  }

  MoodState copyWith({
    List<Mood>? moods,
    bool? isLoading,
    bool? hasData,
  }) {
    return MoodState(
      moods: moods ?? this.moods,
      isLoading: isLoading ?? this.isLoading,
      hasData: hasData ?? this.hasData,
    );
  }
}

class MoodViewModel extends StateNotifier<MoodState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  MoodViewModel() : super(MoodState.initial());

  Future<void> fetchMoodData(String userId) async {
    try {
      state = state.copyWith(isLoading: true);

      QuerySnapshot snapshot = await _firestore
          .collection('moods')
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isEmpty) {
        state = state.copyWith(hasData: false, isLoading: false);
      } else {
        List<Mood> moods = snapshot.docs
            .map(
                (doc) => Mood.fromFirestore(doc.data() as Map<String, dynamic>))
            .toList();
        state = state.copyWith(moods: moods, hasData: true, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(hasData: false, isLoading: false);
      print("Error fetching data: $e");
    }
  }

  Future<void> postMoodData(Mood mood, String userId) async {
    await _firestore.collection('moods').add({
      'userId': userId,
      'mood': mood.mood,
      'content': mood.content,
      'created': mood.created,
    });
  }
}

final moodViewModelProvider = StateNotifierProvider<MoodViewModel, MoodState>(
  (ref) => MoodViewModel(),
);
