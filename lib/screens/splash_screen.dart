import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/service_locator.dart';
import '../providers/auth_provider.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../services/navigation_service.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
