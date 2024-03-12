import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/settings/setting.dart';
import 'package:todo/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Edit_screen.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(this.task);
  final TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    settingsProvider settingsprovider = Provider.of<settingsProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Slidable(
        startActionPane: ActionPane(
          key: UniqueKey(),
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                 delete(widget.task.id);
                 setState(() {

                 });
              },
              backgroundColor: Colors.red,
              label: 'Delete',
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          edittask(widget.task.id),
                    ));
              },
              backgroundColor: Colors.blue,
              label: 'Edit',
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: settingsprovider.themeMode==ThemeMode.light?AppTheme.whiteColor:AppTheme.taskcolor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 4,
                height: 62,
                color: widget.task.isDone==false?AppTheme.primaryLight:AppTheme.greenColor,
                margin: EdgeInsetsDirectional.only(end: 8),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.task.title}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: widget.task.isDone==false?AppTheme.primaryLight:AppTheme.greenColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.task.description}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color:settingsprovider.themeMode==ThemeMode.light?AppTheme.blackColor:AppTheme.whiteColor),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (widget.task.isDone == false) {
                    addtask(widget.task.id, true);
                  } else {
                    addtask(widget.task.id, false);
                  }
                },
                child: Container(
                  width: 65,
                  height: 28,
                  decoration: BoxDecoration(
                    color: widget.task.isDone==false?AppTheme.primaryLight:AppTheme.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(
                    child: widget.task.isDone == false
                        ? Icon(
                            Icons.check,
                            color: AppTheme.whiteColor,
                          )
                        : Text(
                      AppLocalizations.of(context)!.done,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Colors.green,fontSize: 22),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addtask(String id, bool is_Done) {
    FirebaseUtils.editTaskToFirestore(id, is_Done);
    Provider.of<TaskProvider>(context, listen: false).getTasks();
  }
  void delete(String id){
    FirebaseUtils.deleteTaskToFirestore(id).timeout(
        const Duration(milliseconds: 500),
        onTimeout: (){
          Fluttertoast.showToast(
              msg: "Task deleted successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

    ).catchError((_){
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
    Provider.of<TaskProvider>(context, listen: false).getTasks();
  }
}
