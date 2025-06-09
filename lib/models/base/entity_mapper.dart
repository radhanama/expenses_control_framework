/// lib/modelsbase/entity_mapper.dart
mixin EntityMapper {
  /// The DB table name that stores this entity.
  String get tableName;

  String? get id;
  Map<String, dynamic> toMap();
}
