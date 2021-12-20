import 'package:flutter/material.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/article.dart';

class ArticleCardWidget extends StatelessWidget {
  final Article article;

  const ArticleCardWidget({
    Key? key,
    required this.article,
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
              height: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(article.imageURL),
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
