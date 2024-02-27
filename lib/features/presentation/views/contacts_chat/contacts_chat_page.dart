import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:message_me_app/core/functions/navigator.dart';
import 'package:message_me_app/core/utils/constants/strings_manager.dart';
import 'package:message_me_app/core/utils/routes/routes_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/thems/my_colors.dart';
import '../../../domain/entities/contact_chat.dart';
import '../../components/contact_profile_pic_dialog.dart';
import '../../components/custom_list_tile.dart';
import '../../components/my_cached_net_image.dart';
import '../../controllers/chat_cubit/chat_cubit.dart';
import '../../../../../core/extensions/time_extension.dart';

class ContactsChatPage extends StatefulWidget {
  final String searchQuery;

  const  ContactsChatPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _ContactsChatPageState createState() => _ContactsChatPageState();
}

class _ContactsChatPageState extends State<ContactsChatPage> {
  List<ContactChat> contactChats = [];

  @override
  void initState() {
    super.initState();
    loadCachedChats();
    fetchNewChats();
  }

  // Load cached chats from SharedPreferences
  Future<void> loadCachedChats() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedChats = prefs.getStringList('cached_chats') ?? [];
    final loadedChats = cachedChats.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return ContactChat.fromJson(json);
    }).toList();

    setState(() {
      contactChats = loadedChats;
    });
  }

  Future<void> saveChatsToCache(List<ContactChat> chats) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedChats = chats.map((chat) => jsonEncode(chat.toJson())).toList();
    await prefs.setStringList('cached_chats', cachedChats);
  }

  void fetchNewChats() async {
    final newChatsStream = ChatCubit.get(context).getContactsChat({});
    newChatsStream.listen((newChats) {
      setState(() {
        contactChats = newChats;
        saveChatsToCache(contactChats);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      body: StreamBuilder<List<ContactChat>>(
        stream: ChatCubit.get(context).getContactsChat({}),
        builder: (context, snapshot) {
          final List<ContactChat> filteredNewContactChats = contactChats.where((chat) {
            final name = chat.name.toLowerCase();
            final query = widget.searchQuery.toLowerCase();
            return name.contains(query);
          }).toList();
          return _buildContactList(filteredNewContactChats);
        },
      ),
    );
  }

  Widget _buildContactList(List<ContactChat> contacts) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: contacts.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            ChatContactCard(
              chatContact: contacts[index],
            ),
           // // Divider(indent: 88, height: 0.1,color: AppColorss.dividersColor.withOpacity(0.5),),
           //  ChatContactCard(
           //    chatContact: contacts[index],
           //  ),
           // // Divider(indent: 88, height: 0.1,color: AppColorss.dividersColor.withOpacity(0.5),),
           //  ChatContactCard(
           //    chatContact: contacts[index],
           //  ),
           // // Divider(indent: 88, height: 0.1,color: AppColorss.dividersColor.withOpacity(0.5),),
           //  ChatContactCard(
           //    chatContact: contacts[index],
           //  ),
           // // Divider(indent: 88, height: 0.1,color: AppColorss.dividersColor.withOpacity(0.5),),
          ],
        );
      },
    );
  }
}

class ChatContactCard extends StatelessWidget {
  final ContactChat chatContact;

  const ChatContactCard({
    Key? key,
    required this.chatContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: ChatCubit.get(context).numOfMessageNotSeen(chatContact.contactId),
        builder: (context, snapshot) {
          return Dismissible(
            key: Key(chatContact.contactId),
            background: Container(
              height: 60,
              color: Colors.red,
              child: const Icon(Icons.delete_outline, color: Colors.white, size: 30,),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                showDeleteConversationDialog(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: CustomListTile(
                title: chatContact.name,
                onTap: () {
                  navigateTo(context, Routes.chatRoute, arguments: {
                    'name': chatContact.name,
                    'uId': chatContact.contactId,
                  });
                },
                subTitle: chatContact.lastMessage,
                time: chatContact.timeSent.chatContactTime,
                numOfMessageNotSeen: snapshot.data ?? 0, // Replace with the actual count of unseen messages
                //numOfMessageNotSeen: 99, // Replace with the actual count of unseen messages
                leading: Hero(
                  tag: chatContact.contactId,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    // onTap: () {
                    //   showContactProfilePicDialog(context, contact: chatContact);
                    // },
                    child: MyCachedNetImage(
                      imageUrl: chatContact.profilePic,
                      radius: 25,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  void showDeleteConversationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: AppColorss.thirdColor,
          title:  Text(AppStringss.deleteConversation, style: const TextStyle(color: Colors.red),),
          content: Text(AppStringss.confirmDeleteConversation, style: TextStyle(color: AppColorss.textColor1),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text(AppStringss.no, style: TextStyle(color: AppColorss.textColor1),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ChatCubit.get(context).deleteConversation(chatContact.contactId);
                Fluttertoast.showToast(
                  msg: AppStringss.doneDelete,
                  textColor: AppColorss.textColor1,
                  backgroundColor: AppColorss.secondaryColor,
                  gravity: ToastGravity.CENTER,
                );

              },
              child:  Text(AppStringss.delete, style: const TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }
}