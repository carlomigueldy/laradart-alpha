import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text('Cool'),
                  subtitle: Text('1 USD'),
                  onTap: () => print('tapped'),
                  trailing: IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () => print('tapped'),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              )),
    );
  }
}
