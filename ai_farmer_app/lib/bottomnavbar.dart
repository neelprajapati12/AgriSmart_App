import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/chat_widget.dart';
import 'package:ai_farmer_app/crop_insights.dart';
import 'package:ai_farmer_app/fertilizers.dart';
import 'package:ai_farmer_app/help.dart';
import 'package:ai_farmer_app/home.dart';
import 'package:ai_farmer_app/tips_tricks_page.dart';
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BootomNavBar extends StatefulWidget {
  const BootomNavBar({super.key});

  @override
  State<BootomNavBar> createState() => _BootomNavBarState();
}

class _BootomNavBarState extends State<BootomNavBar> {
  int _index = 0;
  final List<Widget> _screens = [
    Home_Page(),
    CropInsights_Page(),
    Fertilizers_Page(),
    HelpPage(),
  ];

  final items = <IconData>[
    Icons.home_outlined,
    Icons.agriculture_outlined,
    Icons.bug_report_outlined,
    Icons.help_outline,
  ];

  final List<String> _labels = const [
    'Home',
    'Crop Insights',
    'Fertilizers',
    'Help',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 15,
            child: IndexedStack(
              index: _index,
              children: _screens,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.green,
        child: SizedBox(
          height: 30,
          width: 30,
          child: Image.asset(
            "assets/icons/chatbot.png",
            scale: 0.7,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Chat_Widget()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        borderColor: AppColors.black,
        blurEffect: true,
        activeIndex: _index,
        borderWidth: 0,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 22,
        notchMargin: 10,
        // splashColor: Colors.green,
        // splashRadius: 5,
        shadow: BoxShadow(blurRadius: 4),
        onTap: (index) => setState(() => _index = index),
        itemCount: _labels.length,
        tabBuilder: (index, isActive) {
          final color = isActive ? AppColors.greenn : AppColors.black;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                items[index],
                color: color,
                size: 26,
              ),
              SizedBox(height: 2),
              Text(
                _labels[index],
                style:
                    TextStyle(color: color, fontSize: 13, fontFamily: "popR"),
              ),
              vSize(5),
            ],
          );
        },
      ),
    );
  }
}



 // floatingActionButton: FloatingActionButton(
      //   shape: CircleBorder(),
      //   backgroundColor: AppColors.red,
      //   child: Icon(
      //     Icons.send,
      //     color: AppColors.white,
      //   ),
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => ChatWidget()));
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//   int _index = 0;
//   final List<Widget> _screens = [
//     // const HomePage(),
//     // const EntertainmentPage(),
//     // const ChatScreen(),
//     // const Format2(),
//     // const Format3(),
//   ];
//   final items = <Widget>[
//     const Icon(
//       Icons.home,
//       size: 25,
//     ),
//     const Icon(
//       Icons.card_giftcard,
//       size: 25,
//     ),
//     const Icon(
//       Icons.send,
//       size: 25,
//     ),
//     const Icon(
//       Icons.wallet,
//       size: 25,
//     ),
//     const Icon(
//       Icons.account_circle,
//       size: 25,
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       backgroundColor: AppColors.homePageBg,
//       // backgroundColor: AppColors.white,
//       appBar: AppBar(
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: Icon(
//               Icons.account_circle_rounded,
//               color: Colors.red,
//               size: 35,
//             ),
//           )
//         ],
//         title: const Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: Text(
//             "Evanston Downtown",
//             style: TextStyle(color: Colors.white),
//             // style: TextStyle(color: AppColors.black),
//           ),
//         ),
//         centerTitle: false,
//         backgroundColor: AppColors.homePageBg,
//         // backgroundColor: AppColors.white,
//         leading: const Icon(
//           Icons.location_on,
//           color: Colors.red,
//         ),
//         titleSpacing: -10,
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(
//               bottom: 15,
//               child: IndexedStack(
//                 index: _index,
//                 children: _screens,
//               ))
//         ],
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context)
//             .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
//         child: CurvedNavigationBar(
//           color: const Color(0xFF1C1C1C),
//           buttonBackgroundColor: const Color(0xFFFE3044),
//           backgroundColor: Colors.transparent,
//           items: items,
//           height: 60,
//           index: _index,
//           onTap: (index) {
//             setState(() {
//               _index = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

  // int _index = 0;

  // final List<Widget> _screens = [
  //   const Home_Page(),
  //   // const Coupons(),
  //   // const DecksPage(),
  //   // const ProfilePage(),
  // ];

  // final items = [
  //   "assets/icons/home.png",
  //   "assets/icons/coupons.png",
  //   "assets/icons/deck.png",
  //   "assets/icons/profile.png",
  // ];

  // final filleditems = [
  //   "assets/icons/home_filled.png",
  //   "assets/icons/coupon_filled.png",
  //   "assets/icons/deck_filled.png",
  //   "assets/icons/profile_filled.png",
  // ];

  // // final items = <IconData>[
  // //   Icons.home,
  // //   Icons.card_giftcard,
  // //   Icons.wallet,
  // //   Icons.account_circle_outlined,
  // // ];
  // final List<String> _labels = const [
  //   'Home',
  //   'Coupons',
  //   'Decks',
  //   'Profile',
  // ];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     extendBody: true,
  //     backgroundColor: AppColors.white,
  //     body: Stack(
  //       children: [
  //         Positioned.fill(
  //             bottom: 15,
  //             child: IndexedStack(
  //               index: _index,
  //               children: _screens,
  //             ))
  //       ],
  //     ),
  //     bottomNavigationBar: AnimatedBottomNavigationBar.builder(
  //       borderColor: AppColors.black,
  //       activeIndex: _index,
  //       gapLocation: GapLocation.none,
  //       leftCornerRadius: 12,
  //       rightCornerRadius: 12,
  //       onTap: (index) => setState(() => _index = index),
  //       itemCount: 4,
  //       tabBuilder: (index, isActive) {
  //         final color = isActive ? AppColors.green : AppColors.black;
  //         final iconPath = isActive ? filleditems[index] : items[index];
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Image.asset(
  //               iconPath,
  //               color: color,
  //               height: 26,
  //               width: 26,
  //             ),
  //             const SizedBox(
  //               height: 2,
  //             ), // Adjust the spacing between icon and label as needed
  //             Text(
  //               _labels[index],
  //               style:
  //                   TextStyle(color: color, fontSize: 13, fontFamily: "popR"),
  //             ),
  //             // vSize(5),
  //           ],
  //         );
  //       },
  //       //other params
  //     ),
  //   );
  // }
// }

 // Icon(
              //   items[index],
              //   color: color,
              //   size: 26,
              // ),
              // isActive
              //     ? Image.asset(
              //         filleditems[index],
              //         color: color,
              //         height: 26,
              //         width: 26,
              //       )
              //     :

 