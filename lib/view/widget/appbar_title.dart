import 'package:flutter/material.dart';
import 'package:studentapp/helpers/app_colors.dart';

class AppBarTitile extends StatelessWidget {
  final String firstName;
  final String secondName;
   AppBarTitile({super.key, required this.firstName,required this.secondName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstName,
          style: TextStyle(
            color: AppColors().primarytheme,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
         secondName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}