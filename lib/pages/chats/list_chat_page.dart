import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/chat_provider.dart';
import 'package:rentalku/widgets/empty_chat_widget.dart';

class ListChatPage extends StatelessWidget {
  const ListChatPage({Key? key}) : super(key: key);

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
        title: Text("Obrolan"),
        titleTextStyle: AppStyle.title2Text.copyWith(color: Colors.white),
        centerTitle: true,
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
          if (state.chats.isEmpty) {
            return EmptyChatWidget(
              onRefresh: () async {},
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    state.selectedIndex = index;
                    Navigator.pushNamed(context, Routes.viewChat);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(state.chats[index].imageURL),
                          radius: 24,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.chats[index].name} - ${state.chats[index].role}",
                                style: AppStyle.regular2Text.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                state.chats[index].list.last.text,
                                style: AppStyle.regular2Text.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(height: 1),
                itemCount: state.chats.length,
              ),
            );
          }
        },
      ),
    );
  }
}
