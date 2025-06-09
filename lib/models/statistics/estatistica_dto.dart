// lib/models/statistics/estatistica_dto.dart
//
// Simple DTO shared by any strategy implementation.
// Feel free to extend or swap with more advanced fields later.

import '../gasto.dart';

class EstatisticaDTO {
  final double totalGastos;
  final Map<String, double> totalPorCategoria;

  const EstatisticaDTO({
    required this.totalGastos,
    required this.totalPorCategoria,
  });

  /// Very simple calculator: sum values, group by categoria.
  static EstatisticaDTO calcular(List<Gasto> gastos) {
    double total = 0;
    final mapa = <String, double>{};

    for (final g in gastos) {
      total += g.total;
      mapa.update(g.categoria, (v) => v + g.total, ifAbsent: () => g.total);
    }

    return EstatisticaDTO(totalGastos: total, totalPorCategoria: mapa);
  }

  // Helper factory used by the common report implementation
  factory EstatisticaDTO.fromRaw(
    double total,
    Map<String, double> porCategoria,
  ) =>
      EstatisticaDTO(
        totalGastos: total,
        totalPorCategoria: porCategoria,
      );

  /// Example “empty” instance (useful for initial state)
  static const vazio = EstatisticaDTO(totalGastos: 0, totalPorCategoria: {});
}
