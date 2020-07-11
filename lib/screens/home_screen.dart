import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  HomeIconButton(
                    message: 'Malls',
                    iconButton: IconButton(
                      icon: Icon(Icons.store_mall_directory),
                      iconSize: 25,
                      onPressed: () => print('press'),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  HomeIconButton(
                    message: 'Events',
                    iconButton: IconButton(
                      icon: Icon(Icons.calendar_today),
                      iconSize: 25,
                      onPressed: () => print('press'),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  HomeIconButton(
                    message: 'Flights',
                    iconButton: IconButton(
                      icon: Icon(Icons.airplanemode_active),
                      iconSize: 25,
                      onPressed: () => print('press'),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  HomeIconButton(
                    message: themeProvider.isLight
                        ? 'Switch to dark theme'
                        : 'Switch to light theme',
                    iconButton: IconButton(
                      icon: Icon(themeProvider.isLight
                          ? Icons.brightness_3
                          : Icons.brightness_high),
                      iconSize: 25,
                      onPressed: () => themeProvider.toggleTheme(),
                      color: Theme.of(context).primaryColor,
                    ),
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

class HomeIconButton extends StatelessWidget {
  final IconButton iconButton;
  final String message;

  const HomeIconButton(
      {Key key, @required this.iconButton, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(25)),
        child: iconButton,
      ),
    );
  }
}
