import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/password_provider.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
String password = "";
String password_new = "";

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
        title: Text("Ganti kata sandi"),
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            Consumer<PasswordProvider>(
              builder: (context,state,_) {
                return TextFieldWithShadow(
                  labelText: "Ketik kata sandi sekarang anda",
                  hintText: "kata sandi",
                  obscureText: state.obsecureText,
                  withShowPassword: true,
                  onPressed: (){
                    state.obsecureText = !state.obsecureText;
                    state.notifyListeners();
                  },
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom kata sandi wajib diisi';
                    } else if (value.length < 6) {
                      return 'Panjang kata sandi minimal 6 karakter';
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
                );
              }
            ),
            SizedBox(height: 16),
            Consumer<PasswordProvider>(
              builder: (context,state,_) {
                return TextFieldWithShadow(
                  labelText: "Ketik kata sandi baru anda",
                  hintText: "kata sandi baru",
                  obscureText: state.obsecureText2,
                  withShowPassword: true,
                  onPressed: (){
                    state.obsecureText2 = !state.obsecureText2;
                    state.notifyListeners();
                  },
                  labelColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom kata sandi baru wajib diisi';
                    } else if (value.length < 6) {
                      return 'Panjang kata sandi baru minimal 6 karakter';
                    }
                    return null;
                  },
                  onChanged: (value) => password_new = value,
                );
              }
            ),
            SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // process here
                    showLoaderDialog(context);
                    changePassword(context,password,password_new).then(
                      (value){
                        if(value){
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Sukses ganti kata sandi.");
                        }else{
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Gagal ganti kata sandi.");
                        }
                      },
                    );
                  }
                },
                child: Text("Simpan perubahan"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> changePassword(BuildContext context,String password, String passwordNew) async{
    bool response = await Provider.of<AppProvider>(context,listen: false).changePassword(password,passwordNew);

    return response;
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Proses..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
