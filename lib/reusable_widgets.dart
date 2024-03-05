import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/setting.dart';
import 'package:provider/provider.dart';



class textFild extends StatelessWidget {
  const textFild({this.controller, this.hint, this.valid,this.maxline});
 final controller;
 final hint;
 final valid;
 final maxline;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline,
      controller: controller,
      keyboardType: TextInputType.name,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: '$hint',
        hintStyle:  Theme.of(context).textTheme.bodySmall,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey, width: 2),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 3,
          ),
        ),
      ),
      validator: (String? value) {
        return (value!.isEmpty) ? 'Please Enter $valid' : null;
      },
    );
  }
}

class elevated_btn extends StatelessWidget {
   elevated_btn({this.label,required this.onpressed});
  final label;
  VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    settingsProvider settingsprovider = Provider.of<settingsProvider>(context);

    return ElevatedButton(
        onPressed:onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:AppTheme.primaryLight,
              fixedSize: Size(MediaQuery.of(context).size.width,52.0)
        ),
        child:Text('$label',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.whiteColor),
        )

    );
  }
}

