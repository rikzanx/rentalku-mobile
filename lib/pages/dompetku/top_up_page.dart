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
                Consumer<TopUpProvider>(
                  builder: (context, state, _) => TextFieldWithShadow(
                    controller: _amountController,
                    labelText: "Ketik Nominal (Rp)",
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
                SizedBox(height: 8),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
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
                    builder: (context, state, _) => AmountCardWidget(
                      amount: state.selectableAmount.elementAt(i),
                      isSelected:
                          state.selectableAmount.elementAt(i) == state.amount,
                      onTap: () {
                        if (state.selectableAmount.elementAt(i) ==
                            state.amount) {
                          state.amount = 0;
                          setAmount(0);
                        } else {
                          state.amount = state.selectableAmount.elementAt(i);
                          setAmount(state.selectableAmount.elementAt(i));
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Material(
                  elevation: 3,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: Consumer<TopUpProvider>(
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
                                  "Transfer Bank",
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
                Material(
                  elevation: 3,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: Consumer<TopUpProvider>(
                    builder: (context, state, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {
                            state.walletCollapsed = !state.walletCollapsed;
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
                                  "E-Wallet",
                                  style: AppStyle.regular1Text.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                    state.walletCollapsed
                                        ? Icons.expand_more
                                        : Icons.expand_less,
                                    size: 20),
                              ],
                            ),
                          ),
                        ),
                        Collapsible(
                          axis: CollapsibleAxis.vertical,
                          collapsed: state.walletCollapsed,
                          child: Column(
                            children: List.generate(
                              4,
                              (i) => PaymentMethodOption(
                                paymentMethod: state.selectablePaymentMethod
                                    .elementAt(i + 3),
                                isSelected: state.paymentMethod ==
                                    state.selectablePaymentMethod
                                        .elementAt(i + 3),
                                onTap: () {
                                  state.paymentMethod = state
                                      .selectablePaymentMethod
                                      .elementAt(i + 3);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Consumer<TopUpProvider>(
                  builder: (context, state, _) => ElevatedButton(
                    onPressed: !state.complete
                        ? null
                        : () {
                            Navigator.pushNamed(context, Routes.detailTopUp);
                          },
                    child: Text("Bayar Sekarang"),
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
