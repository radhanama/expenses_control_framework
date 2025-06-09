// lib/models/produto.dart
import 'base/entity_mapper.dart';

class Produto with EntityMapper {
  // ─────────────────── Campos ───────────────────
  @override
  final String? id; // null antes de persistir
  final String nome;
  final double preco;
  final int quantidade;

  // ───────────────── Construtor ─────────────────
  const Produto({
    this.id,
    required this.nome,
    required this.preco,
    required this.quantidade,
  });

  // ─────── Nome da tabela exigido pelo EntityMapper ───────
  @override
  String get tableName => 'produtos';

  // ───────────── Map ⇄ Entidade (ORM manual) ─────────────
  factory Produto.fromMap(Map<String, dynamic> map) => Produto(
        id: map['id']?.toString(),
        nome: map['nome'] as String? ?? '',
        preco: (map['preco'] as num?)?.toDouble() ?? 0.0,
        quantidade: (map['quantidade'] as num?)?.toInt() ?? 0,
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'nome': nome,
        'preco': preco,
        'quantidade': quantidade,
      };

  // ───────────────── Lógica de domínio ─────────────────
  /// preço * quantidade
  double calcularSubtotal() => preco * quantidade;

  /// Retorna uma nova instância com campos alterados (imutabilidade).
  Produto copyWith({
    String? id,
    String? nome,
    double? preco,
    int? quantidade,
  }) =>
      Produto(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        preco: preco ?? this.preco,
        quantidade: quantidade ?? this.quantidade,
      );

  /// Atualiza todos os campos de uma vez.
  Produto reescreverInformacoes(
    String novoNome,
    double novoPreco,
    int novaQuantidade,
  ) =>
      copyWith(
        nome: novoNome,
        preco: novoPreco,
        quantidade: novaQuantidade,
      );
}
