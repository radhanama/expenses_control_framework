import "entity_mapper.dart";
abstract class UserEntity with EntityMapper {
  @override
  final int? id;
  final int usuarioId;

  const UserEntity({this.id, required this.usuarioId});
}

