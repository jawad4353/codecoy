


import 'package:intl/intl.dart';

class StringFormatting{
static String formatRegistrationDate({required String date}){
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd MMMM, yyyy').format(dateTime);
  return formattedDate;
}

static String capitalizeAfterSpace(String str) {
  List<String> words = str.split(' ');
  for (int i = 0; i < words.length; i++) {
    words[i] = words[i].toLowerCase().splitMapJoin(
      RegExp(r'^\w'),
      onMatch: (match) => match.group(0)!.toUpperCase(),
      onNonMatch: (nonMatch) => nonMatch,
    );
  }
  return words.join(' ');
}
}