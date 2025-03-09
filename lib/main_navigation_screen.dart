import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:love_your_self/features/home/home_screen.dart';
import 'package:love_your_self/features/post/post_screen.dart';
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
  final List<String> _tabs = ["home", "post"];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");

    setState(() {
      _selectedIndex = index;
    });
  }

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
            offstage: _selectedIndex != 0,
            child: Scaffold(
              body: const HomeScreen(),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: Scaffold(
              body: const PostScreen(),
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
              NavTab(
                icon: FontAwesomeIcons.house,
                color: widget.tab == 'home'
                    ? Colors.black87
                    : Colors.grey.shade400,
                onTap: () => _onTap(0),
              ),
              NavTab(
                icon: FontAwesomeIcons.pen,
                color: widget.tab == 'post'
                    ? Colors.black87
                    : Colors.grey.shade400,
                onTap: () => _onTap(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
