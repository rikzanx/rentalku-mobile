import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';

class BoxChatWidget extends StatelessWidget {
  final String text;
  final bool isSender;

  const BoxChatWidget({
    Key? key,
    required this.isSender,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipPath(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            isSender ? 16 : 40,
            8,
            isSender ? 40 : 16,
            8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSender ? Color(0xFFBFDED9) : Color(0xFFF0F0F0),
          ),
          child: Text(
            text,
            style: AppStyle.smallText,
          ),
        ),
        clipper: isSender ? RightClipChat() : LeftClipChat(),
      ),
    );
  }
}

class LeftClipChat extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(27, size.height);
    path.lineTo(27, 14);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class RightClipChat extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width - 27, 14);
    path.lineTo(size.width - 27, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
