import 'package:flutter/material.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/article.dart';
import 'package:rentalku/models/unit.dart';

class CarCardWidget extends StatelessWidget {
  final Unit unit;

  const CarCardWidget({
    Key? key,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width /2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(unit.imageURL),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          
        },
      ),
    );
  }
}
