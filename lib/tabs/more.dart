import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:todo/Edit_screen.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/setting.dart';
import 'package:todo/tasks.dart';
import 'package:provider/provider.dart';
import 'package:todo/tasks_provider.dart';

class more extends StatefulWidget {
  const more({super.key});

  @override
  State<more> createState() => _moreState();
}

class _moreState extends State<more> {
  @override
  Widget build(BuildContext context) {
    settingsProvider settingsprovider = Provider.of<settingsProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          TimelineCalendar(
            calendarType: CalendarType.GREGORIAN,
            calendarLanguage: "en",
            calendarOptions: CalendarOptions(
              viewType: ViewType.DAILY,
              toggleViewType: true,
              headerMonthElevation: 10,
              headerMonthShadowColor: settingsprovider.themeMode==ThemeMode.light?Colors.black26:Colors.white,
              headerMonthBackColor: Colors.transparent,
            ),
            dayOptions: DayOptions(
                compactMode: true,
                weekDaySelectedColor: const Color(0xff3AC3E2),
                selectedBackgroundColor: AppTheme.primaryLight,
                selectedTextColor:settingsprovider.themeMode==ThemeMode.light?Colors.black26:Colors.white,
                disableDaysBeforeNow: true),
            headerOptions: HeaderOptions(
                weekDayStringType: WeekDayStringTypes.SHORT,
                monthStringType: MonthStringTypes.FULL,
                backgroundColor: AppTheme.primaryLight,
                headerTextColor: AppTheme.whiteColor

            ),
            onChangeDateTime: (datetime) {
              print(datetime.getDate());
            },
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => edittask(taskProvider.tasks[index].id),));
                    },
                    child: TaskItem(taskProvider.tasks[index]));
              },
              itemCount: taskProvider.tasks.length,
            ),
          )
        ],
      ),
    ));
  }
}
