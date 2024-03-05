import 'package:flutter/material.dart';
import 'package:todo/add_task.dart';
import 'tabs/settings/settings.dart';
import 'tabs/more.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class home_screen extends StatefulWidget {
  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  List<Widget> taps = [
    more(),
    setting(),
  ];
  int selectedtap = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
            title: selectedtap == 0
                ? Padding(
                    padding: EdgeInsetsDirectional.only(start: 20),
                    child: Text(AppLocalizations.of(context)!.todolist))
                : Padding(
                    padding: EdgeInsetsDirectional.only(start: 20),
                    child: Text(AppLocalizations.of(context)!.setting))),
        body: taps[selectedtap],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.zero,
          notchMargin: 8,
          surfaceTintColor: Colors.white,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedtap,
            onTap: (inedx) {
              selectedtap = inedx;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(label: 'Tasks', icon: Icon(Icons.list)),
              BottomNavigationBarItem(
                  label: 'settings', icon: Icon(Icons.settings)),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => Tasks(),);
          },
          child: Icon(Icons.add,size: 32,),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
