// lib/core/statistics/i_estrategia_estatistica.dart
//
// Strategy contract (hot-spot).  Keeps framework agnostic of the concrete
// calculation logic.

import '../../models/gasto.dart';
import 'estatistica_dto.dart';

abstract class IEstrategiaEstatistica {
  /// Consumes a list of gastos and returns whatever metrics your
  /// UI/view-model needs.  May throw if the list is empty or malformed.
  EstatisticaDTO gerarEstatistica(List<Gasto> gastos);
}
