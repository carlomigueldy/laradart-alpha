// Packages
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Providers
import './providers/auth_provider.dart';
import './providers/user_provider.dart';

// Screens
import './screens/home_screen.dart';
import './screens/user_detail_screen.dart';
import './screens/users_screen.dart';
import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/unknown_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          // debugShowCheckedModeBanner: false,
          title: 'Auth Starter',
          themeMode: ThemeMode.dark,
          theme: ThemeData(),
          darkTheme: darkTheme(),
          home: home(auth),
          onGenerateRoute: (settings) {
            final arguments = settings.arguments;
            switch (settings.name) {
              case HomeScreen.routeName:
                return MaterialPageRoute(builder: (_) => HomeScreen());
              case UserListScreen.routeName:
                return MaterialPageRoute(builder: (_) => UserListScreen());
              case UserDetailScreen.routeName:
                return MaterialPageRoute(
                    builder: (_) => UserDetailScreen(arguments));
              case SplashScreen.routeName:
                return MaterialPageRoute(builder: (_) => SplashScreen());
              default:
                return MaterialPageRoute(builder: (_) => LoginScreen());
            }
          },
          onUnknownRoute: (settings) =>
              MaterialPageRoute(builder: (_) => UnknownScreen()),
        ),
      ),
    );
  }

  /// Evaluate if the user is authenticated
  /// then show the user the HomeScreen otherwise
  /// display the LoginScreen to force them to login
  Widget home(AuthProvider auth) {
    return auth.loggedIn
        ? HomeScreen()
        : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : LoginScreen(),
          );
  }

  /// Here we define our theme colors for dark mode
  ThemeData darkTheme() {
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

  /// Here we define our list of providers
  /// for our state management in the app
  List<SingleChildWidget> get providers {
    return [
      ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
      ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
        create: (_) => UserProvider(),
        update: (context, auth, previous) =>
            UserProvider(token: auth.token, users: previous.users),
      )
    ];
  }

  /// All the routes are defined in here
  /// in a switch statement since this will
  /// be able to handle dynamic page requests.
}
