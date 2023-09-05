import 'package:flutter/material.dart';

import '../../../../../core/shared/pop_up_menu_item_model.dart';

class CustomPopUpMenuButton extends StatelessWidget {
  final List<PopUpMenuItemModel> buttons;
  const CustomPopUpMenuButton({
  super.key, required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: const Color.fromRGBO(53, 70, 79, 1.0),
      icon: const Icon(Icons.more_vert, color: Colors.white,),
      onSelected: (value){
        buttons[value].onTap();
      },
      itemBuilder: (context) {
        return buttons.map((e) {
          int index = buttons.indexOf(e);
          return PopupMenuItem(
            value: index,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(e.name, style: const TextStyle(color: Colors.white),),
            ),
          );
        }).toList();
      },
    );
  }
}
