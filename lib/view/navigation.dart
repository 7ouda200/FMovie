import 'package:flutter/material.dart';
import 'package:movies_app/view/tabs/Browse/browse.dart';
import 'package:movies_app/view/tabs/home.dart';
import 'package:movies_app/view/tabs/search/search.dart';
import 'package:movies_app/view/tabs/watchlist.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int selectedtap = 0;
  List<Widget> taps = const[
    HomeScreen(),
    Search(),
    Browse(),
    WatchList()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: taps[selectedtap],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedtap,
          onTap: (inedx) {
            selectedtap = inedx;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'BROWSE'),
            BottomNavigationBarItem(
                icon: Icon(Icons.live_tv), label: 'WATCHLIST'),
          ],
        ),
      ),
    );
  }
}
