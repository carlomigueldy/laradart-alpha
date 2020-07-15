import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../../providers/theme_provider.dart';

// Screens
import '../../../screens/users/user_list_screen.dart';

class DashboardNavigationButtonRow extends StatelessWidget {
  const DashboardNavigationButtonRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        HomeIconButton(
          message: 'Malls',
          iconButton: IconButton(
            icon: Icon(Icons.store_mall_directory),
            iconSize: 25,
            onPressed: () =>
                Navigator.pushNamed(context, UserListScreen.routeName),
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
