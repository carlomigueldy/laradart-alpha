import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Providers
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

// Widgets
import '../widgets/image_carousel.dart';
import '../widgets/food_name_carousel.dart';
import '../widgets/expense_list.dart';
import '../widgets/smart_widgets/home/dashboard_navigation_button_row.dart';
import '../widgets/smart_widgets/home/home_screen_header.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void initState() {
    super.initState();
    // final AuthProvider authProvider = AuthProvider();

    // authProvider.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // final brightness = MediaQuery.of(context).platformBrightness;
    // bool darkModeOn = brightness == Brightness.dark;
    // authProvider.fetchUser();
    print('home screen rebuilt');
    print(authProvider.token.isNotEmpty ? 'has token' : 'no token');
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
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomNavigationBar,
        body: ScreenTypeLayout.builder(
          desktop: (context) => Center(
            child: Text('Cool'),
          ),
          mobile: (context) => SafeArea(
            child: ListView(
              children: [
                HomeScreenHeader(),
                SizedBox(
                  height: 10,
                ),
                DashboardNavigationButtonRow(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [contentHeader('Places'), Text('See all')],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ImageCarousel(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [contentHeader('Foods'), Text('See all')],
                  ),
                ),
                SizedBox(height: 10),
                FoodNameCarousel(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [contentHeader('Expenses'), Text('See all')],
                  ),
                ),
                SizedBox(height: 10),
                ExpenseList()
              ],
            ),
            // child: DashboardWidget(
            //     unsplashPhoto: unsplashPhoto, authProvider: authProvider),
          ),
        ));
  }

  BottomNavigationBar get bottomNavigationBar {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: SizedBox.shrink(),
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
