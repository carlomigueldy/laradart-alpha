import 'package:flutter/material.dart';
import 'package:laradart/app/service_locator.dart';
import 'package:laradart/providers/auth_provider.dart';
import 'package:laradart/screens/home_screen.dart';
import 'package:laradart/screens/login_screen.dart';
import 'package:laradart/services/navigation_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final AuthProvider authProvider = AuthProvider();

    authProvider.tryAutoLogin().then((bool value) {
      if (value) {
        locator<NavigationService>().navigateTo(HomeScreen.routeName);
      } else {
        locator<NavigationService>().navigateTo(LoginScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
