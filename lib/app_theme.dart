import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryLight = Color(0xFF5D9CEC);
  static Color primaryDark=Color(0xFF141A2E);
  static Color backgroundColorLight = Color(0xFFDFECDB);
  static Color backgroundColorDark = Color(0xFF060E1E);
  static Color greenColor = Color(0xFF61E757);
  static Color redColor = Color(0xFFEC4B4B);
  static Color blackColor = Color(0xFF141922);
  static Color greyColor = Color(0xFFC8C9CB);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color taskcolor = Color(0xFF141922);



  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLight,
    scaffoldBackgroundColor:greyColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLight,
      //backgroundColor: whiteColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: greyColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        side:BorderSide(
          color: whiteColor,
            width: 4,

        )
      )

    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: primaryLight,
      titleTextStyle: TextStyle(
          color: whiteColor, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize:20,
        fontWeight: FontWeight.w400,
        color: blackColor,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: blackColor
      ),
      headlineSmall: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: blackColor,
      ),
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: blackColor),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryDark,
    scaffoldBackgroundColor: primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLight,
      backgroundColor: primaryDark,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: greyColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: primaryLight,
      titleTextStyle: TextStyle(
          color: blackColor, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryLight,
        foregroundColor: whiteColor,
        shape: RoundedRectangleBorder(
            side:BorderSide(
              color: whiteColor,
              width: 4,

            )
        )

    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize:20,
        fontWeight: FontWeight.w400,
        color: whiteColor,
      ),
      bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: whiteColor
      ),
      headlineSmall: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: whiteColor,
      ),
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: whiteColor),
    ),


  );
}
