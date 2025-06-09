// lib/models/gasto.dart
import 'base/entity_mapper.dart';
import 'produto.dart';

class Gasto with EntityMapper {
  // ---------------------------------------------------------------------------
  // Fields
  // ---------------------------------------------------------------------------
  @override
  final String? id; // nullable because it’s null before insert
  final double total; // cached total; you can recompute if you want
  final DateTime data;
  final String categoria;
  final String local;

  // Not persisted in the same “gastos” table. You’ll likely store produtos
  // in a separate table and join later, but we keep the field here for domain
  // logic and in-memory calculations.
  final List<Produto> produtos;

  // ---------------------------------------------------------------------------
  // Constructor
  // ---------------------------------------------------------------------------
  const Gasto({
    this.id,
    required this.total,
    required this.data,
    required this.categoria,
    required this.local,
    this.produtos = const [],
  });

  // ---------------------------------------------------------------------------
  // Domain helpers (optional)
  // ---------------------------------------------------------------------------
  Gasto copyWith({
    String? id,
    double? total,
    DateTime? data,
    String? categoria,
    String? local,
    List<Produto>? produtos,
  }) =>
      Gasto(
        id: id ?? this.id,
        total: total ?? this.total,
        data: data ?? this.data,
        categoria: categoria ?? this.categoria,
        local: local ?? this.local,
        produtos: produtos ?? this.produtos,
      );

  // ---------------------------------------------------------------------------
  // EntityMapper implementation
  // ---------------------------------------------------------------------------

  /// Converts entity → DB row
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'total': total,
        'data': data.toIso8601String(),
        'categoria': categoria,
        'local': local,
      };

  /// Converts a DB row → entity
  factory Gasto.fromMap(Map<String, dynamic> map) => Gasto(
        id: map['id']?.toString(),
        total: (map['total'] as num?)?.toDouble() ?? 0.0,
        data: DateTime.parse(map['data'] as String), // ISO-8601 stored
        categoria: map['categoria'] as String? ?? '',
        local: map['local'] as String? ?? '',
      );

  /// Recomputes total from the embedded list, if you opt to keep it in memory.
  double calcularTotal() => produtos.isEmpty
      ? total
      : produtos.fold<double>(0.0, (sum, p) => sum + p.calcularSubtotal());

  /// Returns a **new** Gasto with an extra product (immutability pattern).
  Gasto adicionarProduto(Produto p) {
    final novaLista = List<Produto>.from(produtos)..add(p);
    final novoTotal =
        novaLista.fold<double>(0.0, (s, p) => s + p.calcularSubtotal());
    return copyWith(produtos: novaLista, total: novoTotal);
  }

  @override
  String get tableName => "gasto";
}
