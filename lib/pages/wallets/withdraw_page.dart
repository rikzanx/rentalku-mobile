import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/withdraw_provider.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/widgets/balance_widget.dart';
import 'package:rentalku/widgets/payment_method_option.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WithdrawProvider(),
      builder: (context, _){
        final model = Provider.of<WithdrawProvider>(context,listen: false).getRekenings();
        return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Tarik Dana"),
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
          key: Provider.of<WithdrawProvider>(context, listen: false).formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            children: [
              Text(
                "Tarik saldo dari Dompetku ke",
                style: AppStyle.regular2Text,
              ),
              SizedBox(height: 16),
              Material(
                elevation: 3,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<WithdrawProvider>(context, listen: false)
                            .bankCollapsed = !Provider.of<WithdrawProvider>(
                                context,
                                listen: false)
                            .bankCollapsed;
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transfer Bank",
                              style: AppStyle.regular1Text.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Consumer<WithdrawProvider>(
                              builder: (context, state, _) => Icon(
                                state.bankCollapsed
                                    ? Icons.expand_more
                                    : Icons.expand_less,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Consumer<WithdrawProvider>(
                      builder: (context, state, _) => Collapsible(
                        axis: CollapsibleAxis.vertical,
                        collapsed: state.bankCollapsed,
                        child: Column(
                          children: List.generate(
                            state.selectableBankPaymentMethod.length,
                            (i) => PaymentMethodOption(
                              paymentMethod:
                                  state.selectableBankPaymentMethod[i],
                              isSelected: state.paymentMethod ==
                                  state.selectableBankPaymentMethod[i],
                              onTap: () {
                                state.paymentMethod =
                                    state.selectableBankPaymentMethod[i];
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextFieldWithShadow(
                controller:
                    Provider.of<WithdrawProvider>(context, listen: false)
                        .accountNumberController,
                labelText: "Masukkan No. Rekening",
                hintText: "Nomor Rekening",
                labelColor: Colors.black,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  Provider.of<WithdrawProvider>(context, listen: false)
                      .accountNumber = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom nomor rekening wajib diisi';
                  }
                  return null;
                },
              ),
              TextFieldWithShadow(
                controller:
                    Provider.of<WithdrawProvider>(context, listen: false)
                        .accountNameController,
                labelText: "Masukkan Nama Rekening",
                hintText: "Nama Rekening",
                labelColor: Colors.black,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  Provider.of<WithdrawProvider>(context, listen: false)
                      .accountName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kolom nomor rekening wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFieldWithShadow(
                controller:
                    Provider.of<WithdrawProvider>(context, listen: false)
                        .amountController,
                labelText: "Ketik Nominal (Rp)",
                hintText: "Rp. 0",
                labelColor: Colors.black,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  Provider.of<WithdrawProvider>(context, listen: false)
                      .formatter
                ],
                onChanged: (value) {
                  Provider.of<WithdrawProvider>(context, listen: false)
                      .syncAmount();
                },
              ),
              SizedBox(height: 16),
              Consumer<AppProvider>(
                builder: (context,state,_) {
                  if(state.homeState == HomeState.Loading){
                    return Center(
                      child: CircularProgressIndicator(color: AppColor.green),
                    );
                  }
                  if(state.homeState == HomeState.Error){
                    return Center(child: Text(defaultErrorText),);
                  }
                  return BalanceWidget(
                    balance: state.dompet!.saldo,
                    enableAction: false,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  );
                }
              ),
              SizedBox(height: 16),
              Consumer<AppProvider>(
                builder: (context,app,_) {
                  return Consumer<WithdrawProvider>(
                    builder: (context, state, _) => ElevatedButton(
                      onPressed: !state.complete
                          ?(){
                            alertKolom(context);
                          }
                          : () {
                              if(app.dompet!.saldo >= state.amount){
                                showLoaderDialog(context);
                                makeWithDraw(context, state.amount, state.paymentMethod!.shortName, state.accountNumber, state.accountName)
                                .then((value){
                                    if(value.status){
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: "Sukses Tarik Dana.");
                                      Navigator.pushNamed(context, Routes.withdrawComplete);
                                    }else{
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: "Gagal Tarik Dana.");
                                    }
                                  }
                                );
                              }else{
                                alertSaldo(context);
                              }
                            },
                      child: Text("Tarik Dana"),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      );
      }
    );
  }

  Future<ApiResponse> makeWithDraw(BuildContext context, int jumlah, String bank,String accountNumber,String accountName) async{
    ApiResponse response = await Provider.of<WithdrawProvider>(context,listen: false).makeWithDraw(jumlah,bank,accountNumber,accountName);

    return response;
  }

  void alertKolom(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Peringatan"),
        content: Container(
          height: MediaQuery.of(context).size.height / 9,
          child: Column(
            children:[
              Text(
                "Kolom isian belum lengkap.",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Isi semua kolom!",
                style: TextStyle(color: Colors.red),
              ),
            ],
          )
        ),
      ),
    );
  }

  void alertSaldo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Peringatan"),
        content: Container(
          height: MediaQuery.of(context).size.height / 9,
          child: Column(
            children:[
              Text(
                "Saldo tidak cukup.",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Silahkan Top Up terlebih dahulu!",
                style: TextStyle(color: Colors.red),
              ),
            ],
          )
        ),
      ),
    );
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
