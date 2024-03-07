import 'package:hive_flutter/adapters.dart';
import '../../../domain/entities/berry_entities/berry_item_entity.dart';
import '../../../domain/entities/berry_entities/berry_list_entity.dart';
part 'berry_list_model.g.dart';


class BerryListModel {
  final int count;
  final String? next;
  final String? previous;
  final List<BerryItem> results;

  BerryListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BerryListModel.fromJson(Map<String, dynamic> json) => BerryListModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<BerryItem>.from(json["results"].map((x) => BerryItem.fromJson(x))),
  );

  BerryListEntity convertToEntity() {
    return BerryListEntity(
      next: next,
      berries: results,
    );
  }
}

@HiveType(typeId: 1)
class BerryItem extends BerryItemEntity{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  const BerryItem({
    required this.name,
    required this.url,
  }):super(name: name,url: url);

  factory BerryItem.fromJson(Map<String, dynamic> json) => BerryItem(
    name: json["name"],
    url: json["url"],
  );

  BerryItemEntity convertToEntity() {
    return BerryItemEntity(
      url: url,
      name: name,
    );
  }
}
