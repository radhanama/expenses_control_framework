// lib/models/categoria.dart
import 'base/entity_mapper.dart';

class Categoria with EntityMapper {
  // ────────────────── Campos ──────────────────
  @override
  final int? id; // PK (null antes de persistir)
  final String titulo;
  final String descricao;

  /// FK para hierarquia (null se for a raiz)
  final int? parentId;

  /// As subcategorias podem ser carregadas lazy a partir do BD,
  /// mas deixamos o campo aqui para operações em memória.
  final List<Categoria> subcategorias;

  // ───────────────── Construtor ─────────────────
  const Categoria({
    this.id,
    required this.titulo,
    required this.descricao,
    this.parentId,
    this.subcategorias = const [],
  });

  // ─────────── Nome da tabela (EntityMapper) ───────────
  @override
  String get tableName => 'categorias';

  // ───────────── Map ⇄ Entidade ─────────────
  factory Categoria.fromMap(Map<String, dynamic> map) => Categoria(
        id: map['id'] as int?,
        titulo: map['titulo'] as String? ?? '',
        descricao: map['descricao'] as String? ?? '',
        parentId: map['parent_id'] as int?,
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'titulo': titulo,
        'descricao': descricao,
        'parent_id': parentId,
      };

  // ───────────── Lógica de domínio ─────────────
  Categoria adicionarSubcategoria(Categoria c) =>
      copyWith(subcategorias: [...subcategorias, c.copyWith(parentId: id)]);

  Categoria removerSubcategoria(Categoria c) => copyWith(
      subcategorias: subcategorias.where((s) => s.id != c.id).toList());

  /// Ex.: "Financeiro > Despesas Fixas > Aluguel"
  String getDescricaoCompleta({String separator = ' > '}) {
    if (parentId == null) return titulo;
    // Caso a cadeia superior não esteja em memória, você buscaria no BD.
    // Aqui assumimos que subcategorias trazem seus pais completos.
    return '$titulo$separator${subcategorias.map((s) => s.titulo).join(separator)}';
  }

  // ---------- Helpers ----------
  Categoria copyWith({
    int? id,
    String? titulo,
    String? descricao,
    int? parentId,
    List<Categoria>? subcategorias,
  }) =>
      Categoria(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        descricao: descricao ?? this.descricao,
        parentId: parentId ?? this.parentId,
        subcategorias: subcategorias ?? this.subcategorias,
      );
}
