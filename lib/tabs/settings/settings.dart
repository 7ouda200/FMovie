import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  List<Languages> languages = [
    Languages(name: 'English', code: 'en'),
    Languages(name: 'العربية', code: 'ar')
  ];
  //SharedPreferences? setdata;
  var value='L';
  @override
  Widget build(BuildContext context) {
    settingsProvider settingsprovider = Provider.of<settingsProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppLocalizations.of(context)!.darkmode,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
               value:value,
              items: [
                DropdownMenuItem(child:Text(AppLocalizations.of(context)!.dark,style: Theme.of(context).textTheme.bodySmall?.copyWith(color:AppTheme.primaryLight ),),value:'D'),
                DropdownMenuItem(child:Text(AppLocalizations.of(context)!.light,style: Theme.of(context).textTheme.bodySmall?.copyWith(color:AppTheme.primaryLight )),value:'L'),


              ], onChanged: (String? value) {
                 if(value=='D'){
                   settingsprovider.changeTheme(ThemeMode.dark);
                 }
                 else{
                   settingsprovider.changeTheme(ThemeMode.light);
                 }

            },


            ),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppLocalizations.of(context)!.lang,
                style:  Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: languages
                  .firstWhere((l) => l.code == settingsprovider.language),
              items: languages
                  .map((lang) =>
                  DropdownMenuItem(
                      value: lang, child: Text(lang.name,
                      style: TextStyle(color: AppTheme.primaryLight)
                  )))
                  .toList(),
              onChanged: (selectedvalue) async{
                if (selectedvalue != null) {
                  settingsprovider.changeLanguage(selectedvalue.code);
                  // setdata= await SharedPreferences.getInstance();
                  setState(() {

                    // setdata?.setString('lang', settingsprovider.language);
                    print(settingsprovider.language);
                  });
                }
              },
            )

          ],
        ),
      ),
    );
  }
}

class Languages {
  String name;
  String code;
  Languages({
    required this.name,
    required this.code,
  });
}
// Switch(
// activeColor: AppTheme.primaryLight,
// inactiveThumbColor: AppTheme.primaryLight,
// //thumbColor: MaterialStatePropertyAll(AppTheme.white),
// value: settingsprovider.themeMode == ThemeMode.dark,
// onChanged: (value) {
// if (value) {
// settingsprovider.changeTheme(ThemeMode.dark);
// } else {
// settingsprovider.changeTheme(ThemeMode.light);
// }
// },
// )

