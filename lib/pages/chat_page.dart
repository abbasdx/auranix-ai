import 'package:auranix_ai/theme/colors.dart';
import 'package:auranix_ai/widgets/answer_section.dart';
import 'package:auranix_ai/widgets/sideBar.dart';
import 'package:auranix_ai/widgets/sources_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({super.key,
  required this.question,
  });

  // StreamBuilder(stream: ChatWebService().contentStream, builder: (context, snapshot){
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          const SizedBox(width: 100,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question, style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 24,),
                    // sources
                    SourcesSection(),
                    // answer section
                    SizedBox(height: 16,),
                    AnswerSection()
                  ],
                ),
              ),
            ),
          ),
          kIsWeb ? Placeholder(
            strokeWidth: 0,
            color: AppColors.background,
          ) : SizedBox()
        ],
      ),
    );
  }
}