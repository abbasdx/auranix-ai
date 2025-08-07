import 'package:auranix_ai/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchBarbutton extends StatefulWidget {
  final IconData icon;
  final String text;

  const SearchBarbutton({
    super.key, required this.icon, required this.text
    });

  @override
  State<SearchBarbutton> createState() => _SearchBarbuttonState();
}

class _SearchBarbuttonState extends State<SearchBarbutton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event){
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isHovered? AppColors.proButton : Colors.transparent
        ),
        child: Row(
          children: [
            Icon(
              widget.icon, color: AppColors.iconGrey, size: 20,
            ),
            const SizedBox(width: 8,),
            Text(
              widget.text,
              style: TextStyle(color: AppColors.textGrey),
            )
          ],
        ),
      ),
    );
  }
}