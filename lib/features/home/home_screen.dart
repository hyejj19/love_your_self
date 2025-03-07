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
  String _getMoodIcon(String mood) {
    if (mood == 'EXCITED') return '🤩';
    if (mood == 'HAPPY') return '🥰';
    if (mood == 'NEUTRAL') return '😌';
    if (mood == 'SAD') return '😭';
    if (mood == 'ANGRY') return '🤬';
    if (mood == 'TIRED') return '🫠';
    return '👻';
  }

  void _showMoodDetail(BuildContext context, Map<String, dynamic> mood) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getMoodIcon(mood["mood"]),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Text(
                  mood["content"] ?? "No content",
                  style: TextStyle(fontSize: 18),
                ),
                const Gap(20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood list')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Gap(10),
            itemCount: MOCK_MOOD_LIST.length,
            itemBuilder: (context, index) {
              final mood = MOCK_MOOD_LIST[index];

              return ListTile(
                title: Text(mood["content"] ?? "No content"),
                subtitle: Text(mood["created"] ?? ""),
                leading: Text(
                  _getMoodIcon(mood["mood"]),
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () => _showMoodDetail(context, mood),
              );
            },
          ),
        ),
      ),
    );
  }
}
