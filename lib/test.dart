// import 'package:flutter/material.dart';
// import 'package:focused_menu_custom/focused_menu.dart';
// import 'package:focused_menu_custom/modals.dart';
//
// class Test extends StatelessWidget {
//   const Test({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:
//       Expanded(
//         child: GridView(
//           physics: BouncingScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
//
//           // Wrap each item (Card) with Focused Menu Holder
//               .map((e) => FocusedMenuHolder(
//             menuWidth: MediaQuery.of(context).size.width*0.50,
//             blurSize: 5.0,
//             menuItemExtent: 45,
//             menuBoxDecoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(15.0))),
//             duration: Duration(milliseconds: 100),
//             animateMenuItems: true,
//             blurBackgroundColor: Colors.black54,
//             openWithTap: true, // Open Focused-Menu on Tap rather than Long Press
//             menuOffset: 10.0, // Offset value to show menuItem from the selected item
//             bottomOffsetHeight: 80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
//             menuItems: <FocusedMenuItem>[
//               // Add Each FocusedMenuItem  for Menu Options
//               // FocusedMenuItem(title: Text("Open"),trailingIcon: Icon(Icons.open_in_new) ,onPressed: (){
//               //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
//               // }),
//               FocusedMenuItem(title: Text("Share"),trailingIcon: Icon(Icons.share) ,onPressed: (){}),
//               FocusedMenuItem(title: Text("Favorite"),trailingIcon: Icon(Icons.favorite_border) ,onPressed: (){}),
//               FocusedMenuItem(title: Text("Delete",style: TextStyle(color: Colors.redAccent),),trailingIcon: Icon(Icons.delete,color: Colors.redAccent,) ,onPressed: (){}),
//             ],
//             onPressed: (){},
//             child: Card(
//               child: Column(
//                 children: <Widget>[
//                   Image.asset("assets/images/image_$e.jpg"),
//                 ],
//               ),
//             ),
//           ))
//               .toList(),
//         ),
//       ),
//       // Scaffold(
//       //   appBar: AppBar(
//       //     title: Text('Focused Menu Example'),
//       //   ),
//       //   body: Center(
//       //     child: Column(
//       //       children: [
//       //         FocusedMenuHolder(
//       //           menuWidth: MediaQuery.of(context).size.width * 0.5,
//       //           onPressed: () {},
//       //           menuItems: <FocusedMenuItem>[
//       //             FocusedMenuItem(
//       //               title: Text('Item 1'),
//       //               onPressed: () {
//       //                 // Handle item 1 action
//       //               },
//       //             ),
//       //             FocusedMenuItem(
//       //               title: Text('Item 2'),
//       //               onPressed: () {
//       //                 // Handle item 2 action
//       //               },
//       //             ),
//       //             // Add more items as needed
//       //           ],
//       //           child: Card(
//       //             elevation: 4,
//       //             child: Container(
//       //               width: 200,
//       //               height: 200,
//       //               alignment: Alignment.center,
//       //               child: Text('Long Press Me'),
//       //             ),
//       //           ),
//       //         ),
//       //         // Add other widgets here if needed
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }





//  widget.message.isLiked ?
//  Positioned(
//    bottom: 0,
//    left: 0, // Align to the left edge
//    child: Container(
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(50),
//          color: AppColorss.primaryColor
//      ),
//      padding: const EdgeInsets.all(2),
//      child: Container(
//          width: 25,
//          padding: const EdgeInsets.all(3),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(50),
//              color: AppColorss.senderMessageColor
//          ),
//          child: InkWell(
//              focusColor: Colors.transparent,
//              splashColor: Colors.transparent,
//              highlightColor: Colors.transparent,
//              hoverColor: Colors.transparent,
//              onTap: ()async{
//                final firestore = FirebaseFirestore.instance;
//                final userId = widget.message.senderId;
//                final chatId = widget.message.receiverId;
//                await firestore
//                    .collection('users')
//                    .doc(userId)
//                    .collection('chats')
//                    .doc(chatId)
//                    .collection('messages')
//                    .doc(widget.message.messageId)
//                    .update({
//                  'isLiked': false,
//                });
//                final userId2 = widget.message.receiverId;
//                final chatId2 = widget.message.senderId;
//                await firestore
//                    .collection('users')
//                    .doc(userId2)
//                    .collection('chats')
//                    .doc(chatId2)
//                    .collection('messages')
//                    .doc(widget.message.messageId)
//                    .update({
//                  'isLiked': false,
//                });
//              },
//              child: const Icon(FluentIcons.heart_24_filled, size: 15,color: Colors.red,))),
//    ),
//  ) : const SizedBox(),
// if (widget.message.isLiked)
//  const SizedBox(height: 55,)





// widget.message.isLiked ?
// Positioned(
//   bottom: 0,
//   right: 0, // Align to the left edge
//   child: Container(
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         color: AppColorss.primaryColor
//     ),
//     padding: const EdgeInsets.all(2),
//     child: Container(
//         width: 25,
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(50),
//             color: AppColorss.senderMessageColor
//         ),
//         child: InkWell(
//             focusColor: Colors.transparent,
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             onTap: ()async{
//               final firestore = FirebaseFirestore.instance;
//               final userId = widget.message.senderId;
//               final chatId = widget.message.receiverId;
//               await firestore
//                   .collection('users')
//                   .doc(userId)
//                   .collection('chats')
//                   .doc(chatId)
//                   .collection('messages')
//                   .doc(widget.message.messageId)
//                   .update({
//                 'isLiked': false,
//               });
//               final userId2 = widget.message.receiverId;
//               final chatId2 = widget.message.senderId;
//               await firestore
//                   .collection('users')
//                   .doc(userId2)
//                   .collection('chats')
//                   .doc(chatId2)
//                   .collection('messages')
//                   .doc(widget.message.messageId)
//                   .update({
//                 'isLiked': false,
//               });
//             },
//             child: const Icon(FluentIcons.heart_24_filled, size: 15,color: Colors.red,))),
//   ),
// ) : const SizedBox(),
// if (widget.message.isLiked)
//   const SizedBox(height: 55,)
