import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:love_your_self/mock/mock_mood_list.dart';

class HomeScreen extends StatefulWidget {
  static String routePath = '/home';
  static String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _moodList = [];

  String _getMoodIcon(String mood) {
    if (mood == 'EXCITED') return '🤩';
    if (mood == 'HAPPY') return '🥰';
    if (mood == 'NEUTRAL') return '😌';
    if (mood == 'SAD') return '😭';
    if (mood == 'ANGRY') return '🤬';
    if (mood == 'TIRED') return '🫠';

    return '👻';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood list'),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: MOCK_MOOD_LIST.length,
          itemBuilder: (context, index) {
            final mood = MOCK_MOOD_LIST[index % MOCK_MOOD_LIST.length];

            return ListTile(
              title: Text(mood["content"] ?? "No content"),
              subtitle: Text(mood["created"] ?? ""),
              leading: Text(
                _getMoodIcon(mood["mood"]),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
