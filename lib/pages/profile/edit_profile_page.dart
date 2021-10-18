import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

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
        title: Text("Edit Data Diri"),
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
                labelText: "Ketik nama lengkap anda",
                hintText: "Nama Lengkap",
                labelColor: Colors.black,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom nama lengkap wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFieldWithShadow(
                labelText: "Ketik alamat anda",
                hintText: "Alamat",
                labelColor: Colors.black,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom alamat wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime(DateTime.now().year - 17),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime(DateTime.now().year - 17),
                  ).then((DateTime? value){
                    debugPrint(value.toString());
                  });
                },
                child: TextFieldWithShadow(
                  labelText: "Ketik tanggal lahir anda",
                  hintText: "Tanggal lahir",
                  keyboardType: TextInputType.datetime,
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom tanggal lahir wajib diisi';
                    }
                    return null;
                  },
                  enabled: false,
                ),
              ),
              SizedBox(height: 16),
              TextFieldWithShadow(
                labelText: "Ketik nomor hp anda",
                hintText: "No. Handphone",
                keyboardType: TextInputType.phone,
                labelColor: Colors.black,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom nomor hp wajib diisi';
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
