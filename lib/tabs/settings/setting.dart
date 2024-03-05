import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';


class settingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  // SharedPreferences? setdata;


  String get backgroundImgPath{
    return themeMode==ThemeMode.light?'default_bg.png':'dark_bg.png';
 }
  void changeTheme(ThemeMode selectedTheme) {
   if(selectedTheme==themeMode){
     return;
   };
    themeMode = selectedTheme;
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    language = selectedLanguage;
    //setdata?.setString('lang',language);
    notifyListeners();
  }
}
