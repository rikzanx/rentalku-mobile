import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

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
        title: Text("Ganti password"),
        titleTextStyle: AppStyle.title2Text.copyWith(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWithShadow(
                labelText: "Ketik password anda",
                hintText: "password",
                obscureText: true,
                labelColor: Colors.black,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom password wajib diisi';
                  } else if (value.length < 6) {
                    return 'Panjang password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFieldWithShadow(
                labelText: "Ketik ulang password anda",
                hintText: "password",
                obscureText: true,
                labelColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom password wajib diisi';
                  } else if (value.length < 6) {
                    return 'Panjang password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // process here
                    }
                  },
                  child: Text("Simpan perubahan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
