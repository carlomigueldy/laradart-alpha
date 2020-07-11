import '../screens/user_detail_screen.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class FoodNameCarousel extends StatelessWidget {
  final faker = Faker();
  final List<Color> colors = [
    Colors.indigo,
    Colors.blue,
    Colors.deepOrange,
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    UserDetailScreen.routeName,
                    arguments: faker.food.dish()),
                child: Container(
                  width: 150,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          color: getColor(index),
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(faker.food.dish()))))),
                ),
              )),
    );
  }

  Color getColor(index) {
    return colors[index];
  }
}
