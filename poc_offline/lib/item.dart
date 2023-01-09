import 'package:uuid/uuid.dart';
import 'file_type.dart';

class Item {
  final String id;
  final String url;
  final String name;
  final FileType type;

  Item({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
  });

  static List<Item> fromList(List list) =>
      List<Item>.from(list.map((item) => Item.fromJson(item)));

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: const Uuid().v1(),
      url: json['url'],
      name: json['name'],
      type: json['type'] == "image" ? FileType.image : FileType.pdf);
}
