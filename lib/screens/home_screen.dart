import 'package:daycare_flutter/screens/splash_screen.dart';

import '../providers/auth_provider.dart';
import '../screens/users_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String unsplashPhoto =
        'https://images.unsplash.com/photo-1594046243098-0fceea9d451e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80';

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
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (item) => print(item),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account), title: Text('Users')),
            BottomNavigationBarItem(
                icon: Icon(Icons.all_inclusive), title: Text('Cool'))
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: DashboardWidget(
              unsplashPhoto: unsplashPhoto, authProvider: authProvider),
        )));
  }
}

class DashboardWidget extends StatelessWidget {
  const DashboardWidget(
      {Key key, @required this.unsplashPhoto, @required this.authProvider})
      : super(key: key);

  final String unsplashPhoto;
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Your favorites',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 10.0,
        ),
        sideScrollingList(),
        SizedBox(
          height: 10.0,
        ),
        UserButton(authProvider: authProvider),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 50,
          child: RaisedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SplashScreen.routeName),
            child: Text('To Splash'),
          ),
        )
      ],
    );
  }

  Expanded sideScrollingList() {
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 15,
      itemBuilder: (context, index) => GestureDetector(
        onDoubleTap: () => print('you double tapped me'),
        onLongPress: () => print('you long pressed me'),
        onTap: () => print('you tapped me'),
        onPanDown: (event) => print('you pan down me $event'),
        child: Container(
          height: 100,
          child: Card(
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                        unsplashPhoto,
                        height: 300,
                        width: 200,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class UserButton extends StatelessWidget {
  const UserButton({
    Key key,
    @required this.authProvider,
  }) : super(key: key);

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(UserListScreen.routeName),
        child: Text('To Users'),
      ),
    );
  }
}
