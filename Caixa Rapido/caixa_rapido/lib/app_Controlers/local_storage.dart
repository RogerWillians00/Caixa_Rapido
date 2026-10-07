import 'package:hive_flutter/hive_flutter.dart';

import '../models/saved_app_data.dart';

class LocalStorage {
  static const String _boxName = 'caixa_rapido';
  static const String _dataKey = 'app_data';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_boxName);
  }

  static Future<SavedAppData?> loadAppData() async {
    final value = Hive.box<String>(_boxName).get(_dataKey);
    if (value == null) return null;
    return SavedAppData.decode(value);
  }

  static Future<void> saveAppData(SavedAppData data) async {
    await Hive.box<String>(_boxName).put(_dataKey, data.encode());
  }
}
