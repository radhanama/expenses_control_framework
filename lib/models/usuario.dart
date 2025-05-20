// lib/models/usuario.dart
//
// Domain entity that represents a user.  Implements EntityMapper so it can
// be persisted via BaseRepository<Usuario>.

import '../core/base/entity_mapper.dart';
import 'gasto.dart';
import '../core/statistics/estatistica_dto.dart'; // implement or swap for your own DTO

class Usuario with EntityMapper {
  // ─────────────────── Fields ───────────────────
  @override
  final String? id;
  final String nome;
  final String email;
  final String senhaHash; // stored hash, not plaintext

  /// Optional in-memory cache of gastos (usually loaded via repository).
  final List<Gasto> gastos;

  // ───────────────── Constructor ─────────────────
  const Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senhaHash,
    this.gastos = const [],
  });

  // ────────── EntityMapper contract ──────────
  @override
  String get tableName => 'usuarios';

  factory Usuario.fromMap(Map<String, dynamic> map) => Usuario(
        id: map['id']?.toString(),
        nome: map['nome'] as String? ?? '',
        email: map['email'] as String? ?? '',
        senhaHash: map['senha_hash'] as String? ?? '',
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'nome': nome,
        'email': email,
        'senha_hash': senhaHash,
      };

  // ───────── Domain helpers (as in UML) ─────────
  Usuario adicionarGasto(Gasto g) => copyWith(gastos: [...gastos, g]);

  List<Gasto> listarGastos() => List.unmodifiable(gastos);

  EstatisticaDTO verEstatisticas() =>
      EstatisticaDTO.calcular(gastos); // implement in your stats layer

  // ---------- copyWith ----------
  Usuario copyWith({
    String? id,
    String? nome,
    String? email,
    String? senhaHash,
    List<Gasto>? gastos,
  }) =>
      Usuario(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        senhaHash: senhaHash ?? this.senhaHash,
        gastos: gastos ?? this.gastos,
      );
}
