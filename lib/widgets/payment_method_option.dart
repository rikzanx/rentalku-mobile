import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/payment_method.dart';

class PaymentMethodOption extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final void Function()? onTap;

  const PaymentMethodOption({
    Key? key,
    required this.paymentMethod,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColor.green.withOpacity(0.25) : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: AppColor.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  isSelected
                      ? Icon(Icons.radio_button_on,
                          size: 12, color: AppColor.green)
                      : Icon(Icons.radio_button_off, size: 12),
                  SizedBox(width: 8),
                  Text(paymentMethod.name, style: AppStyle.smallText),
                  Spacer(),
                  Image.network(
                    assetURL+paymentMethod.imageURL,
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
