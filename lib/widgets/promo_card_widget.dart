import 'package:flutter/material.dart';

class PromoCardWidget extends StatelessWidget {
  final String url;
  final void Function()? onTap;

  const PromoCardWidget({
    Key? key,
    required this.url,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      elevation: 1,
      child: Ink(
        width: 210,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
        child: InkWell(
          onTap: onTap,
        ),
      ),
    );
  }
}
