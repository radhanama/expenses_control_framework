// lib/models/nota_fiscal.dart
import 'dart:io'; // File for the image path
import 'base/entity_mapper.dart';
import 'produto.dart';

class NotaFiscal with EntityMapper {
  // ─────────────────── Campos ───────────────────
  @override
  final int? id; // null antes do insert
  final File? imagem; // imagem no storage local (opcional)
  final String textoExtraido; // OCR completo já limpo

  // ───────────────── Construtor ─────────────────
  const NotaFiscal({
    this.id,
    this.imagem,
    required this.textoExtraido,
  });

  // ─────── Nome da tabela exigido pelo EntityMapper ───────
  @override
  String get tableName => 'notas_fiscais';

  // ───────────── Map ⇄ Entidade ─────────────
  factory NotaFiscal.fromMap(Map<String, dynamic> map) => NotaFiscal(
        id: map['id'] as int?,
        imagem: map['imagem_path'] != null &&
                (map['imagem_path'] as String).isNotEmpty
            ? File(map['imagem_path'] as String)
            : null,
        textoExtraido: map['texto_extraido'] as String? ?? '',
      );

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        // gravamos apenas o path para não armazenar binário no SQLite
        'imagem_path': imagem?.path,
        'texto_extraido': textoExtraido,
      };

  // ───────────── Lógica de domínio ─────────────
  /// **Stub** – aqui você chamaria um serviço de OCR
  Future<NotaFiscal> processarOCR() async {
    // TODO: integrar com o pacote de OCR e popular textoExtraido
    return this;
  }

  /// **Stub** – parseia `textoExtraido` e cria lista de produtos
  List<Produto> extrairProdutos() {
    // TODO: regex/IA para encontrar nome, preço, etc.
    return <Produto>[];
  }

  // ---------- helpers ----------
  NotaFiscal copyWith({
    int? id,
    File? imagem,
    String? textoExtraido,
  }) =>
      NotaFiscal(
        id: id ?? this.id,
        imagem: imagem ?? this.imagem,
        textoExtraido: textoExtraido ?? this.textoExtraido,
      );
}
