import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/transaction.dart';

class TransactionCardWidget extends StatelessWidget {
  final Transaction transaction;
  final void Function()? onTap;

  const TransactionCardWidget({
    Key? key,
    required this.transaction,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Divider(
            height: 2,
            thickness: 1,
            color: AppColor.green,
          ),
          Padding(
            padding: EdgeInsets.all(13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: AppColor.green,
                ),
                SizedBox(width: 13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: AppStyle.regular2Text.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      transaction.description!,
                      style: AppStyle.smallText.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat("d MMM y H:m", "id_ID")
                          .format(transaction.dateTime!),
                      style: AppStyle.smallText.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  (transaction.amount < 0 ? "" : "+") +
                      Helper.toIDR(transaction.amount),
                  style: AppStyle.regular2Text.copyWith(
                    fontWeight: FontWeight.w600,
                    color: transaction.amount < 0
                        ? Colors.red[700]
                        : Colors.green[700],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColor.green,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
