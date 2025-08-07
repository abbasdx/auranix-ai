// String? extractFirstImageUrlFromSources(List<Map<String, dynamic>> sources) {
//   for (var source in sources) {
//     final content = source['content'] ?? '';
//     final regex = RegExp(r'(https?:\/\/.*\.(?:png|jpg|jpeg|webp|gif))', caseSensitive: false);
//     final match = regex.firstMatch(content);
//     if (match != null) {
//       return match.group(0); // return the first image URL found
//     }
//   }
//   return null;
// }

