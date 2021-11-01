import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/form_unit_provider.dart';
import 'package:rentalku/widgets/filter_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
  locale: 'id',
  decimalDigits: 0,
  symbol: "Rp. ",
);

class AddUnitPage extends StatelessWidget {
  const AddUnitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormUnitProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Tambah Unit Rental"),
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
        body: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                Text(
                  "Isi Data Unit Rental",
                  style: AppStyle.title3Text,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                TextFieldUploadWithShadow(
                  labelText: "Upload Foto Mobil",
                  hintText: "Upload",
                  labelColor: Colors.black,
                  onFileChanged: (File file) {
                    Provider.of<FormUnitProvider>(context, listen: false)
                        .carFile = file;
                  },
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  controller: TextEditingController(
                    text: Provider.of<FormUnitProvider>(context, listen: false)
                        .name,
                  ),
                  labelText: "Nama Unit",
                  hintText: "Honda Jazz",
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom nama unit wajib diisi';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    Provider.of<FormUnitProvider>(context, listen: false).name =
                        value;
                  },
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  labelText: "Harga Sewa (Rp)/Hari",
                  hintText: "Rp. 0",
                  labelColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [_formatter],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom harga sewa wajib diisi';
                    } else if (_formatter.getUnformattedValue() < 10000) {
                      return 'Harga sewa minimal Rp. 10.000';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "Jenis Mobil",
                    style: AppStyle.labelText,
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3,
                    crossAxisCount: 3,
                  ),
                  itemCount: carTypes.length,
                  itemBuilder: (context, index) => Consumer<FormUnitProvider>(
                    builder: (context, state, _) => FilterShadowWidget(
                      label: carTypes[index],
                      selected: carTypes[index] == state.carType,
                      onTap: (status) {
                        state.carType = carTypes[index];
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  labelText: "Transmisi",
                  hintText: "Manual",
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom transmisi wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  labelText: "Mesin",
                  controller: TextEditingController(text: "0"),
                  suffixText: "cc",
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom mesin wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  labelText: "Kapasitas Penumpang",
                  controller: TextEditingController(text: "0"),
                  suffixText: "Penumpang",
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom kapasitas penumpang wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  labelText: "Warna mobil",
                  hintText: "Silver",
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom warna mobil wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFieldWithShadow(
                  labelText: "Tahun mobil",
                  hintText: "2021",
                  labelColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kolom tahun mobil wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "Sopir",
                    style: AppStyle.labelText,
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3,
                    crossAxisCount: 3,
                  ),
                  itemCount: carDriverTypes.length,
                  itemBuilder: (context, index) => Consumer<FormUnitProvider>(
                    builder: (context, state, _) => FilterShadowWidget(
                      label: carDriverTypes.entries.elementAt(index).value,
                      selected: carDriverTypes.entries.elementAt(index).key ==
                          state.carDriverType,
                      onTap: (status) {
                        state.carDriverType =
                            carDriverTypes.entries.elementAt(index).key;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.editUnitComplete);
                      if (_formKey.currentState!.validate()) {
                        // process here
                      }
                    },
                    child: Text("Tambahkan"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
