import 'package:flutter/material.dart';
import 'package:rentalku/styles/styles.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Masuk", style: AppStyle.headingText),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        child: Text("MASUK"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
