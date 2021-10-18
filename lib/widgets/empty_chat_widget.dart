import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';

class EmptyChatWidget extends StatelessWidget {
  final Future Function() onRefresh;

  const EmptyChatWidget({Key? key, required this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/empty_chat.png",
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
                SizedBox(height: 16),
                Text(
                  "Belum ada obrolan nih",
                  style: AppStyle.regular1Text.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Mulai ngobrol dengan Kawan RentalKu, yuk!",
                  style: AppStyle.regular1Text.copyWith(
                    fontStyle: FontStyle.italic,
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
