import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp/controller/bottom_controller.dart';
import 'package:studentapp/controller/home_controller.dart';
import 'package:studentapp/helpers/app_colors.dart';
import 'package:studentapp/view/list_view/home.dart';
import 'package:studentapp/view/home_page/student_lists.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final List<Widget> bottomBarBarPages = [
    const StudentList(),
    UsersList(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottombarControlldata = Provider.of<BottomController>(context);
    Provider.of<Homecontroller>(context,listen: false).fecthDonorDatas();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors().darktheme,
        body: bottomBarBarPages[bottombarControlldata.currentIndex],
        bottomNavigationBar: FloatingNavbar(

            // iconSize: 30,
            // itemBorderRadius: 10,
            selectedBackgroundColor: AppColors().darktheme,
            backgroundColor: Color.fromARGB(255, 27, 27, 27),
            onTap: (int val) {
              bottombarControlldata.changer(val);
            },
            currentIndex: bottombarControlldata.currentIndex,
            elevation: 10,
            selectedItemColor: AppColors().primarytheme,
            unselectedItemColor: AppColors().whitetheme,
            items: [
              FloatingNavbarItem(icon: Icons.school_rounded, title: 'Home'),
              FloatingNavbarItem(
                icon: Icons.people_rounded,
                title: 'Students',
              ),
            ]),
      ),
    );
  }
}
