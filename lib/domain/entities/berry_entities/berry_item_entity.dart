import 'package:equatable/equatable.dart';

class BerryItemEntity extends Equatable {
  final String name;
  final String url;

  const BerryItemEntity({required this.name, required this.url});

  @override
  List<Object?> get props => [name,url];
}
