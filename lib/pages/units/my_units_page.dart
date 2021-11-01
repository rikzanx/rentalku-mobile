import 'package:flutter/material.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';

class MyUnitsPage extends StatelessWidget {
  const MyUnitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Galeri UnitKu"),
        titleTextStyle: AppStyle.title3Text.copyWith(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: 5,
        itemBuilder: (context, index) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Toyota Innova Reborn",
              style: AppStyle.smallText.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 3,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Image.network("https://i.imgur.com/vtUhSMq.png"),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.detailUnit);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
