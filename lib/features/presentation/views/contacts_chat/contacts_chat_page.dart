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
import '../../components/loader.dart';
import '../../components/my_cached_net_image.dart';
import '../../controllers/chat_cubit/chat_cubit.dart';
import '../../../../../core/extensions/time_extension.dart';

class ContactsChatPage extends StatefulWidget {
  final String searchQuery;

  const ContactsChatPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _ContactsChatPageState createState() => _ContactsChatPageState();
}

class _ContactsChatPageState extends State<ContactsChatPage> {
  List<ContactChat> contactChats = [];

  @override
  void initState() {
    super.initState();
    loadCachedChats(); // Load cached chats when the widget initializes
    // Fetch new chats when the page is opened
    fetchNewChats();
  }

  // Load cached chats from SharedPreferences
  Future<void> loadCachedChats() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedChats = prefs.getStringList('cached_chats') ?? [];

    // Convert cached data to a list of ContactChat objects
    final loadedChats = cachedChats.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return ContactChat.fromJson(json);
    }).toList();

    setState(() {
      contactChats = loadedChats;
    });
  }

  // Save chats to SharedPreferences when you receive new data
  Future<void> saveChatsToCache(List<ContactChat> chats) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedChats = chats.map((chat) => jsonEncode(chat.toJson())).toList();
    await prefs.setStringList('cached_chats', cachedChats);
  }

  // Fetch new chats from the stream and update the list
  void fetchNewChats() async {
    final newChatsStream = ChatCubit.get(context).getContactsChat({});
    newChatsStream.listen((newChats) {
      if (newChats != null) {
        setState(() {
          contactChats = newChats;
          saveChatsToCache(contactChats);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      // appBar: AppBar(
      //   title: Text('Chat'), // Replace with your app title
      // ),
      body: StreamBuilder<List<ContactChat>>(
        stream: ChatCubit.get(context).getContactsChat({}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return the filtered cached chats while loading
            return _buildContactList(contactChats);
          }

          // Filter your contacts based on the search query here
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

  // Helper method to build the contact list
  Widget _buildContactList(List<ContactChat> contacts) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: contacts.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ChatContactCard(
          chatContact: contacts[index],
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
              leading: Hero(
                tag: chatContact.contactId,
                child: InkWell(
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    showContactProfilePicDialog(context, contact: chatContact);
                  },
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
                // Trigger screen refresh
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
