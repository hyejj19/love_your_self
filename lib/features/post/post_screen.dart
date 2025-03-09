import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/login_screen.dart';
import 'package:love_your_self/features/authentication/view_models/auth_view_model.dart';
import 'package:love_your_self/features/home/models/mood_model.dart';
import 'package:love_your_self/features/home/view_model/mood_view_model.dart';
import 'package:love_your_self/widgets/full_width_tap_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController _moodController = TextEditingController();
  String? _selectedMood;

  final List<Map<String, String>> _moods = [
    {"emoji": "🤩", "label": "Excited"},
    {"emoji": "🥰", "label": "Happy"},
    {"emoji": "😌", "label": "Neutral"},
    {"emoji": "😭", "label": "Sad"},
    {"emoji": "🤬", "label": "Angry"},
    {"emoji": "🫠", "label": "Tired"},
  ];

  void _onSubmitPost() async {
    if (_selectedMood != null && _moodController.text.isNotEmpty) {
      User? user = ref.read(authViewModelProvider);

      if (user != null) {
        try {
          Mood mood = Mood(
              mood: _selectedMood!,
              content: _moodController.text,
              created: FieldValue.serverTimestamp().toString());

          await ref
              .read(moodViewModelProvider.notifier)
              .postMoodData(mood, user.uid);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('포스팅에 성공했어요!')),
          );

          setState(() {
            _selectedMood = null;
            _moodController.clear();
          });

          context.go("/home");
        } catch (e) {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('포스팅에 실패했어요!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('먼저 로그인 해주세요.')),
        );

        context.go(LoginScreen.routePath);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _moodController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _moodController.removeListener(_onTextChanged);
    _moodController.dispose();

    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('How do you feel?'),
      ),
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              Text(
                '오늘의 기분은 어때요?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 10,
                    children: _moods.map((mood) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedMood = mood["emoji"]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedMood == mood["emoji"]
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade200,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            mood["emoji"]!,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              Gap(32),
              Text(
                '조금 더 자세하게 말해주세요.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(16),
              TextField(
                controller: _moodController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "왜 그런 기분을 느꼈나요?",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Gap(32),
              FullWidthTapButton(
                onTap: _onSubmitPost,
                isActive:
                    _selectedMood != null && _moodController.text.isNotEmpty,
                text: 'Post!',
              )
            ],
          ),
        ),
      ),
    );
  }
}
