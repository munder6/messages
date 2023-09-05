import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:message_me_app/core/functions/navigator.dart';
import 'package:message_me_app/core/utils/routes/routes_manager.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import '../contacts_chat/contacts_chat_page.dart';
import 'components/sliver_appbar_actions.dart';


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
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          actions:  [
          const Icon(FluentIcons.camera_24_regular, color: AppColorss.myMessageColor,),
          const SizedBox(width: 13),
            IconButton(
                onPressed: () {navigateTo(context, Routes.selectContactRoute);},
                icon : const Icon(FluentIcons.tab_add_24_regular,color: AppColorss.myMessageColor)),
            const SizedBox(width: 15),
          ],
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Edit",
            style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Arabic', color: AppColorss.myMessageColor),
          ),
          backgroundColor: AppColorss.primaryColor,
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     navigateTo(context, Routes.selectContactRoute);
      //   },
      //   icon: const Icon(FluentIcons.person_add_28_regular, color: Colors.white,),
      //   label: const Text('Add', style: TextStyle(fontFamily: 'Arabic', color: Colors.white),),
      //   backgroundColor: AppColorss.myMessageColor,
      // ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              SizedBox(width: 15),
              Text("Chats", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11.5, right: 11.5, top: 8),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: AppColorss.thirdColor,
                borderRadius: BorderRadius.circular(8),
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
                      decoration:  InputDecoration(
                        prefixIcon: Icon(
                          FluentIcons.search_24_regular,
                          color: AppColorss.textColor3,
                          size: 23,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: AppColorss.textColor3,
                          fontFamily: 'Arabic',
                          fontSize: 17,
                           height: 1.029                     ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        enabled: true,
                      ),
                    ),
                  ),
                  const Icon(FluentIcons.filter_24_regular, color: AppColorss.myMessageColor,),
                  const SizedBox(width: 10,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Broadcast Lists", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: AppColorss.myMessageColor),),
                Text("New Group", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: AppColorss.myMessageColor),)
              ],
            ),
          ),
          Divider(color: AppColorss.textColor1.withOpacity(0.4),height: 0,indent: 0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 10),
            child: Row(
              children: [
                Icon(FluentIcons.archive_28_filled, color: Colors.grey.shade600, size: 22,),
                const SizedBox(width: 20),
                Text("Archived", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColorss.textColor1),),
              ],
            ),
          ),
          Divider(color: AppColorss.textColor1.withOpacity(0.4),height: 0,indent: 89,),
         //  StoryWidget(),
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


