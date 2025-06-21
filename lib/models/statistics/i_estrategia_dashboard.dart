// lib/models/statistics/i_estrategia_dashboard.dart
//
// Strategy contract (hot-spot).  Keeps framework agnostic of the concrete
// calculation logic.

import '../gasto.dart';
import 'dashboard_dto.dart';

abstract class IEstrategiaDashboard {
  /// Consumes a list of gastos and returns whatever metrics your
  /// UI/view-model needs.  May throw if the list is empty or malformed.
  DashboardDTO gerarEstatistica(List<Gasto> gastos);
}
