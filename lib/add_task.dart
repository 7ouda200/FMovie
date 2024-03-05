import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/reusable_widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo/tabs/settings/setting.dart';
import 'package:todo/tasks_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  var title = TextEditingController();
  var description=TextEditingController();
  final dateformat=DateFormat('dd/MM/yyyy');
  var selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    settingsProvider settingsprovider = Provider.of<settingsProvider>(context);
    return Container(
      color: settingsprovider.themeMode==ThemeMode.light?AppTheme.whiteColor:AppTheme.primaryDark,
      height: MediaQuery.of(context).size.height*0.5,
      padding: EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context)!.addtask,
            style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20,),
            textFild(controller: title,hint: 'Enter task title',),
            SizedBox(height: 10,),
            textFild(controller: description,hint: 'enter task description ',maxline: 5,),
            SizedBox(height: 5,),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Selected Date',
              style:Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 5,),
            InkWell(
              onTap: ()async{
                final dateTime=await showDatePicker(context: context,
                    firstDate:DateTime.now(),
                    lastDate:DateTime.now().add(Duration(days: 365)),
                    initialDate:selectedDate,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,

                );
                if(dateTime!=null)selectedDate=dateTime;
                setState(() {

                });
              },
              child: Text(
               dateformat.format(selectedDate),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 5,),
            elevated_btn(label:AppLocalizations.of(context)!.add,
            onpressed: addtask
            ),


          ],
        ),
      ),
    );
  }
  void addtask(){
    FirebaseUtils.addTaskToFirestore(TaskModel(
        title:title.text,
        description: description.text,
        dateTime:selectedDate,
       )).timeout(
      const Duration(milliseconds: 500),
      onTimeout: (){
        print('success');
      }
    ).catchError((_){

      print('Error,try again');
    });
   Provider.of<TaskProvider>(context,listen:false).getTasks();
   Navigator.of(context).pop();
  }
}

