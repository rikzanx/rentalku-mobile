import 'package:flutter/material.dart';

class DashboardChatPage extends StatelessWidget {
  const DashboardChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            title: Text("Chat"),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            elevation: 2,
          ),
        ],
      ),
    );
  }
}
