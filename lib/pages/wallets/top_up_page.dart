import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/top_up_provider.dart';
import 'package:rentalku/widgets/amount_card_widget.dart';
import 'package:rentalku/widgets/payment_method_option.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({Key? key}) : super(key: key);

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
        body: Builder(
          builder: (context) => Form(
            key: Provider.of<TopUpProvider>(context, listen: false).formKey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
              children: [
                TextFieldWithShadow(
                  controller: Provider.of<TopUpProvider>(context, listen: false)
                      .amountController,
                  labelText: "Ketik Nominal (Rp)",
                  hintText: "Rp. 0",
                  labelColor: Colors.black,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    Provider.of<TopUpProvider>(context, listen: false).formatter
                  ],
                  onChanged: (string) {
                    Provider.of<TopUpProvider>(context, listen: false)
                        .syncAmount();
                  },
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
                        state.amount = state.selectableAmount.elementAt(i);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Material(
                  elevation: 3,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<TopUpProvider>(context, listen: false)
                              .bankCollapsed = !Provider.of<TopUpProvider>(
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
                              Consumer<TopUpProvider>(
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
                      Consumer<TopUpProvider>(
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
                SizedBox(height: 8),
                Material(
                  elevation: 3,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<TopUpProvider>(context, listen: false)
                              .walletCollapsed = !Provider.of<TopUpProvider>(
                                  context,
                                  listen: false)
                              .walletCollapsed;
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
                              Consumer<TopUpProvider>(
                                builder: (context, state, _) => Icon(
                                  state.walletCollapsed
                                      ? Icons.expand_more
                                      : Icons.expand_less,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<TopUpProvider>(
                        builder: (context, state, _) => Collapsible(
                          axis: CollapsibleAxis.vertical,
                          collapsed: state.walletCollapsed,
                          child: Column(
                            children: List.generate(
                              state.selectableWalletPaymentMethod.length,
                              (i) => PaymentMethodOption(
                                paymentMethod:
                                    state.selectableWalletPaymentMethod[i],
                                isSelected: state.paymentMethod ==
                                    state.selectableWalletPaymentMethod[i],
                                onTap: () {
                                  state.paymentMethod =
                                      state.selectableWalletPaymentMethod[i];
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
