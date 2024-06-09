import 'dart:convert';

class Governorate {
  final int id;

  final String name;
  static List<Governorate> governorates = governorateJson
      .map<Governorate>((element) => Governorate.fromJson(element))
      .toList();

  const Governorate({
    required this.id,
    required this.name,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        id: json['id'],
        name: json['name'],
      );
}

const governorateJson = [
  {"id": 1, "name": "القاهرة"},
  {"id": 2, "name": "الإسكندرية"},
  {"id": 3, "name": "البحيرة"},
  {"id": 4, "name": "بورسعيد"},
  {"id": 5, "name": "الإسماعيلية"},
  {"id": 6, "name": "الغربية"},
  {"id": 7, "name": "المنوفية"},
  {"id": 8, "name": "الدقهلية"},
  {"id": 9, "name": "كفر الشيخ"},
  {"id": 10, "name": "شمال سيناء"},
  {"id": 11, "name": "جنوب سيناء"},
  {"id": 12, "name": "السويس"},
  {"id": 13, "name": "الأقصر"},
  {"id": 14, "name": "أسوان"},
  {"id": 15, "name": "البحر الأحمر"},
  {"id": 16, "name": "سوهاج"},
  {"id": 17, "name": "قنا"},
  {"id": 18, "name": "الفيوم"},
  {"id": 19, "name": "بني سويف"},
  {"id": 20, "name": "المنيا"},
  {"id": 21, "name": "أسيوط"},
  {"id": 22, "name": "دمياط"},
  {"id": 23, "name": "الشرقية"},
  {"id": 24, "name": "الجيزة"},
  {"id": 25, "name": "الوادي الجديد"},
  {"id": 26, "name": "سومة القناطر"},
  {"id": 27, "name": "الأقصر"},
  {"id": 28, "name": "الوادي الجديد"},
  {"id": 29, "name": "أسوان"}
];
