import 'package:collapsible/collapsible.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/top_up_provider.dart';
import 'package:rentalku/widgets/amount_card_widget.dart';
import 'package:rentalku/widgets/payment_method_option.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
  locale: 'id',
  decimalDigits: 0,
  symbol: "Rp. ",
);
final TextEditingController _amountController = TextEditingController();

class TopUpPage extends StatelessWidget {
  const TopUpPage({Key? key}) : super(key: key);

  void setAmount(int amount) {
    String _newValue = _formatter.format(amount.toString());

    _amountController.value = TextEditingValue(
      text: _newValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: _newValue.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TopUpProvider(),
      child: Scaffold(
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Consumer<TopUpProvider>(
                    builder: (context, topUp, _) => TextFieldWithShadow(
                      controller: _amountController,
                      labelText: "Ketik Nominal (Rp)",
                      hintText: "Rp. 0",
                      labelColor: Colors.black,
                      keyboardType: TextInputType.number,
                      inputFormatters: [_formatter],
                      onChanged: (string) {
                        topUp.amount = _formatter.getUnformattedValue().toInt();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom saldo wajib diisi';
                        } else if (_formatter.getUnformattedValue() < 10000) {
                          return 'Top up minimal Rp. 10.000';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 1,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, i) => Consumer<TopUpProvider>(
                    builder: (context, topUp, _) => AmountCardWidget(
                      amount: topUp.selectableAmount.elementAt(i),
                      isSelected:
                          topUp.selectableAmount.elementAt(i) == topUp.amount,
                      onTap: () {
                        if (topUp.selectableAmount.elementAt(i) ==
                            topUp.amount) {
                          topUp.amount = 0;
                          setAmount(0);
                        } else {
                          topUp.amount = topUp.selectableAmount.elementAt(i);
                          setAmount(topUp.selectableAmount.elementAt(i));
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Material(
                    elevation: 3,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(20),
                    child: Consumer<TopUpProvider>(
                      builder: (context, topUp, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              topUp.bankCollapsed = !topUp.bankCollapsed;
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Transfer Bank",
                                    style: AppStyle.regular1Text.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                    topUp.bankCollapsed
                                        ? Icons.expand_more
                                        : Icons.expand_less,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Collapsible(
                            axis: CollapsibleAxis.vertical,
                            collapsed: topUp.bankCollapsed,
                            child: Column(
                              children: List.generate(
                                3,
                                (i) => PaymentMethodOption(
                                  paymentMethod: topUp.selectablePaymentMethod
                                      .elementAt(i),
                                  isSelected: topUp.paymentMethod ==
                                      topUp.selectablePaymentMethod
                                          .elementAt(i),
                                  onTap: () {
                                    topUp.paymentMethod = topUp
                                        .selectablePaymentMethod
                                        .elementAt(i);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Material(
                    elevation: 3,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(20),
                    child: Consumer<TopUpProvider>(
                      builder: (context, topUp, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              topUp.walletCollapsed = !topUp.walletCollapsed;
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "E-Wallet",
                                    style: AppStyle.regular1Text.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Icon(
                                      topUp.walletCollapsed
                                          ? Icons.expand_more
                                          : Icons.expand_less,
                                      size: 20),
                                ],
                              ),
                            ),
                          ),
                          Collapsible(
                            axis: CollapsibleAxis.vertical,
                            collapsed: topUp.walletCollapsed,
                            child: Column(
                              children: List.generate(
                                4,
                                (i) => PaymentMethodOption(
                                  paymentMethod: topUp.selectablePaymentMethod
                                      .elementAt(i + 3),
                                  isSelected: topUp.paymentMethod ==
                                      topUp.selectablePaymentMethod
                                          .elementAt(i + 3),
                                  onTap: () {
                                    topUp.paymentMethod = topUp
                                        .selectablePaymentMethod
                                        .elementAt(i + 3);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
                  width: MediaQuery.of(context).size.width,
                  child: Consumer<TopUpProvider>(
                    builder: (context, topUp, _) => ElevatedButton(
                      onPressed: (topUp.amount >= 10000 &&
                              topUp.paymentMethod != null)
                          ? () {
                              Navigator.pushNamed(context, Routes.detailTopUp);
                            }
                          : null,
                      child: Text("Bayar Sekarang"),
                    ),
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
