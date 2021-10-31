import 'package:collapsible/collapsible.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/withdraw_provider.dart';
import 'package:rentalku/widgets/balance_widget.dart';
import 'package:rentalku/widgets/payment_method_option.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
  locale: 'id',
  decimalDigits: 0,
  symbol: "Rp. ",
);
final TextEditingController _amountController = TextEditingController();
final TextEditingController _accountNumberController = TextEditingController();

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({Key? key}) : super(key: key);

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
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  child: Consumer<WithdrawProvider>(
                    builder: (context, state, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {
                            state.bankCollapsed = !state.bankCollapsed;
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
                                  "Pilih Bank",
                                  style: AppStyle.regular1Text.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  state.bankCollapsed
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
                          collapsed: state.bankCollapsed,
                          child: Column(
                            children: List.generate(
                              3,
                              (i) => PaymentMethodOption(
                                paymentMethod:
                                    state.selectablePaymentMethod.elementAt(i),
                                isSelected: state.paymentMethod ==
                                    state.selectablePaymentMethod.elementAt(i),
                                onTap: () {
                                  state.paymentMethod = state
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
                SizedBox(height: 16),
                Consumer<WithdrawProvider>(
                  builder: (context, state, _) => TextFieldWithShadow(
                    controller: _accountNumberController,
                    labelText: "Masukkan No. Rekening",
                    hintText: "Nomor Rekening",
                    labelColor: Colors.black,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (string) {
                      state.accountNumber = string;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom nomor rekening wajib diisi';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Consumer<WithdrawProvider>(
                  builder: (context, state, _) => TextFieldWithShadow(
                    controller: _amountController,
                    labelText: "Jumlah Penarikan Dana (Rp)",
                    hintText: "Rp. 0",
                    labelColor: Colors.black,
                    keyboardType: TextInputType.number,
                    inputFormatters: [_formatter],
                    onChanged: (string) {
                      state.amount = _formatter.getUnformattedValue().toInt();
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
                            Navigator.pushNamed(context, Routes.withdrawComplete);
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
