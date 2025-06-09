// lib/models/statistics/relatorio_comum.dart
//
// Concrete strategy that performs a straightforward aggregation:
//   • soma total de gastos
//   • soma por categoria
//
// Ships with the framework as a <<frozenspot>> implementation.

import '../gasto.dart';
import '../produto.dart';
import 'i_estrategia_estatistica.dart';
import 'estatistica_dto.dart';

class RelatorioComum implements IEstrategiaEstatistica {
  @override
  EstatisticaDTO gerarEstatistica(List<Gasto> gastos) {
    if (gastos.isEmpty) return EstatisticaDTO.vazio;

    double total = 0.0;
    final Map<String, double> porCategoria = {};

    for (final gasto in gastos) {
      final subtotal = gasto.produtos.isEmpty
          ? gasto.total
          : gasto.produtos.fold<double>(
              0.0, (sum, Produto p) => sum + p.calcularSubtotal());

      total += subtotal;

      porCategoria.update(
        gasto.categoria,
        (value) => value + subtotal,
        ifAbsent: () => subtotal,
      );
    }

    return EstatisticaDTO.fromRaw(total, porCategoria);
  }
}
