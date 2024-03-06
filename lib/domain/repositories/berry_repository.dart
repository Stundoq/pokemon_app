import 'package:flutter_tdd_clean_architecture_mvvm/domain/entities/berry_entities/berry_list_entity.dart';

abstract class BerryRepository {
  Future<BerryListEntity> getBerry({
    required String? url,
  });
}