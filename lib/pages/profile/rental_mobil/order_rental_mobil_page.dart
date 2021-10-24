import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/rental_mobil.dart';
import 'package:rentalku/providers/order_provider.dart';
import 'package:rentalku/widgets/balance_widget.dart';
import 'package:rentalku/widgets/driver_card_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();

class OrderRentalMobilPage extends StatelessWidget {
  const OrderRentalMobilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RentalMobil rentalMobil = RentalMobil(
      id: 1,
      name: "Toyota Avanza",
      description: "Mini MPV",
      withDriver: true,
      imageURL: 'https://i.imgur.com/vtUhSMq.png',
      price: 280000,
      rating: 4.2,
      capacity: 6,
    );

    return ChangeNotifierProvider<OrderProvider>(
      create: (context) => OrderProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Pemesanan"),
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(rentalMobil.imageURL),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rentalMobil.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: AppStyle.regular1Text.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    rentalMobil.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.regular1Text.copyWith(
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  Consumer<OrderProvider>(
                                    builder: (context, state, _) => Text(
                                      "${state.days} hari",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyle.smallText.copyWith(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(5),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "CAR RENT - Rentalku",
                                  style: AppStyle.smallText.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                    rentalMobil.withDriver
                                        ? "Dengan Sopir"
                                        : "Tanpa Sopir",
                                    style: AppStyle.smallText),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Alamat", style: AppStyle.smallText),
                        Consumer<OrderProvider>(
                          builder: (context, state, _) => InkWell(
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.green,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Text(
                                (state.address == null)
                                    ? "Pilih lokasi"
                                    : state.address!,
                                style: AppStyle.smallText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () async {
                              final Map<String, dynamic> result =
                                  await Navigator.pushNamed(
                                          context, Routes.pickLocation)
                                      as Map<String, dynamic>;

                              state.address = result['name'] as String;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Tanggal", style: AppStyle.smallText),
                        Consumer<OrderProvider>(
                          builder: (context, state, _) => InkWell(
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.green,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Text(
                                state.startDate == null || state.endDate == null
                                    ? "Pilih tanggal"
                                    : "${DateFormat("d MMMM yyyy", "id_ID").format(state.startDate!)} - ${DateFormat("d MMMM yyyy", "id_ID").format(state.endDate!)}",
                                style: AppStyle.smallText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              showDateRangePicker(
                                context: context,
                                currentDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 1),
                                locale: Locale('id', "id_ID"),
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                              ).then((DateTimeRange? dateRange) {
                                if (dateRange != null) {
                                  state.startDate = dateRange.start;
                                  state.endDate = dateRange.end;
                                  state.days;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Sopir", style: AppStyle.smallText),
                        GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          padding: EdgeInsets.all(2),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            3,
                            (index) => Consumer<OrderProvider>(
                              builder: (context, state, _) => DriverCardWidget(
                                selected: state.selectedDriver == index,
                                onTap: () {
                                  state.selectedDriver = index;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Total", style: AppStyle.smallText),
                        Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(5),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Consumer<OrderProvider>(
                                  builder: (context, state, _) => Text(
                                    "${Helper.toIDR(rentalMobil.price)} x ${state.days} Hari",
                                    style: AppStyle.smallText.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Consumer<OrderProvider>(
                                  builder: (context, state, _) => Text(
                                      "Total ${Helper.toIDR(rentalMobil.price * state.days)}",
                                      style: AppStyle.smallText),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(color: AppColor.grey, thickness: 6),
              SizedBox(height: 16),
              Text(
                "Konfirmasi Data Diri Pemesan",
                style: AppStyle.title2Text,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWithShadow(
                        labelText: "Nama lengkap anda",
                        labelColor: Colors.black,
                        hintText: "Nama Lengkap",
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
                        labelText: "Nomor Telepon",
                        labelColor: Colors.black,
                        hintText: "08xxxxxxxxxx",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom nama lengkap wajib diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Nomor Induk Kependudukan",
                        labelColor: Colors.black,
                        hintText: "16 Digit NIK",
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom nama lengkap wajib diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          "Upload KTP",
                          style: AppStyle.labelText,
                        ),
                      ),
                      Material(
                        elevation: 3,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.hardEdge,
                        child: Consumer<OrderProvider>(
                          builder: (context, state, _) => InkWell(
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 24,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Upload",
                                    style: AppStyle.regular1Text.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  if (state.image != null) Spacer(),
                                  if (state.image != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        state.image!,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            onTap: () {
                              myAlert(context, state);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Divider(color: AppColor.grey, thickness: 6),
              Padding(
                padding: EdgeInsets.all(16),
                child: BalanceWidget(
                  balance: 500000,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
              Text("Pembayaran dengan dompetKu", style: AppStyle.smallText),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Remove this

                  if (_formKey.currentState!.validate()) {
                    // process here
                  }
                },
                child: Text("Pesan Sekarang"),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void myAlert(BuildContext context, OrderProvider state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Silahkan pilih media"),
        content: Container(
          height: MediaQuery.of(context).size.height / 6,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  state.getImage(ImageSource.gallery);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 5),
                    Text("Galeri"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  state.getImage(ImageSource.camera);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(width: 5),
                    Text("Kamera"),
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
