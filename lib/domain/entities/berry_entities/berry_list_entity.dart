import 'package:equatable/equatable.dart';
import 'berry_item_entity.dart';

class BerryListEntity extends Equatable {
  final String? next;
  final List<BerryItemEntity> berries;

  const BerryListEntity({required this.next, required this.berries});

  @override
  List<Object?> get props => [berries];
}
