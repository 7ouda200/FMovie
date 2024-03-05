import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/reusable_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/settings/setting.dart';
import 'package:todo/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class edittask extends StatefulWidget {
   edittask(this.id);
  String id;

  @override
  State<edittask> createState() => _edittaskState();
}

class _edittaskState extends State<edittask> {
  var title = TextEditingController();
  var description = TextEditingController();
  final dateformat = DateFormat('dd/MM/yyyy');
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    settingsProvider settingsprovider = Provider.of<settingsProvider>(context);

    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: <Widget>[
        Container(
          height: 160,
          child: AppBar(
            title: Text(AppLocalizations.of(context)!.todolist),
          ),
        ),
        Center(
          child: Container(
            height: 500.0,
            width: 350.0,
            decoration: BoxDecoration(
                color: settingsprovider.themeMode==ThemeMode.light?AppTheme.whiteColor:AppTheme.taskcolor,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: new Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Center(child: Text(AppLocalizations.of(context)!.edittask,
                    style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textFild(
                      controller: title,
                      hint: 'Enter task title',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textFild(
                      controller: description,
                      hint: 'enter task description ',
                      maxline: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Selected Date',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        final dateTime = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                          initialDate: selectedDate,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );
                        if (dateTime != null) selectedDate = dateTime;
                        setState(() {});
                      },
                      child: Text(
                        dateformat.format(selectedDate),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    elevated_btn(label:AppLocalizations.of(context)!.save,
                        onpressed: edittask
                    ),


                  ],
                ),
              ),
            ),
            ),
          ),
        ),
      ],
    )));
  }

  void edittask(){
    FirebaseUtils.editTaskToFirestore2(
      TaskModel(
      title:title.text,
      description: description.text,
      dateTime:selectedDate,
    ),widget.id

    ).timeout(
        const Duration(milliseconds: 500),
        onTimeout: (){
          print('success');
        }
    ).catchError((_){

      print('Error,try again');
    });
    Provider.of<TaskProvider>(context,listen:false).getTasks();
  }

}
