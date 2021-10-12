import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
  locale: 'id',
  decimalDigits: 0,
  symbol: "Rp. ",
);

class TopUpPage extends StatelessWidget {
  const TopUpPage({Key? key}) : super(key: key);

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
        title: Text("Top Up Dompetku"),
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
                labelText: "Jumlah saldo",
                hintText: "Rp. 500.000",
                // prefixText: "Rp. ",
                labelColor: Colors.black,
                keyboardType: TextInputType.number,
                inputFormatters: [_formatter],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom saldo wajib diisi';
                  } else if(_formatter.getUnformattedValue() < 10000){
                    return 'Top up minimal Rp. 10.000';
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
