import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/chat.dart';
import 'package:rentalku/providers/chat_provider.dart';
import 'package:rentalku/widgets/box_chat_widget.dart';
import 'package:rentalku/widgets/empty_chat_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

class ViewChatPage extends StatelessWidget {
  const ViewChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Consumer<ChatProvider>(
          builder: (context, state, _) => Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(state.chats[state.selectedIndex].imageURL),
                radius: 16,
              ),
              SizedBox(width: 16),
              Text(
                  "${state.chats[state.selectedIndex].name} - ${state.chats[state.selectedIndex].role}"),
            ],
          ),
        ),
        titleTextStyle: AppStyle.title3Text.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: Consumer<ChatProvider>(
        builder: (context, state, _) {
          List<ChatMessage> chats = state.chats[state.selectedIndex].list;

          if (chats.isEmpty) {
            return EmptyChatWidget(
              onRefresh: () async {},
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(
                        chats.length,
                        (index) => BoxChatWidget(
                          text: chats[index].text,
                          isSender: chats[index].isSender,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldWithShadow(
                          hintText: "Ketik chat disini....",
                          labelColor: Colors.black,
                          textInputAction: TextInputAction.send,
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        shape: CircleBorder(),
                        color: AppColor.green,
                        elevation: 3,
                        child: IconButton(
                          icon: Icon(Icons.send),
                          color: Colors.white,
                          onPressed: () {},
                          splashRadius: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
