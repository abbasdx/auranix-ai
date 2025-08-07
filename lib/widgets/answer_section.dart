import 'package:auranix_ai/services/chat_web_service.dart';
import 'package:auranix_ai/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatefulWidget {
  const AnswerSection({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  String fullResponse = '''
At the close of Day 1 in the fourth Test between India and Australia, the scoreboard reads **Australia 311/6**. This Boxing Day Test is underway at the iconic Melbourne Cricket Ground (MCG), dated December 26, 2024.

## Day 1 Summary
- **Toss Update**: Australia won the toss and elected to bat first.
- **Standout Performers**:
  - **Steve Smith** remains unbeaten on a composed **68 off 111 deliveries**, anchoring the innings.
  - **Sam Konstas**, debuting in Test cricket, impressed with a brisk **60 from 65 balls**, laying a solid foundation.
  - **Usman Khawaja** and **Marnus Labuschagne** also chipped in with crucial contributions to set up a strong total.

## Key Sessions
- The morning session saw Australia off to a solid start, posting **112/1**, with an opening stand of **89 runs** between Konstas and Khawaja before Konstas fell to **Ravindra Jadeja**.
- Post-lunch, Australia appeared in control at **223/2**, but a sudden collapse saw them slump to **263/5**. **Jasprit Bumrah** was instrumental in this turnaround, claiming vital middle-order wickets and reviving India's momentum.

## Indian Bowling Analysis
- **Jasprit Bumrah** led the Indian attack with a fiery spell in the afternoon, rattling the Australian middle order.
- **Ravindra Jadeja** struck early, removing the debutant Konstas and breaking the opening partnership.
- Contributions also came from **Akash Deep** and **Washington Sundar**, both picking up a wicket each to halt Australia's charge.

## Match Situation
As stumps were drawn on Day 1, Australia closed at **311/6**, with **Steve Smith** still at the crease. India will look to build on their late successes when play resumes on Day 2. The Test is delicately poised in the ongoing **Border-Gavaskar Trophy**, with both sides aiming to gain the upper hand as the match unfolds.
''';

 @override
  void initState() {
    super.initState();
    ChatWebService().contentStream.listen((data) {
      if (isLoading) {
        fullResponse = "";
      }
      setState(() {
        fullResponse += data['data'];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Auranix',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
        const SizedBox(height: 8),
        Skeletonizer(
          enabled: isLoading,
          child: Markdown(data: fullResponse,
          shrinkWrap: true,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            codeblockDecoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(10)
            ),
            code: const TextStyle(fontSize: 16)
          ),
          ),
        )
      ],
    );
  }
}