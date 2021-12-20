import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/transaction.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/widgets/transaction_card_widget.dart';

class DompetkuPage extends StatelessWidget {
  const DompetkuPage({Key? key}) : super(key: key);

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
        title: Text("Dompetku"),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppColor.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jumlah Saldo",
                          style: AppStyle.title3Text.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0,0,0),
                          child: Container(
                          child: Consumer<AppProvider>(
                            builder: (context,state,_){
                              if(state.homeState == HomeState.Loading){
                                return Center(
                                  child: CircularProgressIndicator(color: AppColor.green),
                                );
                              }
                              if(state.homeState == HomeState.Error){
                                return Center(child: Text(defaultErrorText),);
                              }

                              return Text(
                                Helper.toIDR(state.dompet!.saldo),
                                style: AppStyle.regular1Text.copyWith(
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          ),
                        ),
                        
                      ],
                    ),
                    Consumer<AppProvider>(
                      builder: (context, state, _) => ElevatedButton(
                        child: Text(state.isUser ? "Top Up" : "Tarik"),
                        onPressed: () {
                          if (state.isUser)
                            Navigator.pushNamed(context, Routes.topUp);
                          else
                            Navigator.pushNamed(context, Routes.withdraw);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          primary: Colors.white,
                          onPrimary: AppColor.green,
                          padding: EdgeInsets.all(0),
                          visualDensity: VisualDensity.compact,
                          textStyle: AppStyle.regular1Text.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  "Transaksi Terakhir",
                  style: AppStyle.title3Text.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Consumer<AppProvider>(
                builder: (context, state,_){
                  return Column(
                      children: List.generate(
                      state.transactionList!.length,
                      (index) => TransactionCardWidget(
                        transaction: Transaction(
                          id: state.transactionList![index].id,
                          title: state.transactionList![index].title,
                          description: (state.transactionList![index].description.toString() == 'null')?'':state.transactionList![index].description.toString(),
                          dateTime: state.transactionList![index].dateTime,
                          amount: state.transactionList![index].amount,
                        ),
                      ),
                    ),
                    );
                }
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
