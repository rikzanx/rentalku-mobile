import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/pages/routes.dart';
import 'package:rentalku/providers/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider _homeProvider = Provider.of<HomeProvider>(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _homeProvider.initializeProvider();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset("assets/images/splashscreen.png"),
            SizedBox(height: 24),
            Text(
              "We try to be the best for our customers",
              style: GoogleFonts.roboto(
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Text("LOG IN"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.register);
                    },
                    child: Text("REGISTER"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
