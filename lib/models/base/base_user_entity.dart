import "entity_mapper.dart";

abstract class BaseUserEntity with EntityMapper {
  @override
  final int? id;
  final int usuarioId;

  const BaseUserEntity({this.id, required this.usuarioId});
}
