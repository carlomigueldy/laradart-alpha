import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import '../../../providers/auth_provider.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello there,', style: TextStyle(fontSize: 16)),
              Text(authProvider.fullName, style: TextStyle(fontSize: 20))
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ]),
      ),
    );
  }
}
