import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:url_launcher/url_launcher.dart';

final _formKey = GlobalKey<FormState>();

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Kembali ke halaman awal"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Registrasi", style: AppStyle.heading1Text),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama lengkap", style: AppStyle.labelText),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(hintText: "nama lengkap"),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom nama lengkap wajib diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  Text("Username", style: AppStyle.labelText),
                  SizedBox(height: 4),
                  TextFormField(
                    decoration: InputDecoration(hintText: "username"),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom username wajib diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  Text("Password", style: AppStyle.labelText),
                  SizedBox(height: 4),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom password wajib diisi';
                      } else if (value.length < 6) {
                        return 'Panjang password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 14),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // process here
                        }
                      },
                      child: Text("DAFTAR SEKARANG"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: AppStyle.regularText,
                children: [
                  TextSpan(text: "By signing up, you agree to Photo’s "),
                  TextSpan(
                    text: "Terms of Service",
                    style: AppStyle.regularText.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.blue[900],
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch("http://google.com");
                      },
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: AppStyle.regularText.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.blue[900],
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch("http://google.com");
                      },
                  ),
                  TextSpan(
                    text: ".",
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
