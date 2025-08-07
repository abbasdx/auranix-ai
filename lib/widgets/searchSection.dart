import 'package:auranix_ai/pages/chat_page.dart';
import 'package:auranix_ai/services/chat_web_service.dart';
import 'package:auranix_ai/theme/colors.dart';
import 'package:auranix_ai/widgets/searchBarButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final queryController = TextEditingController(); // for backend 15 16 17 18 19 20
  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Auranix',
          style: GoogleFonts.ibmPlexMono(
            fontSize: 40,
            fontWeight: FontWeight.w400
          ),
        ),
        const SizedBox(height: 32,),

        Container(
          width: 700,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.searchBarBorder ,
              width: 1.5
            )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: queryController, //for backend 49
                  decoration: InputDecoration(
                    hintText: 'Search anything...',
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SearchBarbutton(
                      icon: Icons.auto_awesome_outlined,
                      text: 'Focus',
                    ),
                    const SizedBox(width: 12,),
                    SearchBarbutton(
                      icon: Icons.add_circle_outlined,
                      text: 'Attach',
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
                        ChatWebService().chat(queryController.text.trim());
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatPage(question: queryController.text.trim()),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.submitButton,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: const Icon(
                          Icons.arrow_forward, color: AppColors.background,size: 16,
                        ),
                      ),
                    )
                
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}