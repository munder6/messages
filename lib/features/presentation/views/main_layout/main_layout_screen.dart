import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:message_me_app/core/functions/navigator.dart';
import 'package:message_me_app/core/utils/routes/routes_manager.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import 'package:message_me_app/features/presentation/views/settings/settings_screen.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import '../contacts_chat/contacts_chat_page.dart';
import '../select_contact/components/new_group_contact_community_buttons_List.dart';
import '../select_contact/select_contact_screen.dart';
import 'components/sliver_appbar_actions.dart';
import 'components/story_widget.dart';


class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController _tabController;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(changeActions);
    WidgetsBinding.instance.addObserver(this); // to check online and offline mode
  }

  void changeActions() {
    buildMainLayoutSliverAppBarActions(
      context,
      index: _tabController.index,
    );
    setState(() {});
  }

  // to check online and offline mode
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        AuthCubit.get(context).setUserState(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        AuthCubit.get(context).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness keyboardAppearance = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: AppColorss.primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          // actions:  [
          // //const Icon(FluentIcons.camera_24_regular, color: AppColorss.myMessageColor,),
          // const SizedBox(width: 13),
          //   IconButton(
          //       onPressed: () {navigateTo(context, Routes.selectContactRoute);},
          //       icon : const Icon(FluentIcons.tab_add_24_regular,color: AppColorss.myMessageColor)),
          //   const SizedBox(width: 15),
          // ],
          elevation: 0,
          centerTitle: false,
          // title:  Text(
          //   AppStringss.edit,
          //   style:  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Arabic', color: AppColorss.myMessageColor),
          // ),
          backgroundColor: AppColorss.primaryColor,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  SettingsScreen()),
                    );
                },
                  icon : const Icon(FluentIcons.settings_28_regular, color: AppColorss.red,),
              ),
              const SizedBox(width: 140),
              Text(AppStringss.chats, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
              IconButton(
                  // onPressed: () {navigateTo(context, Routes.selectContactRoute);},
                onPressed: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (builder){
                        return new Container(
                          decoration: new BoxDecoration(
                              color: AppColorss.red, //could change this to Color(0xFF737373),

                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          //so you don't have to change MaterialApp canvasColor
                          child: const SelectContactScreen(),
                        );
                      }
                  );
                },
                  icon : const Icon(FluentIcons.tab_add_24_regular,color: AppColorss.red)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11.5, right: 11.5, top: 4),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColorss.thirdColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      keyboardAppearance: keyboardAppearance,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      style:  TextStyle(
                        color: AppColorss.textColor1,
                        fontSize: 15,
                        fontFamily: 'Arabic',
                      ),
                      cursorColor: AppColorss.iconsColors,
                      cursorWidth: 0.6,
                      cursorHeight: 17,
                      decoration:  InputDecoration(
                        prefixIcon: Icon(
                          FluentIcons.search_24_regular,
                          color: AppColorss.textColor3,
                          size: 23,
                        ),
                        hintText: AppStringss.search,
                        hintStyle: TextStyle(
                          color: AppColorss.textColor3.withOpacity(0.2),
                          fontFamily: 'Arabic',
                          fontSize: 16,
                           height: 1.045),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        enabled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          // InkWell(
          //   onTap: () {navigateTo(context, Routes.selectContactRoute);},
          //   child: Container(
          //
          //     decoration: BoxDecoration(
          //         color: AppColorss.thirdColor,
          //       borderRadius: BorderRadius.circular(50)
          //     ),
          //     margin: const EdgeInsets.only(left: 15, right: 15),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         const SizedBox(width: 8),
          //         IconButton(
          //             onPressed: () {navigateTo(context, Routes.selectContactRoute);},
          //             icon : const Icon(FluentIcons.tab_add_24_regular,color: AppColorss.myMessageColor)),
          //         const Text("Add A New Chat", style: TextStyle(fontSize: 16),)
          //
          //       ],
          //     ),
          //   ),
          // ),
          //  Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(AppStringss.broadcast, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: AppColorss.myMessageColor),),
          //       Text(AppStringss.newGroup, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: AppColorss.myMessageColor),)
          //     ],
          //   ),
          // ),
          // Divider(color: AppColorss.textColor1.withOpacity(0.4),height: 0,indent: 0,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 10),
          //   child: Row(
          //     children: [
          //       Icon(FluentIcons.archive_28_filled, color: Colors.grey.shade600, size: 22,),
          //       const SizedBox(width: 20),
          //       Text(AppStringss.archived, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColorss.textColor1),),
          //     ],
          //   ),
          // ),
          // Divider(color: AppColorss.textColor1.withOpacity(0.4),height: 0,indent: 89,),
          // StoryWidget(),
          Expanded(
            child: ContactsChatPage(searchQuery: _searchController.text),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose();
  }
}


