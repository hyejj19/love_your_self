import 'package:flutter/material.dart';
import 'package:love_your_self/features/home/home_screen.dart';
import 'package:love_your_self/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = 'mainNavigation';

  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: widget.tab != 'home',
            child: Scaffold(
              body: HomeScreen(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavTab(),
              NavTab(),
            ],
          ),
        ),
      ),
    );
  }
}
