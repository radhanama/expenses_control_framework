// lib/data/gasto_repository.dart

import 'package:sqflite/sqflite.dart';
import '../models/gasto.dart';
import '../core/base/base_repository.dart';

class GastoRepository extends BaseRepository<Gasto> {
  GastoRepository(Database db)
      : super(
          database: db,
          fromMap: Gasto.fromMap,
        );
}
