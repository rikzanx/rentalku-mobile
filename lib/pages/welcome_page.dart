import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider _AppProvider = Provider.of<AppProvider>(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _AppProvider.initializeProvider();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo, selamat datang di RentalKu",
                    style: AppStyle.title1Text.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      "Silahkan Masuk",
                      style: AppStyle.regular1Text.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 0,
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      style: AppStyle.regular2Text,
                      children: [
                        TextSpan(
                          text: "Belum punya akun? ",
                          style: AppStyle.regular2Text.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "Daftar",
                          style: AppStyle.regular2Text.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: AppColor.yellow,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, Routes.register);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              "assets/images/splashscreen.png",
              width: MediaQuery.of(context).size.width * 0.85,
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Sewa mobil dengan mudah dan berkualitas bersama kami",
              style: AppStyle.title3Text,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Ink(
                child: TextButton(
                  child: Text("Debug User"),
                  onPressed: () {
                    Provider.of<AppProvider>(context, listen: false).userType = UserType.User;
                    Navigator.pushReplacementNamed(context, Routes.dashboard);
                  },
                ),
              ),
              SizedBox(width: 16),
              TextButton(
                child: Text("Debug Owner"),
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false).userType = UserType.Owner;
                  Navigator.pushReplacementNamed(context, Routes.dashboard);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Spacer(),
        ],
      ),
    );
  }
}
