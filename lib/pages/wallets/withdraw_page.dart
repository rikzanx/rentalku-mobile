import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/withdraw_provider.dart';
import 'package:rentalku/widgets/balance_widget.dart';
import 'package:rentalku/widgets/payment_method_option.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WithdrawProvider(),
      child: Scaffold(
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
        body: Builder(
          builder: (context) => Form(
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
                BalanceWidget(
                  balance: 50000,
                  enableAction: false,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                SizedBox(height: 16),
                Consumer<WithdrawProvider>(
                  builder: (context, state, _) => ElevatedButton(
                    onPressed: !state.complete
                        ? null
                        : () {
                            Navigator.pushNamed(context, Routes.detailTopUp);
                          },
                    child: Text("Tarik Dana"),
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
