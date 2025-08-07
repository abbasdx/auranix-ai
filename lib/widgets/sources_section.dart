import 'package:auranix_ai/services/chat_web_service.dart';
import 'package:auranix_ai/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {

  bool isLoading = true;
  List searchResults = [
  {
    "title": "July 2025: Earth Records Third-Hottest Month on Record",
    "url": "https://www.reuters.com/sustainability/cop/july-was-earths-third-hottest-record-included-record-turkey-eu-scientists-say-2025-08-07/"
  },
  {
    "title": "AI Action Summit in Paris: 200 Billion Dollar Invested in Global AI by EU & Partners",
    "url": "https://en.wikipedia.org/wiki/AI_Action_Summit"
  },
  {
    "title": "Malian Pro‑Democracy Protests Escalate in May 2025",
    "url": "https://en.wikipedia.org/wiki/2025_Malian_protests"
  }
];
@override
  void initState() {
    super.initState();
    ChatWebService().searchResultStream.listen((data) {
      setState(() {
        searchResults = data['data'];
        isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.source_outlined, color: Colors.white70,),
            SizedBox(width: 8,),
            Text("Sources",
            style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold
            ),)
          ],
        ),
        SizedBox(height: 16,),
        Skeletonizer(
          enabled: isLoading,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: searchResults.map((res) {
                  return InkWell( // ✅ Wrap Container with InkWell to make it tappable
                    onTap: () async {
                      final Uri uri = Uri.parse(res['url']); // ✅ Parse the URL
                      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) { // ✅ Open in browser
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not launch URL')),
                        );
                      }
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            res['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            res['url'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),

          ),
        )
      ],
    );
  }
}