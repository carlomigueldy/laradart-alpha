import '../screens/place_screen.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> places = [
    'assets/images/1.jpeg',
    'assets/images/2.jpeg',
    'assets/images/3.jpeg',
    'assets/images/4.jpeg',
    'assets/images/5.jpeg',
    'assets/images/6.jpeg',
    'assets/images/7.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(PlaceScreen.routeName, arguments: places[index]),
          child: Container(
            width: 100,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Hero(
              tag: places[index],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  places[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
