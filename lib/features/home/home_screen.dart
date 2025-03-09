import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/authentication/login_screen.dart';
import 'package:love_your_self/features/authentication/view_models/auth_view_model.dart';
import 'package:love_your_self/features/home/models/mood_model.dart';
import 'package:love_your_self/features/home/view_model/mood_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String routePath = '/home';
  static String routeName = 'home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _getMoodIcon(String mood) {
    if (mood == 'EXCITED') return '🤩';
    if (mood == 'HAPPY') return '🥰';
    if (mood == 'NEUTRAL') return '😌';
    if (mood == 'SAD') return '😭';
    if (mood == 'ANGRY') return '🤬';
    if (mood == 'TIRED') return '🫠';
    return '👻';
  }

  void _showMoodDetail(BuildContext context, Mood mood) {
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
                  _getMoodIcon(mood.mood),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Text(
                  mood.content ?? "No content",
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
  void initState() {
    super.initState();

    User? user = ref.read(authViewModelProvider);
    if (user != null) {
      ref.read(moodViewModelProvider.notifier).fetchMoodData(user.uid);
    } else {
      context.go(LoginScreen.routePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final moodState = ref.watch(moodViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Mood list')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: moodState.isLoading
              ? Center(child: CircularProgressIndicator())
              : moodState.hasData
                  ? ListView.separated(
                      separatorBuilder: (context, index) => const Gap(10),
                      itemCount: moodState.moods.length,
                      itemBuilder: (context, index) {
                        final mood = moodState.moods[index];

                        return ListTile(
                          title: Text(mood.content),
                          subtitle: Text(mood.created.toDate().toString()),
                          leading: Text(
                            _getMoodIcon(mood.mood),
                            style: TextStyle(fontSize: 30),
                          ),
                          onTap: () => _showMoodDetail(context, mood),
                        );
                      },
                    )
                  : Center(child: Text('무드 데이터가 존재하지 않습니다!')),
        ),
      ),
    );
  }
}
