import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/chat.dart';
import 'package:rentalku/providers/chat_provider.dart';
import 'package:rentalku/widgets/box_chat_widget.dart';
import 'package:rentalku/widgets/empty_chat_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';
// import 'package:flutter_pusher/pusher.dart';

String message = "";
class ViewChatPage extends StatelessWidget {
  const ViewChatPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  //   Future<void> initPusher() async {
  //   try {
  //     await Pusher.init(
  //         "APP_KEY",
  //         PusherOptions(
  //           cluster: "eu",
  //         ),
  //         enableLogging: true);
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  // }
  // initPusher();
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
          builder: (context, state, _) {
            String role ="";
            if(state.chats[state.selectedIndex].penerima.userType == UserType.User){
              role = "Penyewa";
            }else if(state.chats[state.selectedIndex].penerima.userType == UserType.Owner){
              role = "Pemilik";
            }else{
              role = "Sopir";
            }
            return Row(
            children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(assetURL+state.chats[state.selectedIndex].penerima.imageURL),
                  radius: 16,
                ),
                SizedBox(width: 16),
                Text(
                    "${state.chats[state.selectedIndex].penerima.name} - ${role}"),
              ],
            );
          }
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
                  child: ListView(
                    reverse: true,
                    children: List.generate(
                      chats.length,
                      (index) => BoxChatWidget(
                        text: chats[index].text,
                        isSender: chats[index].isSender,
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
                          hintText: "Ketik pesan disini....",
                          labelColor: Colors.black,
                          controller: TextEditingController()..text = message,
                          textInputAction: TextInputAction.send,
                          onChanged: (value){
                            message=value;
                          },
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
                          onPressed: () {
                            print(message);
                            print(state.chats[state.selectedIndex].id);
                            showLoaderDialog(context);
                            state.sendChat(state.chats[state.selectedIndex].id.toString(), message).then(
                              (status){
                                if(status){
                                  Navigator.pop(context);
                                  message = "";
                                  Fluttertoast.showToast(msg: "Pesan terkirim.");
                                }else{
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(msg: "Pesan tidak terkirim.");
                                }
                              }
                            );
                          },
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
  void alertKolom(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Peringatan"),
        content: Container(
          height: MediaQuery.of(context).size.height / 9,
          child: Column(
            children:[
              Text(
                "Pesan  kosong.",
                style: TextStyle(color: Colors.red),
              ),
            ],
          )
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Mengirim pesan..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}
