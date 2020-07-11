import 'package:flutter/material.dart';
import 'package:laradart/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/image_carousel.dart';
import '../widgets/food_name_carousel.dart';
import '../widgets/expense_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    // final brightness = MediaQuery.of(context).platformBrightness;
    // bool darkModeOn = brightness == Brightness.dark;

    return Scaffold(
        drawer: Drawer(
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) => ListTile(
              onTap: () => authProvider.logout(),
              title: Text('Logout'),
            ),
          ),
        ),
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: !darkModeOn ? Colors.grey[50] : null,
        // ),
        // backgroundColor: Colors.white,
        bottomNavigationBar: bottomNavigationBar,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.access_alarm),
                    onPressed: () => print('press'),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_alarm),
                    onPressed: () => print('press'),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_alarm),
                    onPressed: () => print('press'),
                  ),
                  IconButton(
                    icon: Icon(Icons.adjust),
                    onPressed: () => themeProvider.toggleTheme(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [contentHeader('Places'), Text('See all')],
              ),
              SizedBox(
                height: 10,
              ),
              ImageCarousel(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [contentHeader('Foods'), Text('See all')],
              ),
              SizedBox(height: 10),
              FoodNameCarousel(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [contentHeader('Expenses'), Text('See all')],
              ),
              SizedBox(height: 10),
              ExpenseList()
            ],
          ),
          // child: DashboardWidget(
          //     unsplashPhoto: unsplashPhoto, authProvider: authProvider),
        )));
  }

  BottomNavigationBar get bottomNavigationBar {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
      currentIndex: _currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images/1.jpeg')))
      ],
    );
  }

  Text contentHeader(title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1),
    );
  }
}
