import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.light;
  get theme => _theme;
  get isDark => _theme == ThemeMode.dark;
  get isLight => _theme == ThemeMode.light;

  toggleTheme() {
    if (_theme == ThemeMode.light) {
      _theme = ThemeMode.dark;
    } else {
      _theme = ThemeMode.light;
    }

    notifyListeners();
  }

  /// Here we define our theme colors for dark mode
  ThemeData get darkTheme {
    return ThemeData(
      backgroundColor: Colors.grey[900],
      primaryColor: Colors.indigo[400],
      accentColor: Colors.indigo[100],
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: Colors.grey[850], elevation: 0),
      snackBarTheme: SnackBarThemeData(
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo[400],
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0))),
    );
  }

  /// Here we define our theme colors for dark mode
  ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.indigo[400],
      accentColor: Colors.indigo[100],
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(elevation: 0),
      snackBarTheme: SnackBarThemeData(
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo[400],
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0))),
    );
  }
}
