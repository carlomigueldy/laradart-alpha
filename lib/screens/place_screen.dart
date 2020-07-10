import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  static const routeName = '/place-screen';
  final arguments;

  PlaceScreen(this.arguments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Hero(
                      tag: arguments,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          child: Image.asset(
                            arguments,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  child: Text('Go back'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            ],
          ),
        ));
  }
}
