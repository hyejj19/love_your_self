import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:love_your_self/widgets/full_width_tap_button.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
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

  void _onSubmitPost() {
    if (_selectedMood != null && _moodController.text.isNotEmpty) {
      // TODO: firestore 에 데이터 저장
      print("무드: $_selectedMood, 내용: ${_moodController.text}");
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
    setState(() {}); // 입력 값이 바뀌면 UI 갱신
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
