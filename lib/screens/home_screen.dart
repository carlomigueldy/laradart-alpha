import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/image_carousel.dart';
import '../widgets/food_name_carousel.dart';
import '../widgets/expense_list.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

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
        appBar: AppBar(
          centerTitle: true,
        ),
        bottomNavigationBar: bottomNavigationBar,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
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
      onTap: (item) => print(item),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account), title: Text('Users')),
        BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive), title: Text('Cool'))
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
