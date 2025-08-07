import 'package:auranix_ai/theme/colors.dart';
import 'package:flutter/material.dart';

class SideBarButoon extends StatelessWidget {

  final bool isCollapse;
  final IconData icon;
  final String text;
  
  const SideBarButoon({
    super.key, 
    required this.isCollapse, 
    required this.icon, 
    required this.text});

  @override
  Widget build(BuildContext context) {
    return  Row(
            mainAxisAlignment: isCollapse? MainAxisAlignment.center:MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                child: Icon(
                icon,
                color: AppColors.iconGrey,
                size: 25
                ),
              ),
              isCollapse? const SizedBox():
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textGrey
                ),
              )
            ],
          );
  }
}