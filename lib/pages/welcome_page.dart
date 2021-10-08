import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/welcome_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomeProvider _welcomeProvider = Provider.of<WelcomeProvider>(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _welcomeProvider.initializeProvider();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.fromLTRB(24, 64, 24, 48),
              child: Column(
                children: [
                  Text(
                    "Halo, selamat datang di RentalKu",
                    style: AppStyle.title1Text.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        child: Text(
                          "Masuk",
                          style: AppStyle.regularText.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.login);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Image.asset(
            "assets/images/splashscreen.png",
            width: MediaQuery.of(context).size.width * 0.85,
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "We try to be the best for our customers",
              style: AppStyle.title2Text,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}