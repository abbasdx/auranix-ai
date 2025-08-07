import 'package:auranix_ai/theme/colors.dart';
import 'package:auranix_ai/widgets/side_bar_button.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapse = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 100),
      width: isCollapse ? 64 :148,
      color: AppColors.sideNav,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Icon(
            Icons.auto_awesome_mosaic,
            color: AppColors.whiteColor,
            size: isCollapse ?30: 60
            ),
          ),
          Expanded(
            child: Column(
              
              crossAxisAlignment: isCollapse? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                
                SideBarButoon(isCollapse: isCollapse, icon: Icons.add, text: "Home"),
            
                SideBarButoon(isCollapse: isCollapse, icon: Icons.search, text: "Search"),
            
                SideBarButoon(isCollapse: isCollapse, icon: Icons.language, text: "Spaces"),
            
                SideBarButoon(isCollapse: isCollapse, icon: Icons.auto_awesome, text: "Discover"),
            
                SideBarButoon(isCollapse: isCollapse, icon: Icons.cloud_outlined, text: "Library"),
            
              const Spacer(),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      isCollapse = !isCollapse;
                    });
                  },
                  child: AnimatedContainer( 
                    alignment: isCollapse? Alignment.center: Alignment.bottomRight,
                    duration: Duration(microseconds: 100),
                    margin: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                    child: Icon(
                      isCollapse ? Icons.keyboard_arrow_right: Icons.keyboard_arrow_left,
                  
                  color: AppColors.iconGrey,
                  size: 25
                  )
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}